require 'test_helper'

class RopaTest < ActionDispatch::IntegrationTest
  fixtures :ropas, :marcas, :colors, :tallas
  
  def test_ropa_administration 
  	marca = Marca.find(1)
  	color = Color.find(1)
  	talla = Talla.find(1)
  	
  	usuario = new_session_as(:usuario)
  	
  	camiseta = usuario.add_ropa :ropa => {
  									:tipo => 'Camiseta',
									:nombre => 'nombre random',
									:precio => 20,
									:modelo => 'modelo random',
									:marca_id => marca.id,
									:talla_id => talla.id,
									:color_id => color.id
  								}
  end
  
  private
  module RopaTestDSL
  	attr_writer :nombre
  	
  	def add_ropa(parameters)
		post "/admin/ropas#create", parameters
		assert_response :redirect
		follow_redirect!
		assert_response :success
		return Ropa.find_by_nombre(parameters[:ropa][:nombre])
  	end
  	
  end
  
  def new_session_as(nombre)
	open_session do |session|
		session.extend(RopaTestDSL)
		session.nombre = nombre
		yield session if block_given?
	end
  end
  
end
