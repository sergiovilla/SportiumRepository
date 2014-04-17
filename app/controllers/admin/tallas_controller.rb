#encoding: utf-8
class Admin::TallasController < ApplicationController
  def new
    @talla = Talla.new
    @page_title = 'Añadir nueva Talla'
  end

  def create
    @talla = Talla.new(params[:talla])
    if @talla.save
      flash[:success] = "Talla #{@talla.nombre_euro}/#{@talla.nombre_usa} creada correctamente"
      redirect_to :action => 'index'
    else
      @page_title = 'Añadir nueva Talla'
      flash[:error] = @talla.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @talla = get_talla(params[:id])
    @page_title = "Editando Talla #{@talla.nombre_euro}/#{@talla.nombre_usa}}"
  end

  def update
    @talla = get_talla(params[:id])
    if @talla.update_attributes(params[:talla])
      flash[:success] = "Talla #{@talla.nombre_euro}/#{@talla.nombre_usa} actualizada correctamente"
      redirect_to :action => 'show', :id => @talla
    else
      flash[:error] = @talla.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @talla = get_talla(params[:id])
    @talla.destroy
    flash[:success] = "Talla #{@talla.nombre_euro}/#{@talla.nombre_usa} eliminada correctamente"
    redirect_to :action => 'index'
  end

  def show
    @talla = get_talla(params[:id])
    @page_title = "Talla #{@talla.nombre_euro}/#{@talla.nombre_usa}"
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
