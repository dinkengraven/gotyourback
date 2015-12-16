# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, username: Faker::Internet.user_name, location: Faker::Address.state, password: "123456")
end

User.find(1).created_trips.create(location: "Big South Fork, TN", duration_in_days: 7, route: Faker::Lorem.paragraph(4), details: Faker::Lorem.paragraph(3))

User.find(2).created_trips.create(location: "Yellowstone", duration_in_days: 10, route: Faker::Lorem.paragraph(4), details: Faker::Lorem.paragraph(3))

User.find(3).created_trips.create([{location: "Ice Age Trail", duration_in_days: 12, route: Faker::Lorem.paragraph(4), details: Faker::Lorem.paragraph(3)}, {location: "Pacific Crest Trail", duration_in_days: 21, route: Faker::Lorem.paragraph(4), details: Faker::Lorem.paragraph(3)}])

User.find(1).joined_trips << Trip.first

User.find(2).joined_trips << Trip.find(2)

User.find(3).joined_trips << Trip.find(3)
User.find(3).joined_trips << Trip.find(4)

User.find(4).joined_trips << Trip.first

User.find(5).joined_trips << Trip.first
