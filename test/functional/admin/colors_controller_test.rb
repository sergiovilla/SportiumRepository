require File.dirname(__FILE__) + '/../../test_helper'

class Admin::ColorsControllerTest < ActionController::TestCase
  fixtures :colors

  test "new" do
    get :new
    assert_template 'admin/colors/new'
    assert_tag 'title', :content => 'Añadir nuevo Color'
    assert_tag 'form', :attributes => {:action => '/admin/colors', :method => 'post'}
  end

  test "create" do
    # Por defecto la diferencia es 1
    assert_difference 'Color.count' do
      post :create, :color => {:nombre => 'Azul'}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    
    assert_equal 'Color Azul creado correctamente', flash[:success] 
  end

  test "failing_create" do
    assert_no_difference 'Color.count' do
      post :create, :color => {:nombre => 'Rojo'}
      assert_response :success
      assert_template 'admin/colors/new'
      assert_tag 'div', :attributes => {:class => 'alert alert-danger alert-dismissable'}
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag 'table', :children => { :count => Color.count + 1, :only => { :tag => 'tr' } }
    
    Color.all.each do |c|
      assert_tag 'td', :content => c.nombre
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/colors/show'
    assert_equal 'Rojo', assigns(:color).nombre
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag 'input', :attributes => { :name => 'color[nombre]', :value => 'Rojo' }
    # Método PUT de http
    assert_tag 'input', :attributes => { :name => '_method', :value => 'put' }
  end

  test "update" do
    put :update, :id => 1, :color => { :nombre => 'Amarillo'}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 'Amarillo', Color.find(1).nombre
  end

  test "delete" do
    assert_difference 'Color.count', -1 do
      delete :destroy, :id => 1
      assert_response :redirect
      assert_redirected_to :action => 'index'

      get :index
      assert_response :success
      assert_tag 'div', :attributes => { :class => 'alert alert-success alert-dismissable' }
    end
  end

end
