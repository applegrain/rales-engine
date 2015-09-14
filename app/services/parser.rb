require "csv"

class Parser

  def self.load
    customer
    merchant
    invoice
    item
    transaction
    invoice_item
  end

  # Customers.csv
  def self.customer
    CSV.foreach("../rales-engine/app/services/data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end
  end

  # Merchants.csv
  def self.merchant
    CSV.foreach("../rales-engine/app/services/data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end
  end

  # Invoices.csv
  def self.invoice
    CSV.foreach("../rales-engine/app/services/data/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
    end
  end

  # Items.csv
  def self.item
    CSV.foreach("../rales-engine/app/services/data/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create(row.to_hash)
    end
  end

  # Transactions.csv
  def self.transaction
    CSV.foreach("../rales-engine/app/services/data/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create(row.to_hash)
    end
  end

  # InvoiceItems.csv
  def self.invoice_item
    CSV.foreach("../rales-engine/app/services/data/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create(row.to_hash)
    end
  end
end
