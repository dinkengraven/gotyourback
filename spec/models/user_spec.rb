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

  describe "Validations on User" do
    let!(:user) { User.create(first_name: "Letha", last_name: "Rutherford", username: "augustus", email: "lrutherford@langworth.net", location: "Yarmouth, ME", password: "password") }

    let!(:user_2) { user_2 = User.new(first_name: "Alison", last_name: "Anderson", username: "aanderson", email: "ali@example.com", location: "Marquette, MI", password: "password") }

    context "email validations" do
      it "is invalid without an email address" do
        user_2.email = nil
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Email can't be blank", "Email is invalid"])
      end

      it "is invalid without a unique email address" do
        user_2 = user.dup
        user_2.username = "janus"
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Email has already been taken"])
      end

      it "validates format of user's email address" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith_at_email.com", username: "smithy", password: "password", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Email is invalid"])
      end
    end

    context "first and last name validations" do
      it "is invalid without a first name" do
        user_2 = User.new(last_name: "Smith", email: "smith@email.com", password: "password", username: "smithy", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["First name can't be blank"])
      end

      it "is invalid without a last name" do
        user_2 = User.new(first_name: "Smith", email: "smith@email.com", password: "password", username: "smithy", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Last name can't be blank"])
      end
    end

    context "username validations" do
      it "is invalid without a username" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", password: "password", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username can't be blank", "Username is too short (minimum is 4 characters)"])
      end

      it "is invalid without a unique username" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", username: "augustus", password: "password", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username has already been taken"])
      end

      it "requires a username that is at least 4 characters" do
        user_2 = User.new(first_name: "Laura", last_name: "Smith", email: "smithy@email.com", username: "smi", password: "password", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username is too short (minimum is 4 characters)"])
      end

      it "requires a username that is no more than 12 characters" do
        user_2 = User.new(first_name: "Laura", last_name: "Smith", email: "smithy@email.com", username: "smith_laura_backpacker", password: "password", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Username is too long (maximum is 12 characters)"])
      end
    end

    context "password validations" do
      it "is invalid without a password" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", username: "smithy", location: "Spokane, WA")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password can't be blank", "Password is too short (minimum is 6 characters)"])
      end

      it "must have a password that is at least 6 characters long" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", username: "smithy", location: "Spokane, WA", password: " ")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password is too short (minimum is 6 characters)"])
      end

      it "must have a password that is less than 25 characters long" do
        user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", username: "smithy", location: "Spokane, WA", password: "abcdefghijklmnopqrstuvwzy")
        user_2.save
        expect(user_2.errors.full_messages).to eq(["Password is too long (maximum is 24 characters)"])
      end
    end

    it "is invalid without a location" do
      user_2 = User.new(first_name: "Hank", last_name: "Smith", email: "smith@email.com", password: "password", username: "smithy")
      user_2.save
      expect(user_2.errors.full_messages).to eq(["Location can't be blank"])
    end

  end
end
