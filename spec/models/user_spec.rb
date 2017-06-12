require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Validation' do
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
end
