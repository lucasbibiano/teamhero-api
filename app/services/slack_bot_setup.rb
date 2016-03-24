class SlackBotSetup
  SlackIntegrationError = Class.new(StandardError)

  def initialize(code)
    @code = code
  end

  def call
    response = JSON.parse(
      RestClient.get('https://slack.com/api/oauth.access', params: {
        code: @code,
        client_id: ENV['SLACK_CLIENT_ID'],
        client_secret: ENV['SLACK_CLIENT_SECRET']
      })
    )

    raise SlackIntegrationError.new(response["error"]) if response["error"]

    SlackSetting.create do |setting|
      setting.bot_access_token = response.dig("bot", "bot_access_token")
      setting.bot_user_id = response.dig("bot", "bot_user_id")
      setting.team_id = response.dig("team_id")
    end

    TeamheroListener.perform_async(response.dig("bot", "bot_access_token"))
  end

  def self.call(code)
    SlackBotSetup.new(code).call
  end
end
