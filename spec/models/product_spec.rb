require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @category = Category.new
  end

  describe 'Validations' do
    it 'should create a valid product' do
      product = Product.new(name: 'thing', price: 10, quantity: 2, category: @category)
      product.save!
      expect(product).to be_present
    end

    it 'should validate name exists' do
      product = Product.new(price: 10, quantity: 2, category: @category)
      product.save
      expect(product.errors.full_messages[0]).to eq("Name can't be blank")
    end

    it 'should validate price exists' do
      product = Product.new(name: 'thing', quantity: 2, category: @category)
      product.save
      expect(product.errors.full_messages[0]).to eq("Price cents is not a number")
    end

    it 'should validate quantity exists' do
      product = Product.new(price: 10, name: 'thing', category: @category)
      product.save
      expect(product.errors.full_messages[0]).to eq("Quantity can't be blank")
    end

    it 'should validate category exists' do
      product = Product.new(price: 10, quantity: 2, name: 'thing')
      product.save
      expect(product.errors.full_messages[0]).to eq("Category can't be blank")
    end
  end
end
