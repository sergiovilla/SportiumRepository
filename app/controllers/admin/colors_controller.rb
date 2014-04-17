#encoding: utf-8
class Admin::ColorsController < ApplicationController
  def new
    @color = Color.new
    @page_title = 'Añadir nuevo Color'
  end

  def create
    @color = Color.new(:nombre => params[:color][:nombre].capitalize)
    if @color.save
      flash[:success] = "Color #{@color.nombre} creado correctamente"
      redirect_to :action => 'index'
    else
      @page_title = 'Añadir nuevo Color'
      flash[:error] = @color.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @color = get_color(params[:id])
    @page_title = "Editando Color #{@color.nombre}"
  end

  def update
    @color = get_color(params[:id])
    if @color.update_attribute('nombre', params[:color][:nombre].capitalize)
      flash[:success] = "Color #{@color.nombre} actualizado correctamente"
      redirect_to :action => 'show', :id => @color
    else
      flash[:error] = @color.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @color = get_color(params[:id])
    @color.destroy
    flash[:success] = "Color #{@color.nombre} eliminado correctamente"
    redirect_to :action => 'index'
  end

  def show
    @color = get_color(params[:id])
    @page_title = "Color " + @color.nombre
  end

  def index
    @colores = Color.all
    @page_title = 'Listado de Colores'
  end

  private
  def get_color(id)
    Color.find(id);
  end
end
