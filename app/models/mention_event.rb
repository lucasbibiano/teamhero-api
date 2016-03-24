class MentionEvent < ApplicationRecord
  belongs_to :slack_message
end
