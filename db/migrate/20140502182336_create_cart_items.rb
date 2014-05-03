class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.column :ropa_id, :integer
      t.column :cart_id, :integer
      t.column :precio, :float
      t.column :cantidad, :integer
      t.timestamps
    end
  end
end
