require 'rails_helper'

RSpec.describe 'when I visit the admin dashboard' do
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

  it 'shows top 5 customers w/ the most successful transactions' do
    customer = create(:customer)
    customer.transaction_count
    visit '/admin'
    
  end
end


# Admin Dashboard Statistics - Top Customers

# As an admin,
# When I visit the admin dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions
# And next to each customer name I see the number of successful transactions they have
# conducted
