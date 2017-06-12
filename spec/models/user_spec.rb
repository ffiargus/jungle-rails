require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should not save user if pass and confirm do not match' do
      user = User.new email: 'l@l.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '234567'
      user.save
      expect(user.errors.full_messages[0]).to eq("Password confirmation doesn't match Password")
    end

    it 'should not save user if email already exists' do
      user1 = User.new email: 'l@l.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '123456'
      user1.save!
      user2 = User.new email: 'L@l.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '123456'
      user2.save
      expect(user2.errors.full_messages).to_not eq([])
    end

    it 'should not save user if pass less than 6 characters' do
      user = User.new email: 'l@l.com', first_name: 'Milind', last_name: 'Shah', password: '1', password_confirmation: '1'
      user.save
      expect(user.errors.full_messages).to eq(['Password is too short (minimum is 6 characters)'])
    end

  end

  describe '.authenticate_with_credentials' do

    it 'should log the user in with the correct password' do
      user = User.new email: 'l@l.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '123456'
      user.save!
      expect(User.authenticate_with_credentials(user.email, user.password)).to eq(user)
    end

    it 'should authenticate with spaces added before or after email' do
      user = User.new email: 'l@l.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '123456'
      user.save!
      expect(User.authenticate_with_credentials('l@l.com  ', user.password)).to eq(user)
    end

    it 'should authenticate with case insensitivity in email' do
      user = User.new email: 'l@L.com', first_name: 'Milind', last_name: 'Shah', password: '123456', password_confirmation: '123456'
      user.save!
      expect(User.authenticate_with_credentials('l@l.COM', user.password)).to eq(user)
    end

  end
end
