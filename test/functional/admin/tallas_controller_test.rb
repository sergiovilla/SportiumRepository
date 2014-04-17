#encoding: utf-8
require File.dirname(__FILE__) + '/../../test_helper'

class Admin::TallasControllerTest < ActionController::TestCase
  fixtures :tallas

  test "new" do
    get :new
    assert_template 'admin/tallas/new'
    assert_tag 'title', :content => 'Añadir nueva Talla'
    assert_tag 'form', :attributes => {:action => '/admin/tallas', :method => 'post'}
  end

  test "create" do
    # Por defecto la diferencia es 1
    assert_difference 'Talla.count' do
      post :create, :talla => {:nombre => 'XXL'}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    
    assert_equal 'Talla XXL creada correctamente', flash[:success] 
  end

  test "failing_create" do
    assert_no_difference 'Talla.count' do
      post :create, :talla => {:nombre => 'xxxs'}
      assert_response :success
      assert_template 'admin/tallas/new'
      assert_tag 'div', :attributes => {:class => 'alert alert-danger alert-dismissable'}
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag 'table', :children => { :count => Talla.count + 1, :only => { :tag => 'tr' } }
    
    Talla.all.each do |t|
      assert_tag 'td', :content => t.nombre
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/tallas/show'
    assert_equal 'M', assigns(:talla).nombre
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag 'input', :attributes => { :name => 'talla[nombre]', :value => 'M' }
    # Método PUT de http
    assert_tag 'input', :attributes => { :name => '_method', :value => 'put' }
  end

  test "update" do
    put :update, :id => 1, :talla => { :nombre => 'L'}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'L', Talla.find(1).nombre
  end

  test "delete" do
    assert_difference 'Talla.count', -1 do
      delete :destroy, :id => 1
      assert_response :redirect
      assert_redirected_to :action => 'index'

      get :index
      assert_response :success
      assert_tag 'div', :attributes => { :class => 'alert alert-success alert-dismissable' }
    end
  end

end
