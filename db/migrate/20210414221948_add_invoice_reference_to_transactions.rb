class AddInvoiceReferenceToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :invoices, :transactions, column: :invoice_id,  primary_key: 
  end
end
