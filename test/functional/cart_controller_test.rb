#encoding: utf-8
require File.dirname(__FILE__) + '/../test_helper'

class CartControllerTest < ActionController::TestCase
  fixtures :colors, :tallas, :marcas, :ropas

  setup do
    #@controller = CartController.new
    @request = ActionController::TestRequest.new
    #@response = ActionController::TestResponse.new
  end

  test "add" do
    assert_difference 'CartItem.count' do
      post :add, :id => 2
    end
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size
  end

  test "remove" do
    post :add, :id => 2
    assert_equal [Ropa.find(2)], Cart.find(@request.session[:cart_id]).ropas

    post :remove, :id => 2
    assert_equal [], Cart.find(@request.session[:cart_id]).ropas
  end

  test "clear" do
    post :add, :id => 2
    assert_equal [Ropa.find(2)], Cart.find(@request.session[:cart_id]).ropas

    post :clear
    assert_response :redirect
    assert_redirected_to :controller => 'catalog'
    assert_equal [], Cart.find(@request.session[:cart_id]).ropas
  end
end
