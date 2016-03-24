require 'uri'

class TeamheroListener
  include Sidekiq::Worker

  PING = 42

  def perform(token)
    @rtm_client = Slack::RealTime::Client.new(websocket_ping: PING, token: token)
    @slack_client = @rtm_client.web_client

    @rtm_client.on :message do |data|
      message = SlackMessage.create do |message|
        message.body = data.text
        message.channel_id = data.channel
        message.actor = data.user
        message.team_id = data.team
        message.shared_link = shared_link?(data.text)
      end

      extract_mentions!(message)
      create_convertions!(message)
    end

    @rtm_client.start!
  end

  private

  def create_convertions!(message)
    create_team_convertion(message.team_id)
    create_group_convertion(message.channel_id)
    create_user_convertion(message.actor)
  end

  def create_team_convertion(id)
    return if SlackIdToName.find_by(slack_id: id)
    team_info = @slack_client.team_info(team: id).dig("team")
    SlackIdToName.create(slack_id: id, name: team_info.name) if team_info
  end

  def create_group_convertion(id)
    return if SlackIdToName.find_by(slack_id: id)
    group_info = begin
                   @slack_client.groups_info(channel: id).dig("group")
                 rescue
                   @slack_client.channels_info(channel: id).dig("channel")
                 end
    SlackIdToName.create(slack_id: id, name: group_info.name) if group_info
  end

  def create_user_convertion(id)
    return if SlackIdToName.find_by(slack_id: id)
    user_info = @slack_client.users_info(user: id).dig("user")
    SlackIdToName.create(slack_id: id, name: user_info.name) if user_info
  end

  def extract_mentions!(message)
    text = message.body
    mentions_ids = text.scan(/<(\S+)>/).flatten

    mentions_ids.each do |mentioned_id|
      mention = MentionEvent.create do |mention|
        mention.mentioned_id = mentioned_id[1..-1]
        mention.slack_message_id = message.id
      end

      create_user_convertion(mention.mentioned_id)
    end
  end

  def shared_link?(text)
    #cat images and funny gifs doesn't count as shared links
    blacklisted_extensions = %w[.jpg .jpeg .png .gif .mp4]

    !text.scan(/<(\S+)>/).flatten.reject do |link|
      !is_url?(link) || blacklisted_extensions.any? { |ext| link.end_with?(ext) }
    end.empty?
  end

  def is_url?(url)
    url =~ URI::regexp
  end
end
