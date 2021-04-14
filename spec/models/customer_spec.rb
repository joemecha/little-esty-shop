require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  # before(:each) do
  # end

























  describe 'instance methods' do
    describe '#successful_transaction_count'
    it 'returns total successful transacton count' do
      
    

    end
  end
end
