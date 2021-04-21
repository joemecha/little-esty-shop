class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    if params[:status]
      @invoice.update(invoice_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end

private
  def invoice_params
    params.permit(:status, :customer_id)
  end
end
