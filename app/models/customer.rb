class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices

  def self.top_5_by_transaction_count
  end
end
