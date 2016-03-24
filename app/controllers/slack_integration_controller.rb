class SlackIntegrationController < ApplicationController
  def index
    SlackBotSetup.call(params[:code])
    render status: 200, json: { ok: "true" }
  rescue SlackBotSetup::SlackIntegrationError => e
    render status: 500, json: { ok: "false", slack_error: e.message }
  end
end
