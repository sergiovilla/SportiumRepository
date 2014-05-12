#encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class CatalogControllerTest < ActionController::TestCase
  fixtures :ropas, :colors, :tallas, :marcas

  test "show" do
    get :show, :id => 2
    assert_response :success
    assert_template 'catalog/show'
    assert_equal 'nombre equipacion', assigns(:ropa).nombre
    assert_equal 'modelo equipacion', assigns(:ropa).modelo
    assert_equal 60, assigns(:ropa).precio

    assert_tag 'h2', :content => Ropa.find(2).nombre
  end

  test "latest" do
    get :latest
    assert_response :success
    assert_tag 'h2', :content => 'Últimos artículos'
    @ropas = Ropa.latest 6
    @ropas.each do |r|
      assert_tag :tag => 'h5', :content => r.nombre
    end
  end

  test "index_catalogo" do
    get :index_catalogo, :tipo => 'Camiseta'
    assert_response :success
    assert_tag 'h2', :content => 'Catálogo de Camiseta'

    @ropas = Ropa.where "tipo = 'Camiseta'", :order => "ropas.id desc"
    pages = @ropas.count / 6
    pages += 1 unless @ropas.count % 6 == 0
    cont = 1
    page = 1

    @ropas.each do |r|
      assert_tag :tag => 'h5', :content => r.nombre
      cont = cont + 1
      if cont > 6 && page < pages  # go to next page
        page = page + 1
        cont = 1
        get :index_catalogo, :tipo => 'Camiseta', :page => page
        assert_response :success
      end
    end
  end

  test "index_catalogo_marcas" do
    get :index_catalogo_marcas, :nombre => 'Adidas'
    assert_response :success
    assert_tag 'h2', :content => 'Catálogo de Adidas'

    @ropas = Ropa.where "marca_id = '1'", :order => "ropas.id desc"
    pages = @ropas.count / 6
    pages += 1 unless @ropas.count % 6 == 0
    cont = 1
    page = 1

    @ropas.each do |r|
      assert_tag :tag => 'h5', :content => r.nombre
      cont = cont + 1
      if cont > 6 && page < pages  # go to next page
        page = page + 1
        cont = 1
        get :index_catalogo_marcas, :nombre => 'Adidas', :page => page
        assert_response :success
      end
    end
  end

end
