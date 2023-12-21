require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe 'saves with valid attributes' do
      it 'is valid' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).to be_valid
      end
    end

    describe 'without a password' do
      it 'is not valid, password required' do
        user = User.new(
          email: 'rach@rach.com',
          password_confirmation: 'password',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password can't be blank")
      end
    end

    describe 'when password and password_confirmation do not match' do
      it 'is not valid, passwords do not match' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'NOTpassword',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
    end

    describe 'without an email' do
      it 'is not valid, email required' do
        user = User.new(
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Email can't be blank")
      end
    end

    describe 'with a duplicate email (case-insensitive)' do
      it 'is not valid, user already exists' do
        User.create!(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        user = User.new(
          email: 'RACH@RACH.com', # should be considered a duplicate
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Jane',
          last_name: 'Doe'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Email has already been taken")
      end
    end

    describe 'without a first name' do
      it 'is not valid, first name required' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'password',
          last_name: 'Little'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("First name can't be blank")
      end
    end

    describe 'without a last name' do
      it 'is not valid, last name required' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Rachel'
        )
        expect(user).to_not be_valid
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe 'with a password of minimum length' do
      it 'is valid' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'password',
          password_confirmation: 'password',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).to be_valid
      end
    end

    describe 'with a password shorter than the minimum length' do
      it 'is not valid' do
        user = User.new(
          email: 'rach@rach.com',
          password: 'pass',
          password_confirmation: 'pass',
          first_name: 'Rachel',
          last_name: 'Little'
        )
        expect(user).not_to be_valid
        expect(user.errors.full_messages).to include("Password is too short (minimum is 8 characters)")
      end
    end
  end

  describe '.authenticate_with_credentials' do
    context 'with valid credentials' do
      it 'authenticates a user' do
        user = create_user(email: 'rach@rach.com', password: 'password')
        authenticated_user = User.authenticate_with_credentials('rach@rach.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'with invalid email' do
      it 'returns nil' do
        authenticated_user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
        expect(authenticated_user).to be_nil
      end
    end

    context 'with invalid password' do
      it 'returns nil' do
        user = create_user(email: 'rach@rach.com', password: 'password')
        authenticated_user = User.authenticate_with_credentials('rach@rach.com', 'NOTpassword')
        expect(authenticated_user).to be_nil
      end
    end

    context 'with extra spaces in email' do
      it 'authenticates a user' do
        user = create_user(email: 'rach@rach.com', password: 'password')
        authenticated_user = User.authenticate_with_credentials('  rach@rach.com  ', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    private

    def create_user(attributes = {})
      User.create!(
        email: attributes[:email],
        password: attributes[:password],
        password_confirmation: attributes[:password] || 'password',
        first_name: attributes[:first_name] || 'John',
        last_name: attributes[:last_name] || 'Doe'
      )
    end
  end
end
