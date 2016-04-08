class Api::ApiController < ApplicationController
  before_action :search_params

  def index
    render json: {
      "#{event_type.to_s.pluralize}_events": event_klass.where(search_params).all
    }
  end

  def count
    render json: {
      count: event_klass.where(search_params).count
    }
  end

  protected

  def search_params
    @search_params ||= params.select { |_, value| !value.blank? }.permit(search_keys)
  end

  def search_keys
    %i[organization repository actor]
  end

  def event_klass
    "#{event_type.to_s.classify}Event".constantize
  end
end
