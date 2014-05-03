class CartController < ApplicationController
	before_filter :initialize_cart

  def add
    @ropa = Ropa.find params[:id]
    @page_title = 'Añadir producto'
    if request.post?
      @item = @cart.add params[:id]
      flash[:cart_notice] = "Añadido <em>#{@item.ropa.nombre}</em>.".html_safe
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'add', :template => 'cart/add'
    end
  end

  def remove
    @ropa = Ropa.find params[:id]
    @page_title = 'Eliminar producto'
    if request.post?
      @item = @cart.remove params[:id]
      flash[:cart_notice] = "Eliminar 1 <em>#{@item.ropa.nombre}</em>.".html_safe
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'remove', :template => 'cart/remove'
    end
  end

  def clear
    @page_title = 'Clear cart'
    if request.post?
      @cart.cart_items.destroy_all
      flash[:cart_notice] = "Carrito limpio."
      redirect_to :controller => 'catalog'
    else
      render :controller => 'cart', :action => 'clear', :template => 'cart/clear'
    end
  end
end
