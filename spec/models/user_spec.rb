require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "password") }

  it "has a first name" do
    expect(user.first_name).to eq("Letha")
  end

  it "has a last name" do
    expect(user.last_name).to eq("Rutherford")
  end

  it "has a username" do
    expect(user.username).to eq("augustus")
  end

  it "has an email address" do
    expect(user.email).to eq("lrutherford@langworth.net")
  end

  it "has a location" do
    expect(user.location).to eq("Yarmouth, ME")
  end

  it "has a password_digest" do
    expect(user.password_digest).to be_truthy
  end

  describe "User#authenticate" do
    it "can authenticate its own password" do
      expect(user.authenticate("password")).to eq(user)
    end
  end
end
