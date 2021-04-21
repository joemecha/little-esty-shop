require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before(:each) do

  @merchant_1 = create(:merchant, name: "M1")
  @item_1 = create(:item, merchant: @merchant_1)
  @invoice_1 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_6 = FactoryBot.create(:invoice, created_at:'19 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 30)
  @invoice_item_6 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 100, unit_price: 5)
  @invoice_item_7 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 100, unit_price: 5)

  @merchant_2 = create(:merchant, name: "M2")
  @item_2 = create(:item, merchant: @merchant_2)
  @invoice_2 = FactoryBot.create(:invoice, created_at:'5 Apr 2021 17:58:39 UTC +00:00')
  @invoice_7 = FactoryBot.create(:invoice, created_at:'3 Apr 2021 17:58:39 UTC +00:00')
  @invoice_8 = FactoryBot.create(:invoice, created_at:'9 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "pending", quantity: 100, unit_price: 3)
  @invoice_item_8 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_7.id, status: "packaged", quantity: 100, unit_price: 5)
  @invoice_item_9 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_8.id, status: "packaged", quantity: 100, unit_price: 5)

  @merchant_3 = create(:merchant, name: "M3")
  @item_3 = create(:item, merchant: @merchant_3)
  @invoice_3 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: "pending", quantity: 100, unit_price: 2)

  @merchant_4 = create(:merchant, name: "M4")
  @item_4 = create(:item, merchant: @merchant_4)
  @invoice_4 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 100, unit_price: 4)

  @merchant_5 = create(:merchant, name: "M5")
  @item_5 = create(:item, merchant: @merchant_5)
  @invoice_5 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 100, unit_price: 5)

  @invoice_9 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_10 = FactoryBot.create(:invoice, created_at:'21 Apr 2021 17:58:39 UTC +00:00')
  @invoice_item_10 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 100, unit_price: 5)

  @customer_1 = FactoryBot.create(:customer)
  @customer_2 = FactoryBot.create(:customer)
  @customer_3 = FactoryBot.create(:customer)
  @customer_4 = FactoryBot.create(:customer)
  @customer_5 = FactoryBot.create(:customer)
  @customer_6 = FactoryBot.create(:customer)

  @customer_1.invoices << [@invoice_1]
  @customer_2.invoices << [@invoice_2]
  @customer_3.invoices << [@invoice_3]
  @customer_4.invoices << [@invoice_4]
  @customer_5.invoices << [@invoice_5]
  @customer_6.invoices << [@invoice_6]

  @transaction_1 = FactoryBot.create(:transaction, result: 1)
  @transaction_2 = FactoryBot.create(:transaction, result: 1)
  @transaction_3 = FactoryBot.create(:transaction, result: 1)
  @transaction_4 = FactoryBot.create(:transaction, result: 1)
  @transaction_5 = FactoryBot.create(:transaction, result: 1)
  @transaction_6 = FactoryBot.create(:transaction, result: 1)
  @transaction_7 = FactoryBot.create(:transaction, result: 1)
  @transaction_8 = FactoryBot.create(:transaction, result: 1)
  @transaction_9 = FactoryBot.create(:transaction, result: 1)
  @transaction_10 = FactoryBot.create(:transaction, result: 1)

  @invoice_1.transactions << @transaction_1
  @invoice_2.transactions << @transaction_2
  @invoice_3.transactions << @transaction_3
  @invoice_4.transactions << @transaction_4
  @invoice_5.transactions << @transaction_5
  @invoice_6.transactions << @transaction_6
  @invoice_7.transactions << @transaction_7
  @invoice_8.transactions << @transaction_8
  @invoice_9.transactions << @transaction_9
  @invoice_10.transactions << @transaction_10
  end

  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoice_items).through :items }
    it { should have_many(:invoices).through :invoice_items }
    it { should have_many(:customers).through :invoices }
    it { should have_many(:transactions).through :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
    describe '::top_five_by_merchant_revenue' do
      it 'returns top five merchants by total revenue' do
        expect(Merchant.top_five_by_merchant_revenue).to eq([@merchant_2, @merchant_1, @merchant_5, @merchant_4, @merchant_3])
      end
    end
  end

    # Then next to each of the 5 merchants by revenue I see the date with the most revenue for each merchant.
    # And I see a label “Top selling date for was "
    #
    # Note: use the invoice date. If there are multiple days with equal number of sales, return the most recent day.
  describe 'instance methods' do
    describe '#top_selling_date' do
      it 'returns the most recent invoice date for top revenue day' do

        expect(@merchant_1.top_selling_date).to eq(@invoice_6.created_at)
        expect(@merchant_2.top_selling_date).to eq(@invoice_7.created_at)
      end
    end
  end
end
