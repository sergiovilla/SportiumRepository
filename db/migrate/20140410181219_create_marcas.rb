class CreateMarcas < ActiveRecord::Migration
  def change
    create_table :marcas do |t|
      t.string :nombre
      t.string :pais

      t.timestamps
    end
  end
end
