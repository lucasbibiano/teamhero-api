module Events
  class CommentEventParser
    def parse(payload)
      CommentEvent.create do |comment|
        comment.body = payload.dig("comment", "body")
        comment.issue = payload.dig("issue", "number").to_i
        comment.actor = payload.dig("sender", "login")
        comment.repository = payload.dig("repository", "name")
        comment.organization = payload.dig("organization", "login")
      end
    end
  end
end
