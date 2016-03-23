module Events
  class PullRequestEventParser
    def parse(payload)
      PullRequestEvent.create do |pr|
        pr.action = payload.dig("event", "action")
        pr.name = payload.dig("pull_request", "title")
        pr.number = payload.dig("pull_request", "number").to_i
        pr.from = payload.dig("pull_request", "head", "ref")
        pr.to = payload.dig("pull_request", "base", "ref")
        pr.actor = payload.dig("sender", "login")
        pr.repository = payload.dig("repository", "name")
        pr.organization = payload.dig("organization", "login")
      end
    end
  end
end
