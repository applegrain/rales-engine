class ChangeTypesForInvoiceItems < ActiveRecord::Migration
  def change
    remove_column :invoice_items, :quantity, :string
    remove_column :invoice_items, :unit_price, :string
  end
end
