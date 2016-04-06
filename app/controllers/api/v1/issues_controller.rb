class Api::V1::IssuesController < Api::ApiController

  protected

  def event_type
    :issue
  end
end
