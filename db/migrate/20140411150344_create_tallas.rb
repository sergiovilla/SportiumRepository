class CreateTallas < ActiveRecord::Migration
  def change
    create_table :tallas do |t|
      t.integer :nombre_euro
      t.string :nombre_usa
      t.timestamps
    end
  end
end
