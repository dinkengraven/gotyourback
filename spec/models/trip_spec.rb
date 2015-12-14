require 'rails_helper'

RSpec.describe Trip, type: :model do
  let!(:trip) { Trip.new(location: "Big South Fork, TN", duration_in_days: 7, route: "Day 1: Point A to Point B, Day 2: Point B to Point C, Day 3: Point C to Point D, etc.", details: "If the weather cooperates, plan on sleeping under the big tarp! It weighs less than each of us carrying a tent.") }

  it "has a location" do
    expect(trip.location).to eq("Big South Fork, TN")
  end

  it "has a duration specified in number of days" do
    expect(trip.duration_in_days).to eq(7)
  end

  it "has a route" do
    expect(trip.route).to eq("Day 1: Point A to Point B, Day 2: Point B to Point C, Day 3: Point C to Point D, etc.")
  end

  it "has details" do
    expect(trip.details).to eq("If the weather cooperates, plan on sleeping under the big tarp! It weighs less than each of us carrying a tent.")
  end

  describe "validations" do
    it "is invalid without a location" do
      trip.location = nil
      trip.save
      expect(trip.errors.full_messages).to eq(["Location can't be blank"])
    end

    it "is invalid without a duration" do
      trip.duration_in_days = nil
      trip.save
      expect(trip.errors.full_messages).to eq(["Duration in days can't be blank"])
    end

    it "is invalid without a route" do
      trip.route = nil
      trip.save
      expect(trip.errors.full_messages).to eq(["Route can't be blank"])
    end
  end

  describe "associations" do
    let!(:user) { User.create(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "super secure") }

    it "belongs to a creator" do
      trip.save
      user.created_trips << trip
      expect(user.created_trips).to eq([trip])
    end
  end
end
