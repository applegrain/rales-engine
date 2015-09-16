class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def revenue(params)
    if params[:date]
      revenue_by_date(params[:date])
    else
      invoices.successful.joins(:invoice_items).sum("quantity * unit_price") / 100.00
    end
  end

  def revenue_by_date(date)
    invoices.successful.where(invoices: {created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") / 100.00
  end
end
