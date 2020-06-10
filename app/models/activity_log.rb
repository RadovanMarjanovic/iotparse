class ActivityLog < ApplicationRecord
  validates :activity, inclusion: { in: ["logged in", "logged out"] }

  belongs_to :user
end

