class InvoiceItemsController < ApplicationController

  def update
    @invoice_item = InvoiceItem.find(params[:id])
    if params[:status]
      @invoice_item.update(invoice_items_params)
      require "pry"; binding.pry
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}" # need to pull out merchand and invoice id?
  end
end

private
  def invoice_items_params
    params.permit(:item_id, :invoice_id, :quantity, :unit_price, :status)
  end
end
