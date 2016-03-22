module Events
  class IssueEventParser
    def parse(payload)
      IssueEvent.create do |issue|
        issue.action = payload.dig("action")
        issue.name = payload.dig("issue", "title")
        issue.number = payload.dig("issue", "number").to_i
        issue.actor = payload.dig("sender", "login")
        issue.repository = payload.dig("repository", "name")
        issue.organization = payload.dig("organization", "login")
      end
    end
  end
end
