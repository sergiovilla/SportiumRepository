#encoding: utf-8
class Admin::TallasController < ApplicationController
  def new
    @talla = Talla.new
    @page_title = 'Añadir nueva Talla'
  end

  def create
    @talla = Talla.new(:nombre => params[:talla][:nombre].upcase)
    if @talla.save
      flash[:success] = "Talla #{@talla.nombre} creada correctamente"
      redirect_to :action => 'index'
    else
      @page_title = 'Añadir nueva Talla'
      flash[:error] = @talla.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @talla = get_talla(params[:id])
    @page_title = "Editando Talla #{@talla.nombre}"
  end

  def update
    @talla = get_talla(params[:id])
    if @talla.update_attribute('nombre', params[:talla][:nombre].upcase)
      flash[:success] = "Talla #{@talla.nombre} actualizada correctamente"
      redirect_to :action => 'show', :id => @talla
    else
      flash[:error] = @talla.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @talla = get_talla(params[:id])
    @talla.destroy
    flash[:success] = "Talla #{@talla.nombre} eliminada correctamente"
    redirect_to :action => 'index'
  end

  def show
    @talla = get_talla(params[:id])
    @page_title = "Talla " + @talla.nombre
  end

  def index
    @tallas = Talla.all
    @page_title = 'Listado de Tallas'
  end

  private
  def get_talla(id)
    Talla.find(id);
  end
end
