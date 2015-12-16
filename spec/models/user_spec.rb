require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { User.new(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "super secure") }

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
      expect(user.authenticate("super secure")).to eq(user)
    end

    it "returns false if incorrect password is given" do
      expect(user.authenticate("wordpass")).to be_falsey
    end
  end

  describe "Validations on User" do
    let!(:user) { User.create(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "super secure") }

    let!(:user_2) { User.new(first_name: "Alison", last_name: "Anderson", username: "aanderson", email: "ali@example.com", location: "Marquette, MI", password: "super secure") }

    context "email validations" do
      it "is invalid without an email address" do
        user_2.email = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
      end

      it "is invalid without a unique email address" do
        user_copy = user.dup
        user_copy.username = "janus"
        user_copy.save
        expect(user_copy.errors.full_messages).to eq(["Email has already been taken"])
      end

      it "validates format of user's email address" do
        user_2.email = "smith_at_email.com"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Email is invalid"])
      end
    end

    context "first and last name validations" do
      it "is invalid without a first name" do
        user_2.first_name = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["First name can't be blank"])
      end

      it "is invalid without a last name" do
        user_2.last_name = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Last name can't be blank"])
      end
    end

    context "username validations" do
      it "is invalid without a username" do
        user_2.username = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username can't be blank", "Username is too short (minimum is 4 characters)"])
      end

      it "is invalid without a unique username" do
        user_2.username = "augustus"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username has already been taken"])
      end

      it "requires a username that is at least 4 characters" do
        user_2.username = "smi"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username is too short (minimum is 4 characters)"])
      end

      it "requires a username that is no more than 12 characters" do
        user_2.username = "smith_laura_backpacker"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username is too long (maximum is 12 characters)"])
      end
    end

    context "password validations" do
      it "is invalid without a password" do
        user_2.password = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password can't be blank"])
      end

      it "must have a password that is at least 6 characters long" do
        user_2.password = " "
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password is too short (minimum is 6 characters)"])
      end

      it "must have a password that is less than 25 characters long" do
        user_2.password = "abcdefghijklmnopqrstuvwzy"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password is too long (maximum is 24 characters)"])
      end

      it "cannot be the word 'password'" do
        user_2.password = "password"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password cannot be 'password'"])
      end
    end

    it "is invalid without a location" do
      user_2.location = nil
      user_2.save
      expect(user_2.errors.full_messages).to eq(["Location can't be blank"])
    end
  end

  describe "associations" do
    let!(:user) { User.create(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "super secure") }

    context "with trips" do
      it "has created trips" do
        user.created_trips.create(location: "Yellowstone", duration_in_days: "10", route: "Route", details: "Details")
        expect(user.created_trips.count).to eq(1)
      end
    end

  end
end
