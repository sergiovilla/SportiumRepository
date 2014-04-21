class AddImagenToRopa < ActiveRecord::Migration
  def change
  	add_attachment :ropas, :imagen
  end
end
