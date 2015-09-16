class ChangeUnitPricesToDecimals < ActiveRecord::Migration
  def change
    change_column :items, :unit_price, 'decimal USING CAST(unit_price AS decimal)'
    change_column :invoice_items, :unit_price, 'decimal USING CAST(unit_price AS decimal)'
  end
end
