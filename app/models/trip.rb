class Trip < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  validates :location, :duration_in_days, :route, presence: true
end
