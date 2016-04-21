class GithubWorker
  include Sidekiq::Worker

  def perform(repository, token)
    gh_data = Services::GithubRepositoryReader.call(repository, token)

    gh_data.each do |key, value|
      Object.const_get("Models::#{key}").destroy_all
      Object.const_get("Models::#{key}").create(value)
    end
  end
end
