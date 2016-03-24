class SlackIdToName < ApplicationRecord
  def self.convert(slack_id)
    find_by(slack_id: slack_id).name
  end
end
