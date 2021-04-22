require 'rails_helper'

RSpec.describe 'as a merchant, when I visit the merchant items index' do
  before(:each) do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1, status: 1)
    @item_4 = create(:item, merchant: @merchant_2)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)

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

    expect(page).to_not have_content(@item_4.name)
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
        end
      end

      it "each name links to merchant item show page for that item" do
      end

      it "total revenue generated for that item is displayed next to each item" do
      end

      xit "Next to each of the five most popular items I see the date with the most sales for each item (invoice date)" do
        expect(page).to have_content("Top Selling Date Was: ")
        # expect(page).to have_content() # 1st top item.top_selling_date
        # expect(page).to have_content() # 2nd top item.top_selling_date
        # expect(page).to have_content() # 3rd top item.top_selling_date
        # expect(page).to have_content() # 4th top item.top_selling_date
        # expect(page).to have_content() # 5th top item.top_selling_date
      end
    end
  end
end
