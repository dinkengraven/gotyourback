class Trip < ActiveRecord::Base
  # belongs_to :creator, class_name: "User", foreign_key: :creator_id
  validates :location, :duration_in_days, :route, presence: true
end
