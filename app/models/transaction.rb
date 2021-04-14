class Transaction < ApplicationRecord
  # has_many :items, through: :invoice_items
  # validates :credit_card_number
  belongs_to :invoice
  enum result: [ :failed, :success ]
end
