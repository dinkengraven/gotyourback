class Trip < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  has_many :groups
  has_many :members, through: :groups, source: :user
  validates :location, :duration_in_days, :route, presence: true
end
