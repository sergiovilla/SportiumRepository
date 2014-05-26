#enconding: utf-8
require 'test_helper'

class CatalogoBusquedaTest < ActionDispatch::IntegrationTest

	fixtures :ropas, :marcas, :colors, :tallas

  test "navegar" do
    usuario = new_session_as :jill
    usuario.index
    #usuario.second_page
    usuario.ropa_details "nombre camiseta"
    usuario.latest_ropa
  end

  module NavegandoTestDSL
    include ERB::Util
    attr_writer :name

    def index
      get 'catalogo/Camiseta'
      assert_response :success
      assert_tag :tag => 'div', :attributes => { :class => 'col-md-3 ropa' }
      check_ropa_links
    end

    def second_page
      get 'catalog/Camiseta?page=2'
      assert_response :success
      assert_template 'catalog/index_catalogo'
      check_ropa_links
    end
  end

  def ropa_details(nombre)
    @ropa = Ropa.find_by_nombre(nombre)
    get "catalogo/show/#{@ropa.id}"
    assert_response :success
    assert_template 'catalog/show'
    assert_tag :tag => 'h2', :content => @ropa.nombre
  end

  def check_ropa_links
    for ropa in assigns :ropas
      assert_tag :tag => 'a', :attributes => { :href => "/catalogo/show/#{ropa.id}" }
    end
  end

  def latest_ropa
    get 'catalogo/lista/novedades'
    assert_response :success
    assert_template 'catalog/latest'
    assert_tag :tag => 'div', :attributes => { :class => 'col-md-3 ropa' }

    @ropas = Ropa.latest(5)
    @ropas.each do |r|
      assert_tag :tag => 'h5', :content => r.nombre
    end
  end

  def new_session_as(name)
    open_session do |session|
      session.extend(NavegandoTestDSL)
      session.name = name
      yield session if block_given?
    end
  end
end
