class EventParser

  def initialize(event_type, payload)
    @event_type = event_type
    @payload = payload
  end

  def call
    if @event_type == 'issues'
      Events::IssueEventParser.new.parse(@payload)
    elsif @event_type == 'pull_request'
      Events::PullRequestEventParser.new.parse(@payload)
    end

  end

  def self.call(event_type, payload)
    EventParser.new(event_type, payload).call
  end
end
