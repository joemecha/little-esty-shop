require 'rails_helper'

RSpec.describe 'item update' do
  before(:each) do
    Merchant.destroy_all
    Item.destroy_all
    @merchant = create(:merchant, name: "Borts Beets")
    @item = @merchant.items.create(name: "Bort's Bumblebeet Lip Balm",
                          description: "All natural ingredient pure beet balm from the bearded Bort you can trust",
                          unit_price: 150)

    visit "/merchants/#{@merchant.id}/items/#{@item.id}"
  end

  describe 'the edit item page' do
    it 'renders the edit form' do
      expect(page).to have_link("Edit Item")

      click_link("Edit Item")

      expect(page).to have_current_path("/merchants/#{@merchant.id}/items/#{@item.id}/edit")

      expect(page).to have_content('Edit Item')
      expect(find('form')).to have_content('Name')
      expect(find('form')).to have_content('Description')
      expect(find('form')).to have_content('Unit Price')
    end
  end

  describe 'update item' do
    describe 'given valid data' do
      describe "It updates the item and redirects to the item's show page" do
        it "displays the item just updated with the updated information" do
          visit "/merchants/#{@merchant.id}/items/new"

          fill_in 'Name', with: "Bort's Bumblebeet Lip Balm"
          fill_in 'Description', with: "All natural ingredient pure beet balm from the bearded Bort you can trust"
          fill_in 'Unit Price', with: 15
          click_button 'Submit'
          expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
          expect(page).to have_content("Bort's Bumblebeet Lip Balm")
        end
      end
    end

    describe 'given invalid data' do
      it 're-renders the new form' do
        visit "/merchants/#{@merchant.id}/items/new"

        click_button 'Submit'
        expect(page).to have_current_path("/merchants/#{@merchant.id}/items/new")
        expect(page).to have_content("Error: Invalid Input. Complete all forms.")
      end
    end
  end
end
