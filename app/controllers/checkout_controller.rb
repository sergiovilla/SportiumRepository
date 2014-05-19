#encoding utf-8

class CheckoutController < ApplicationController
  before_filter :initialize_cart, :only => :index

  def index
    @order = Order.new
    @page_title = 'Checkout'
    if @cart.cart_items.empty?
    	    flash[:notice] = 'Tu carrito de la compra esta vacio! ' +
    	    	    'Por favor, agrega al menos una prenda para llevar a cabo tu orden'
      redirect_to :controller => 'catalog'
    end
  end

  def submit_order
    @cart = Cart.find(params[:cart][:id]) # Search the cart from the cart id hidden field of the form
    @order = Order.new(params[:order])
    @order.customer_ip = request.remote_ip
    @order.status = 'open'
    @page_title = 'Checkout'
    populate_order

    if @order.save
      if @order.process
      	      flash[:notice] = 'Tu orden ha sido recibida y sera procesada inmediatamente.'
        session[:order_id] = @order.id
        @cart.cart_items.destroy_all # empty shopping cart
        redirect_to :action => 'gracias'
      else
      	      flash[:notice] = "Error mientras se guardaba la orden '#{@order.error_message}'."
        render :action => 'index'
      end
    else
      render :action => 'index'
    end
  end

  def gracias
    @page_title = 'Gracias.'
  end

  private

  def populate_order
    for cart_item in @cart.cart_items
      order_item = OrderItem.new(:ropa_id => cart_item.ropa_id,
      	      :price => cart_item.precio,
      	      :amount => cart_item.cantidad)
      @order.order_items << order_item
    end
  end
end
