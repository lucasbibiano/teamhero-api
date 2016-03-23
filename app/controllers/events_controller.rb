class EventsController < ApplicationController
  def index
    render status: 200, json: (IssueEvent.all + PullRequestEvent.all + CommentEvent.all).to_json
  end

  def create
    EventParser.call(request.headers['x-github-event'], params)

    render status: 200, json: { ok: 200 }
  end
end
