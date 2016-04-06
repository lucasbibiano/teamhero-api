class Api::V1::CommentsController < Api::ApiController
  protected
  def event_type
    :comment
  end
end
