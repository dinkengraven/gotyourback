require 'rails_helper'

RSpec.describe Trip, type: :model do
  let!(:trip) { Trip.new(location: "Big South Fork, TN", duration_in_days: 7, route: "Day 1: Point A to Point B, Day 2: Point B to Point C, Day 3: Point C to Point D, etc.") }

  it "has a location" do
    expect(trip.location).to eq("Big South Fork, TN")
  end

  it "has a duration specified in number of days" do
    expect(trip.duration_in_days).to eq(7)
  end

  it "has a route" do
    expect(trip.route).to eq("Day 1: Point A to Point B, Day 2: Point B to Point C, Day 3: Point C to Point D, etc.")
  end
end
