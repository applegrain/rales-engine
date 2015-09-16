class Item < ActiveRecord::Base
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

  def best_day
    invoices.successful.group('"invoices"."created_at"').sum("quantity * unit_price").sort_by(&:last).map(&:first).last
  end

  def self.most_items(quantity)
    values = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity")]
    end
      .sort_by { |pair| -pair.last }.map(&:first).first(quantity.to_i)
  end

  def self.most_revenue(quantity)
    values = Item.all.map do |item|
      [item, item.invoices.successful.sum("quantity * unit_price")]
    end
      .sort_by { |pair| -pair.last }.map(&:first).first(quantity.to_i)
  end
end
