class Api::V1::CommentsController < Api::ApiController
  def index
    render json: {
      comment_events: CommentEvent.where(search_params).all
    }
  end

  def count
    render json: {
      count: CommentEvent.where(search_params).count
    }
  end
end
