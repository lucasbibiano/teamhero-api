class Api::V1::PullRequestsController < Api::ApiController
  protected

  def event_type
    :pull_request
  end
end
