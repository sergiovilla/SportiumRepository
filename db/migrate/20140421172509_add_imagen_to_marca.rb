class AddImagenToMarca < ActiveRecord::Migration
  def change
  	add_attachment :marcas, :imagen
  end
end
