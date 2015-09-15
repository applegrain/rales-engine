class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  def revenue
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price") / 100.00
  end
end
