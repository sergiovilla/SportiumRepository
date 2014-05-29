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

	test 'tagging' do
	  ropa = Ropa.find(1)
	  ropa.tag_list.add("Real", "Madrid")
	  
	  ropa.save
	  ropa.reload

	  assert ropa.tag_list.include?('Real')
	  assert ropa.tag_list.include?('Madrid')

	  assert_equal ['Real', 'Madrid'], ropa.tag_list
      assert Ropa.tagged_with(["Real", "Madrid"], :any => true).size
      assert Ropa.tagged_with(["Real", "Madrid"], :match_all => true).size
    end
  
end
