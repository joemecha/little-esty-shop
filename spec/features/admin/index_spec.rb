require 'rails_helper'

RSpec.describe 'when I visit the admin dashboard' do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)
    @cus1 = Customer.create!(first_name: 'Bob', last_name: 'Jordan')
    @cus2 = Customer.create!(first_name: 'Pierce', last_name: 'Lamb')
    @cus3 = Customer.create!(first_name: 'Stephen', last_name: 'Halkias')
    @cus4 = Customer.create!(first_name: 'Nick', last_name: 'Mullen')
    @cus5 = Customer.create!(first_name: 'Adam', last_name: 'Friedland')
    @cus6 = Customer.create!(first_name: 'Gwion', last_name: 'Smith')
    @item_1 = @merchant_1.items.create!(name: 'Widget', description: 'it widgets', unit_price: 20)
    @item_2 = @merchant_1.items.create!(name: 'Thingamajig', description: 'useful for hair removal', unit_price: 4)
    @item_3 = @merchant_2.items.create!(name: 'Whatchamacallit', description: 'useful for growing hair', unit_price: 8)
    @item_4 = @merchant_2.items.create!(name: 'Macguffin', description: 'important for no particular reason', unit_price: 2)
    
  end

  it 'displays header indicating that I am on the dashboard' do
    visit '/admin'
    expect(page).to have_content("Admin Dashboard")
  end

  it 'shows a link to the admin merchants index' do
    visit '/admin'
    expect(page).to have_link('Admin Merchants Index', href: admin_merchants_path)
  end

  it 'shows a link to the admin invoices index' do
    visit '/admin'
    expect(page).to have_link('Admin Invoices Index', href: admin_invoices_path)
  end
  
  it "shows top 5 customers in the admin dashboard" do
    expect(page).to have_content("Top 5 Customers")
      within("#customer-#{@customer_number.id}") do
        expect(page).to have_content(@customer_number.first_name)
        expect(page).to have_content(@customer_number.first_name)
        expect(page).to have_content(@customer_number.first_name)
        expect(page).to have_content(@customer_number.last_name)
        expect(page).to have_content(@customer_number.last_name)
        expect(page).to have_content(@customer_number.last_name)
      end
    end
  end

  it "shows incomplete invoices" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
  end
end