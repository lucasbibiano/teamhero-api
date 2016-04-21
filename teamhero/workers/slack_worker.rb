class SlackWorker
  include Sidekiq::Worker

  def perform(path)
    messages = Services::SlackExportReader.call(path)

    Models::Message.destroy_all
    Models::Message.create(messages)

    File.delete(path)
  end
end
