require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before(:each) do
    # @merchant_1 = FactoryBot.create(:merchant)
    # @merchant_2 = FactoryBot.create(:merchant)
  end

  describe 'relationships' do
    it { should belong_to (:invoice) }
  end

end
