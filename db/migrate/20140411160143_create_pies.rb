class CreatePies < ActiveRecord::Migration
  def change
    create_table :pies do |t|
      t.integer :numero
    end
  end
end
