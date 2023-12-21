require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'Cacti')
    end
    
    describe 'saves with all fields set' do
      it 'saves successfully with all four fields set' do
        product = Product.new(name: 'Mammillaria', price: 29.99, quantity: 5, category: @category)
        expect(product).to be_valid
      end
    end
    
    describe 'has a name' do
      it 'is not valid without a name' do
        product = Product.new(price: 29.99, quantity: 5, category: @category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Name can't be blank")
      end
    end

    describe 'has a price' do
      it 'is not valid without a price' do
        product = Product.new(name: 'Mammillaria', quantity: 5, category: @category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Price can't be blank")
      end
    end

    describe 'has a quantity' do
      it 'is not valid without a quantity' do
        product = Product.new(name: 'Mammillaria', price: 29.99, category: @category)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Quantity can't be blank")
      end
    end

    describe 'has a category' do
      it 'is not valid without a category' do
        product = Product.new(name: 'Mammillaria', price: 29.99, quantity: 5)
        expect(product).to_not be_valid
        expect(product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end
end

