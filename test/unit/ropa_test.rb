require 'test_helper'

class RopaTest < ActiveSupport::TestCase

fixtures :tallas, :marcas, :colors

	test 'create_common_attributes' do
		ropa = Ropa.new(
		:tipo => 'Camiseta',
		:nombre => 'nombre',
		:precio => 40.4,
		:modelo => 'modelo',
		:marca_id => Marca.find(1).id,
		:talla_id => Talla.find(1).id,
		:color_id => Color.find(1).id
		)
		assert ropa.save
	end
	
	test 'create_all_attributes_notzapatilla' do
		ropa = Ropa.new(
		:tipo => 'Equipacion',
		:nombre => 'nombre de equipacion',
		:precio => 80,
		:modelo => 'modelo',
		:marca_id => Marca.find(1).id,
		:talla_id => Talla.find(1).id,
		:color_id => Color.find(1).id,
		:deporte => 'deporte',
		:nom_equipo => 'equipo'
		)
		assert ropa.save
	end
	
	test 'create_zapatilla_attributes' do
		ropa = Ropa.new(
		:tipo => 'Zapatilla',
		:nombre => 'nombre zapatilla',
		:precio => 25,
		:modelo => 'modelo',
		:marca_id => Marca.find(1).id,
		:num_pie => 43
		)
		assert ropa.save
	end
	
	test 'ropas_belonging_to_marca' do
		marca1 = Marca.find(1)
		assert_equal 3, marca1.ropas.size
		
		ropa = Ropa.new(
		:tipo => 'Zapatilla',
		:nombre => 'nombre zapatilla2',
		:precio => 25,
		:modelo => 'modelo',
		:marca_id => Marca.find(1).id,
		:num_pie => 43
		)
		ropa.save
		
		marca1.reload
		ropa.reload
		
		assert_equal 4, marca1.ropas.size
		assert_equal 'Adidas', ropa.marca.nombre
		
	end
	
	test 'ropas_belonging_to_color' do
		color1 = Color.find(1)
		assert_equal 1, color1.ropas.size
		
		ropa2 = Ropa.find(2)
		color1.ropas << ropa2
		
		color1.reload
		ropa2.reload
		
		assert_equal 2, color1.ropas.size
		assert_equal 'Rojo', ropa2.color.nombre
		
	end
	
	test 'ropas_belonging_to_talla' do
		talla1 = Talla.find(1)
		assert_equal 2, talla1.ropas.size
		
		ropa3 = Ropa.find(3)
		talla1.ropas << ropa3
		
		talla1.reload
		ropa3.reload
		
		assert_equal 3, talla1.ropas.size
		assert_equal 'M', ropa3.talla.nombre_usa
	end
  
end
