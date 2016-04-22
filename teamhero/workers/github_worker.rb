class GithubWorker
  include Sidekiq::Worker

  def perform(repository, token)
    gh_data = Services::GithubRepositoryReader.call(repository, token)

    gh_data.each do |key, value|
      "models/#{key}".classify.constantize.destroy_all
      "models/#{key}".classify.constantize.create(value)
    end
  end
end
