#encoding: utf-8
require File.dirname(__FILE__) + '/../../test_helper'

class Admin::PiesControllerTest < ActionController::TestCase
  fixtures :pies

  test "new" do
    get :new
    assert_template 'admin/pies/new'
    assert_tag 'title', :content => 'Añadir nuevo número de Pie'
    assert_tag 'form', :attributes => {:action => '/admin/pies', :method => 'post'}
  end

  test "create" do
    # Por defecto la diferencia es 1
    assert_difference 'Pie.count' do
      post :create, :pie => {:numero => 50}
      assert_response :redirect
      assert_redirected_to :action => 'index'
    end
    
    assert_equal 'Número de Pie 50 creado correctamente', flash[:success] 
  end

  test "failing_create" do
    assert_no_difference 'Pie.count' do
      post :create, :pie => {:numero => '10'}
      assert_response :success
      assert_template 'admin/pies/new'
      assert_tag 'div', :attributes => {:class => 'alert alert-danger alert-dismissable'}
    end
  end

  test "index" do
    get :index
    assert_response :success
    assert_tag 'table', :children => { :count => Pie.count + 1, :only => { :tag => 'tr' } }
    
    Pie.all.each do |p|
      assert_tag 'td', :content => p.numero.to_s
    end
  end

  test "show" do
    get :show, :id => 1
    assert_template 'admin/pies/show'
    assert_equal 40, assigns(:pie).numero
  end

  test "edit" do
    get :edit, :id => 1
    assert_tag 'input', :attributes => { :name => 'pie[numero]', :value => '40' }
    # Método PUT de http
    assert_tag 'input', :attributes => { :name => '_method', :value => 'put' }
  end

  test "update" do
    put :update, :id => 1, :pie => { :numero => 42}
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
    assert_equal 42, Pie.find(1).numero
  end

  test "delete" do
    assert_difference 'Pie.count', -1 do
      delete :destroy, :id => 1
      assert_response :redirect
      assert_redirected_to :action => 'index'

      get :index
      assert_response :success
      assert_tag 'div', :attributes => { :class => 'alert alert-success alert-dismissable' }
    end
  end

end
