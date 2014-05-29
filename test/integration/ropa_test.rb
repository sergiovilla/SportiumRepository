require 'test_helper'

class RopaTest < ActionDispatch::IntegrationTest
  fixtures :ropas, :marcas, :colors, :tallas
  
  test "ropa_administration" do 
  	marca = Marca.first
  	color = Color.first
  	talla = Talla.first
  	
  	usuario = new_session_as(:usuario)
  	
  	camiseta = usuario.add_ropa :tags => 'Real, Madrid, Equipo', :ropa => {
  								    :tipo => 'Camiseta',
									:nombre => 'nombre random',
									:precio => 20,
									:modelo => 'modelo random',
									:marca_id => marca.id,
									:talla_id => talla.id,
									:color_id => color.id
  								}

    usuario.list_ropa
    usuario.show_ropa camiseta

    usuario.edit_ropa camiseta, :tags => 'Barcelona', :ropa => {
                                    :tipo => 'Camiseta',
                                    :nombre => 'nombre editado',
                                    :precio => 25,
                                    :modelo => 'modelo editado',
                                    :marca_id => marca.id,
                                    :talla_id => talla.id,
                                    :color_id => color.id
                                }

    usuario2 = new_session_as(:usuario2)
    usuario2.delete_ropa camiseta
  end
  
  private
  module RopaTestDSL
  	attr_writer :nombre
  	
  	def add_ropa(parameters)
      marca = Marca.first
      talla = Talla.first
      color = Color.first

      get '/admin/ropas/new', :tipo => 'Camiseta'
      assert_response :success
      assert_template 'admin/ropas/new'
      assert_tag :tag => 'option', :attributes => { :value => marca.id }
      assert_tag :tag => 'option', :attributes => { :value => talla.id }
      assert_tag :tag => 'option', :attributes => { :value => color.id }
      
      post '/admin/ropas', parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/ropas/index'

      ropa = Ropa.find_by_nombre(parameters[:ropa][:nombre])
      assert_equal parameters[:tags].split(',').size, ropa.tag_list.size
      
      return ropa
  	end

    def edit_ropa(ropa, parameters)
      get "admin/ropas/#{ropa.id}/edit"
      assert_response :success
      assert_template 'admin/ropas/edit'
      put "/admin/ropas/#{ropa.id}", parameters
      assert_response :redirect
      follow_redirect!
      assert_response :success
      assert_template 'admin/ropas/show'

      ropa.reload
      assert_equal parameters[:tags].split(',').size, ropa.tag_list.size
    end

    def delete_ropa(ropa)
      delete "/admin/ropas/#{ropa.id}"
      assert_response :redirect
      follow_redirect!
      assert_template 'admin/ropas/index'
    end

    def show_ropa(ropa)
      get "/admin/ropas/#{ropa.id}"
      assert_response :success
      assert_template 'admin/ropas/show'
    end

    def list_ropa
      get 'admin/ropas'
      assert_response :success
      assert_template 'admin/ropas/index'
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
