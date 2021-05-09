class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_numericality_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  enum status: [ :disabled, :enabled ]

  def self.ready_to_ship
    where.not(invoice_items: {status: "shipped"})
  end

  def self.disabled_items
    where(status: 0)
  end

  def self.enabled_items
    where(status: 1)
  end

  def self.top_five
    joins(:transactions)
    .where(transactions: {result: :success})
    .group('items.id')
    .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue")
    .order(total_revenue: :desc)
    .limit(5)
  end

  def top_selling_date
    invoices
    .joins(:invoice_items)
    .where('invoices.status = 2')
    .select('invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) as money_earned')
    .group(:id)
    .order("money_earned desc", "created_at desc")
    .first
    .created_at
    .to_date
  end
end
