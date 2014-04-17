#encoding: utf-8
class Admin::MarcasController < ApplicationController
  def new
    @marca = Marca.new
    @page_title = 'Añadir nueva Marca'
  end

  def create
    @marca = Marca.new(params[:marca])
    if @marca.save
      flash[:success] = "Marca #{@marca.nombre} creada correctamente"
      redirect_to :action => 'index'
    else
      @page_title = 'Añadir nueva Marca'
      flash[:error] = @marca.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @marca = get_marca(params[:id])
    @page_title = "Editando Marca #{@marca.nombre}"
  end

  def update
    @marca = get_marca(params[:id])
    if @marca.update_attributes(params[:marca])
      flash[:success] = "Marca #{@marca.nombre} actualizada correctamente"
      redirect_to :action => 'show', :id => @marca
    else
      flash[:error] = @marca.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @marca = get_marca(params[:id])
    @marca.destroy
    flash[:success] = "Marca #{@marca.nombre} eliminada correctamente"
    redirect_to :action => 'index'
  end

  def show
    @marca = get_marca(params[:id])
    @page_title = @marca.nombre
  end

  def index
    @marcas = Marca.all
    @page_title = 'Listado de Marcas'
  end

  private
  def get_marca(id)
    Marca.find(id);
  end
end
