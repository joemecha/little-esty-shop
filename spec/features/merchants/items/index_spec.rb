require 'rails_helper'

RSpec.describe 'as a merchant, when I visit the merchant items index' do
  before(:each) do
    @merchant_1 = Merchant.create!(name: 'Cookie Soaps')
    @merchant_2 = Merchant.create!(name: 'Novelty Waffle Irons')

    @item_1 = Item.create!(name: "Choc Chip Soap Bar", description: "Delicious Choc Chip scent but don't eat it", unit_price: 10, merchant_id: @merchant_1.id, status: 0)
    @item_2 = Item.create!(name: "Peanut Butter Soap Bar", description: "Delicious Peanut Butter Cookie scent but don't eat it", unit_price: 8, merchant_id: @merchant_1.id, status: 0)
    @item_3 = Item.create!(name: "Gingersnap Soap Bar", description: "Delicious Ginger Snap scent but don't eat it", unit_price: 5, merchant_id: @merchant_1.id, status: 1)
    @item_4 = Item.create!(name: "Iced Oatmeal Soap Bar", description: "Delicious Iced Oatmeal scent but don't eat it", unit_price: 1, merchant_id: @merchant_1.id, status: 1)
    @item_7 = Item.create!(name: "Butter Pecan Soap Bar", description: "Delicious Butter Pecan Cookie scent but don't eat it", unit_price: 3, merchant_id: @merchant_1.id, status: 1)
    @item_8 = Item.create!(name: "Macaron Soap Bar", description: "Delicious Macaron scent but don't eat it", unit_price: 5, merchant_id: @merchant_1.id, status: 1)

    @item_5 = Item.create!(name: "The Ironman", description: "Makes waffles that look like a watch worn by athletes", unit_price: 200, merchant_id: @merchant_2.id)
    @item_6 = Item.create!(name: "The Lincoln Logger", description: "Makes waffles that are shaped like Lincoln logs", unit_price: 300, merchant_id: @merchant_2.id)

    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Ramone')
    @customer_2 = Customer.create!(first_name: 'Cecil', last_name: 'Jomez')
    @customer_3 = Customer.create!(first_name: 'Maria', last_name: 'Carsic')
    @customer_4 = Customer.create!(first_name: 'Leigh', last_name: 'Brond')
    @customer_5 = Customer.create!(first_name: 'Sylvia', last_name: 'Nadoor')
    @customer_6 = Customer.create!(first_name: 'Herb', last_name: 'Cohl')

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
    @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
    @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
    @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
    @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)

    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
    @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
    @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
    @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
    @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)

    @transaction1 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_1.id)
    @transaction2 = Transaction.create!(credit_card_number: 230948, result: 1, invoice_id: @invoice_2.id)
    @transaction3 = Transaction.create!(credit_card_number: 234092, result: 1, invoice_id: @invoice_3.id)
    @transaction4 = Transaction.create!(credit_card_number: 230429, result: 1, invoice_id: @invoice_4.id)
    @transaction5 = Transaction.create!(credit_card_number: 102938, result: 1, invoice_id: @invoice_5.id)
    @transaction6 = Transaction.create!(credit_card_number: 879799, result: 1, invoice_id: @invoice_6.id)
    @transaction7 = Transaction.create!(credit_card_number: 203942, result: 1, invoice_id: @invoice_7.id)

    visit "merchants/#{@merchant_1.id}/items"
  end

  it "I see my name" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to_not have_content(@merchant_2.name)
  end

  it "shows the names of the merchant's items" do
    within "#item-#{@item_1.id}" do
      expect(page).to have_content(@item_1.name)
    end
    within "#item-#{@item_2.id}" do
      expect(page).to have_content(@item_2.name)
    end
    within "#item-#{@item_3.id}" do
      expect(page).to have_content(@item_3.name)
    end
    within "#item-#{@item_4.id}" do
      expect(page).to have_content(@item_4.name)
    end

    expect(page).to_not have_content(@item_5.name)
    expect(page).to_not have_content(@item_6.name)
  end

  describe "I see two sections, one for 'Enabled Items' and one for 'Disabled Items'" do
    it 'has a button next to each item to disable/enable it' do

      within"#enabled-items" do
        expect(page).to have_content("Enabled Items")
        expect(page).to have_content(@item_3.name)

        expect(page).to_not have_content(@item_1.name)
        expect(page).to_not have_content(@item_2.name)
      end

      within"#disabled-items" do
        expect(page).to have_content("Disabled Items")
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_2.name)

        expect(page).to_not have_content(@item_3.name)
      end
    end

    it 'updates item status when button pushed' do
      within "#enabled-items"  do
        expect(page).to have_content(@item_3.name)

        click_button("Disable #{@item_3.name}")

        expect(page).to_not have_content(@item_3.name)
      end

      within "#disabled-items"  do
        expect(page).to have_content(@item_1.name)

        click_button("Enable #{@item_1.name}")

        expect(page).to_not have_content(@item_1.name)
      end
    end
  end

  describe "I see a link to create a new item" do
    it "has a create new item link" do
      expect(page).to have_link("Create New Item")
    end
  end

  describe "I see a section 'Top Five Items' with items" do
    describe "top-five-items section" do
      it "displays the names of the top 5 items ranked by total revenue" do
        within "#top-five-items"  do

          expect(@item_1.name).to appear_before(@item_2.name)
          expect(@item_2.name).to appear_before(@item_3.name)
          expect(@item_3.name).to appear_before(@item_8.name)
          expect(@item_8.name).to appear_before(@item_7.name)

          expect(page).to_not have_content(@item_4.name)
        end
      end

      it "each name links to merchant item show page for that item" do
        within "#top-five-items"  do
          expect(page).to have_link(@item_1.name)
          expect(page).to have_link(@item_2.name)
          expect(page).to have_link(@item_3.name)
          expect(page).to have_link(@item_7.name)
          expect(page).to have_link(@item_8.name)

          click_link "#{@item_1.name}"
          expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
        end
      end

      it "total revenue generated for that item is displayed next to each item" do
        within "#top-five-items"  do
          expect(page).to have_content("Total item revenue:")
          # require "pry"; binding.pry
          expect(page).to have_content("#{@merchant_1.top_five_items[0].total_revenue}")
          expect(page).to have_content("#{@merchant_1.top_five_items[1].total_revenue}")
          expect(page).to have_content("#{@merchant_1.top_five_items[2].total_revenue}")
          expect(page).to have_content("#{@merchant_1.top_five_items[3].total_revenue}")
          expect(page).to have_content("#{@merchant_1.top_five_items[4].total_revenue}")
        end
      end

      it "Each of the five most popular items has the date with the most sales for that item (invoice date)" do
        within "#top-five-items"  do
          expect(page).to have_content("Top selling date for")
          expect(page).to have_content("Top selling date for #{@item_1.name}: #{@item_1.top_selling_date}")
          expect(page).to have_content("Top selling date for #{@item_2.name}: #{@item_2.top_selling_date}")
          expect(page).to have_content("Top selling date for #{@item_3.name}: #{@item_3.top_selling_date}")
          expect(page).to have_content("Top selling date for #{@item_7.name}: #{@item_7.top_selling_date}")
          expect(page).to have_content("Top selling date for #{@item_8.name}: #{@item_8.top_selling_date}")
        end
      end
    end
  end
end
