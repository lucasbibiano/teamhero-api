class Api::ApiController < ApplicationController
  before_action :search_params

  def search_params
    @search_params ||= params.select { |_, value| !value.blank? }.permit(search_keys)
  end

  def search_keys
    %i[organization repository actor]
  end
end
