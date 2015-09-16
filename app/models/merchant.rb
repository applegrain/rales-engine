class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def revenue(params)
    if params[:date]
      revenue_by_date(params[:date])
    else
      { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
    end
  end

  def revenue_by_date(date)
    { revenue: invoices.where({created_at: date}).successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def customers_with_pending_invoices
    invoices.pending.joins(:customer).uniq
  end
end
