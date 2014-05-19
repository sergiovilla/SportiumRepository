class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.column :nombre, :string, :limit => 50, :null => false
      t.column :subject, :string, :limit => 255, :null => false
      t.column :texto, :text

      t.column :root_id, :integer, :null => false, :default => 0
      t.column :parent_id, :integer, :null => false, :default => 0
      t.column :lft, :integer, :null => false, :default => 0
      t.column :rgt, :integer, :null => false, :default => 0
      t.column :depth, :integer, :null => false, :default => 0

      t.timestamps
    end
  end
end
