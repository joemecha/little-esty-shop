require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    # MERCHANT
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1, status: 0)
    @item_2 = create(:item, merchant: @merchant_1, status: 0)
    @item_3 = create(:item, merchant: @merchant_1, status: 1)
    @item_4 = create(:item, merchant: @merchant_1, status: 1)
    @item_5 = create(:item, merchant: @merchant_1, status: 1)
    @item_6 = create(:item, merchant: @merchant_1, status: 1)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: "Sun, 4 Apr 2021 21:37:10 UTC +00:00")
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, created_at: "Sun, 18 Apr 2021 21:37:10 UTC +00:00")
    @invoice_3 = create(:invoice, customer_id: @customer_1.id, created_at: "Mon, 5 Apr 2021 21:37:10 UTC +00:00")
    @invoice_4 = create(:invoice, customer_id: @customer_1.id, created_at: "Sun, 11 Apr 2021 21:37:10 UTC +00:00")
    @invoice_5 = create(:invoice, customer_id: @customer_1.id, created_at: "Mon, 12 Apr 2021 21:37:10 UTC +00:00")
    @invoice_6 = create(:invoice, customer_id: @customer_1.id, created_at: "Mon, 19 Apr 2021 21:37:10 UTC +00:00")

    # item 2 = 10 item 1 = 9 item 3 = 8 item 4 = 7 item 5 = 6 item 6 = 5
    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, status: "packaged", quantity: 1, unit_price: 9)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, status: "packaged", quantity: 1, unit_price: 10)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 1, unit_price: 8)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, status: "packaged", quantity: 1, unit_price: 7)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 1, unit_price: 6)
    @invoice_item_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 1, unit_price: 5)

    @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 1)
    @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 1)
    @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 1)
    @transaction_7 = create(:transaction, invoice_id: @invoice_6.id, result: 0)


    # MERCHANT 2
    @merchant_2 = create(:merchant)
    @item_7 = create(:item, merchant: @merchant_2, status: 1)

    @invoice_3 = create(:invoice, customer_id: @customer_2.id)
    # @invoice_4 = create(:invoice, customer_id: @customer_2.id)
    # @invoice_5 = create(:invoice, customer_id: @customer_2.id, created_at: "Sun, 11 Apr 2021 21:37:10 UTC +00:00")
    # @invoice_6 = create(:invoice, customer_id: @customer_2.id, created_at: "Sun, 4 Apr 2021 21:37:10 UTC +00:00")
    # @invoice_7 = create(:invoice, customer_id: @customer_2.id, created_at: "Mon, 5 Apr 2021 21:37:10 UTC +00:00")
    #
    # @invoice_item_4 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, status: "packaged", quantity: 20, unit_price: 5)
    # @invoice_item_5 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 50, unit_price: 5)
    # @invoice_item_6 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_5.id, status: "packaged", quantity: 100, unit_price: 5)
    # @invoice_item_7 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_6.id, status: "packaged", quantity: 40, unit_price: 5)
    # @invoice_item_8 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 10, unit_price: 5)
    # @invoice_item_9 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 10, unit_price: 25)
    # @invoice_item_10 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_3.id, status: "packaged", quantity: 1, unit_price: 10)
    #
    # @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 1)
    # @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 1)
    # @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 1)
    # @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 1)
    # @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 1)

  end

  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_numericality_of :unit_price}
  end

  describe 'class methods' do
    describe '::ready_to_ship' do
      it 'returns the items that are ready to ship' do
        expect(@merchant_1.invoice_items.ready_to_ship).to eq([@invoice_item_1])
      end
    end

    it '::disabled_items' do
      expect(@merchant_1.items.disabled_items).to eq([@item_1, @item_2])
    end

    it '::enabled_items' do
      expect(@merchant_1.items.enabled_items).to eq([@item_3, @item_4, @item_5, @item_6])
    end

    it '::top_five' do
      expect(@merchant_1.items.top_five).to eq([@item_2, @item_1, @item_3, @item_4, @item_5])
    end
  end

  describe 'instance methods' do
    it '#top_selling_date' do
      expect(@item3.top_selling_date).to eq([@invoice_5.created_at])
    end
  end
end
