require "csv"

class Parser

  def self.load
    puts "Parsing CSV files into ActiveRecord table rows..."

    customer
    merchant
    item
    invoice
    transaction
    invoice_item

    puts "\e[37mDone."
  end

  # Customers.csv
  def self.customer
    CSV.foreach("../rales-engine/app/services/data/customers.csv", headers: true, header_converters: :symbol) do |row|
      Customer.create(row.to_hash)
    end

    puts "\e[32m#{Customer.count} Customers successfully created \u2713"
  end

  # Merchants.csv
  def self.merchant
    CSV.foreach("../rales-engine/app/services/data/merchants.csv", headers: true, header_converters: :symbol) do |row|
      Merchant.create(row.to_hash)
    end

    puts "\e[32m#{Merchant.count} Merchants successfully created \u2713"
  end

  # Invoices.csv
  def self.invoice
    CSV.foreach("../rales-engine/app/services/data/invoices.csv", headers: true, header_converters: :symbol) do |row|
      Invoice.create(row.to_hash)
    end

    puts "\e[32m#{Invoice.count} Invoices successfully created \u2713"
  end

  # Items.csv
  def self.item
    CSV.foreach("../rales-engine/app/services/data/items.csv", headers: true, header_converters: :symbol) do |row|
      Item.create({
        name: row[1],
        description: row[2],
        unit_price: (row[3].to_f / 100.00),
        merchant_id: row[4],
        created_at: row[5],
        updated_at: row[6]
      })
    end

    puts "\e[32m#{Item.count} Items successfully created \u2713"
  end

  # Transactions.csv
  def self.transaction
    CSV.foreach("../rales-engine/app/services/data/transactions.csv", headers: true, header_converters: :symbol) do |row|
      Transaction.create({
        invoice_id: row[1],
        credit_card_number: row[2],
        result: row[4],
        created_at: row[5],
        updated_at: row[6]
      })
    end

    puts "\e[32m#{Transaction.count} Transactions successfully created \u2713"
  end

  # InvoiceItems.csv
  def self.invoice_item
    CSV.foreach("../rales-engine/app/services/data/invoice_items.csv", headers: true, header_converters: :symbol) do |row|
      InvoiceItem.create!({
       :item_id    => row[1],
       :invoice_id => row[2],
       :quantity   => row[3],
       :unit_price => row[4].to_f / 100,
       :created_at => row[5],
       :updated_at => row[6]
      })
    end

    puts "\e[32m#{InvoiceItem.count} Invoice items successfully created \u2713"
  end
end
