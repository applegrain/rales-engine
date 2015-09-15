class AddColumnsToInvoiceItems < ActiveRecord::Migration
  def change
    add_column :invoice_items, :quantity, :integer

    add_column :invoice_items, :unit_price, :float
  end
end
