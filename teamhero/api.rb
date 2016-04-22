module Teamhero
  class API < Grape::API
    format :json

    helpers do
      def get_model(str)
        "models/#{str}".camelize.constantize
      rescue NameError
        error! "Not found", 404
      end

      def logger
        API.logger
      end
    end

    resource :events do

      params do
        optional :author, desc: "The author of the event"
      end
      get ":type" do
        since = params.delete(:since)
        before = params.delete(:before)
        type = params.delete(:type)

        get_model(type).since(since).before(before).where(params).all
      end

    end

    resource :count do

      params do
        optional :author, desc: "The author of the event"
      end
      get ":type" do
        since = params.delete(:since)
        before = params.delete(:before)
        type = params.delete(:type)

        get_model(type).since(since).before(before).where(params).count
      end

    end

    resource :update do

      params do
        requires :slack_report, type: File, desc: "Slack export report zip file"
      end
      post "/slack" do
        filename = params[:slack_report].tempfile.path + 'x'

        File.open(filename, 'wb') do |file|
          file.write(params[:slack_report].tempfile.read)
        end

        SlackWorker.perform_async(filename)
        { success: "ok...importing slack file" }
      end

      params do
        optional :github_access_token, type: String, desc: "A access token capable of reading the desired repository (if private)"
        requires :repository, type: String, desc: "The full name (organization/repository-name) of the repository to read"
      end
      get "/github" do
        GithubWorker.perform_async(params[:repository], params[:github_access_token])
        { success: "ok...importing github history" }
      end

    end
  end
end
