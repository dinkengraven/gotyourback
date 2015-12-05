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

    it "returns false if incorrect password is given" do
      expect(user.authenticate("wordpass")).to be_falsey
    end
  end

  describe "User validations" do
    let!(:user) { User.create(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "password") }

    it "is invalid without an email address" do
      user_2 = User.new(first_name: "Alison", last_name: "Anderson", password: "password")
      user_2.save
      expect(user_2.errors.full_messages).to include("Email can't be blank")
    end

    it "is invalid without a unique email address" do
      user_2 = user.dup
      user_2.save
      expect(user_2.errors.full_messages).to include("Email has already been taken")
    end

    it "is invalid without a first name" do
      user_2 = User.new(last_name: "Smith", email: "smith@email.com", password: "password", username: "smithy", location: "Spokane, WA")
      user_2.save
      expect(user_2.errors.full_messages).to include("First name can't be blank")
    end

    it "is invalid without a last name" do
      user_2 = User.new(first_name: "Smith", email: "smith@email.com", password: "password", username: "smithy", location: "Spokane, WA")
      user_2.save
      expect(user_2.errors.full_messages).to include("Last name can't be blank")
    end

    it "is invalid without a username" do
      user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", password: "password", location: "Spokane, WA")
      user_2.save
      expect(user_2.errors.full_messages).to include("Username can't be blank")
    end
    # it "validates format of user's email address" do
    #
    # end
  end
end
