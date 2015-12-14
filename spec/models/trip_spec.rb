require 'rails_helper'

RSpec.describe Trip, type: :model do
  let!(:trip) { Trip.new(location: "Big South Fork, TN") }

  it "has a location" do
    expect(trip.location).to eq("Big South Fork, TN")
  end
end
