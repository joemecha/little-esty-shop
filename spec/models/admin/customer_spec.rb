require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  describe 'instance methods' do
    before(:each) do 
      @customer_1 = FactoryBot.create(:customer)
      @invoice_1 = FactoryBot.create(:invoice)
      @customer_1.invoices << @invoice_1
      @transaction_1 = FactoryBot.create(:transaction)
    end
    describe '#successful_transaction_count' do
     it 'returns total successful transacton count' do
      end
    end
  end
end
