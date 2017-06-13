require 'rails_helper'

RSpec.feature "Visitor clicks on a product and sees detail page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    2.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They click on a product" do
    # ACT
    visit root_path

    first('.product > header').click

    # DEBUG / VERIFY
    expect(page).to have_text 'Reviews', count: 1

    save_screenshot
  end

end
