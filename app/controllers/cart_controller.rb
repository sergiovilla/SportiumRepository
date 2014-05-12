#encoding: utf-8
class CartController < ApplicationController
	before_filter :initialize_cart

  def add
    @ropa = Ropa.find params[:id]
    @page_title = 'Añadir producto'

    respond_to do |format|
      format.html {
        if request.post?
          @item = @cart.add params[:id]
          flash[:cart_notice] = "Añadido <em>#{@item.ropa.nombre}</em>.".html_safe
          redirect_to :controller => 'catalog'
        end
      }
      format.js {
        @item = @cart.add params[:id]
        flash[:cart_notice] = "Añadido <em>#{@item.ropa.nombre}</em>.".html_safe
      }
    end
  end

  def remove
    @ropa = Ropa.find params[:id]
    @page_title = 'Eliminar producto'
    
    respond_to do |format|
      format.html {
        if request.post?
          @item = @cart.remove params[:id]
          flash[:cart_notice] = "Eliminar 1 <em>#{@item.ropa.nombre}</em>.".html_safe
          redirect_to :controller => 'catalog'
        end
      }
      format.js {
        @item = @cart.remove params[:id]
        flash[:cart_notice] = "Eliminar 1 <em>#{@item.ropa.nombre}</em>.".html_safe
      }
    end
  end

  def clear
    @page_title = 'Vaciar Carrito'

    respond_to do |format|
      format.html {
        if request.post?
          @cart.cart_items.destroy_all
          flash[:cart_notice] = "Carrito limpio."
          redirect_to :controller => 'catalog'
        end
      }
      format.js {
        @cart.cart_items.destroy_all
        flash[:cart_notice] = "Carrito limpio."
      }
    end
  end
end
