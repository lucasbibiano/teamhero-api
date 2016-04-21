require 'zip'
require 'json'
require 'date'

module Services
  class SlackExportReader
    def initialize(filepath)
      @filepath = filepath
    end

    def process
      result = []

      Zip::File.open(@filepath) do |zipfile|
        generate_id_to_user(zipfile.glob('users.json').first.get_input_stream.read)

        result = zipfile.map do |entry|
          if entry.name.end_with?('.json') && entry.name.include?("/")
            content = entry.get_input_stream.read
            next process_chat(entry.name, content)
          end
        end.flatten
      end

      result
    end

    def self.call(file)
      new(file).process
    end

    private

    def process_chat(filename, content)
      chat = JSON.parse(content)
      channel, date = filename.split(/[\/.]/)

      chat.map do |entry|
        next nil if entry["subtype"]
        {
          user: id_to_user(entry["user"]),
          date: date,
          channel: channel,
          text: entry["text"],
          mentions: extract_mentions(entry["text"]),
          links: extract_links(entry["text"]),
          attention_channel_used: extract_channel_attention(entry["text"])
        }
      end.compact
    end

    def generate_id_to_user(content)
      return @id_to_user if @id_to_user

      users = JSON.parse(content)

      @id_to_user = users.inject({}) do |result, user|
                      result.merge(user["id"] => user["name"])
                    end.merge("@USLACKBOT" => "slackbot")
    end

    def id_to_user(id)
      @id_to_user[id]
    end

    def extract_mentions(text)
      mentions_ids = text.scan(/<(\S+)>/).flatten

      mentions_ids.map do |id|
        id_to_user(id[1..-1])
      end.compact.uniq
    end

    def extract_links(text)
      links = text.scan(/<(\S+)>/).flatten

      links.map do |link|
        link unless id_to_user(link[1..-1]) || link[0] == "#" || %w[!channel !group !here|@here].include?(link)
      end.compact
    end

    def extract_channel_attention(text)
      mentions_ids = text.scan(/<(\S+)>/).flatten
      mentions_ids.any? { |mention| %w[!channel !group !here|@here].include?(mention) }
    end

    def ts_to_time(timestamp)
      DateTime.strptime(timestamp, '%s')
    end
  end
end
