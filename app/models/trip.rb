class Trip < ActiveRecord::Base
  # belongs_to :creator, class_name: "User", foreign_key: :creator_id
  validates :location, presence: true
end
