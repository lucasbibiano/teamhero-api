module Events
  class PushEventParser
    def parse(payload)
      parse_commits(payload)
    end

    private

    def parse_commits(payload)
      commits = payload.dig("commits")

      ApplicationRecord.transaction do
        commits.each do |commit|
          CommitEvent.create do |event|
            event.repository = payload.dig("repository", "name")
            event.organization = payload.dig("organization", "login")
            event.message = commit.dig("message")
            event.author = commit.dig("author", "username")
            event.committer = commit.dig("committer", "username")
            event.added_files = commit.dig("added").join(",")
            event.removed_files = commit.dig("removed").join(",")
            event.modified_files = commit.dig("modified").join(",")
          end
        end
      end
    end
  end
end
