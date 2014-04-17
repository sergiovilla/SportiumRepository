#encoding: utf-8
require File.dirname(__FILE__) + '/../../test_helper'

class Admin::MarcasControllerTest < ActionController::TestCase
  fixtures :marcas

  test "new" do
    get :new
    assert_template 'admin/marcas/new'
    assert_tag 'title', :content => 'Añadir nueva Marca'
    assert_tag 'form', :attributes => {:action => '/admin/marcas', :method => 'post'}
  end

  test "create" do
    # Por defecto la diferencia es 1
    assert_difference 'Marca.count' do
      post :create, :marca => {:nombre => 'Puma', :pais => 'Francia'}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    
    assert_equal 'Marca Puma creada correctamente', flash[:success] 
  end

  test "failing_create" do
    assert_no_difference 'Marca.count' do
      post :create, :marca => {:nombre => 'Nestle'}
      assert_response :success
      assert_template 'admin/marcas/new'
      assert_tag 'div', :attributes => {:class => 'alert alert-danger alert-dismissable'}
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag 'table', :children => { :count => Marca.count + 1, :only => { :tag => 'tr' } }
    
    Marca.all.each do |m|
      assert_tag 'td', :content => m.nombre
      assert_tag 'td', :content => m.pais 
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/marcas/show'
    assert_equal 'Adidas', assigns(:marca).nombre
    assert_equal 'Alemania', assigns(:marca).pais
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag 'input', :attributes => { :name => 'marca[nombre]', :value => 'Adidas' }
    assert_tag 'input', :attributes => { :name => 'marca[pais]', :value => 'Alemania' }
    # Método PUT de http
    assert_tag 'input', :attributes => { :name => '_method', :value => 'put' }
  end

  test "update" do
    put :update, :id => 1, :marca => { :nombre => 'Spanholo', :pais => 'Spain' }
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Spanholo', Marca.find(1).nombre
  end

  test "delete" do
    assert_difference 'Marca.count', -1 do
      delete :destroy, :id => 1
      assert_response :redirect
      assert_redirected_to :action => 'index'

      get :index
      assert_response :success
      assert_tag 'div', :attributes => { :class => 'alert alert-success alert-dismissable' }
    end
  end

end
