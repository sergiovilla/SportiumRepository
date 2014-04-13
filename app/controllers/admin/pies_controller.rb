class Admin::PiesController < ApplicationController
  def new
    @pie = Pie.new
    @page_title = 'Añadir nuevo número de Pie'
  end

  def create
    @pie = Pie.new(params[:pie])
    if @pie.save
      flash[:success] = "Número de Pie #{@pie.numero} creado correctamente"
      redirect_to :action => 'index'
    else
      @page_title = 'Añadir nuevo número de Pie'
      flash[:error] = @pie.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
    @pie = get_pie(params[:id])
    @page_title = "Editando número de Pie #{@pie.numero}"
  end

  def update
    @pie = get_pie(params[:id])
    if @pie.update_attributes(params[:pie])
      flash[:success] = "Número de Pie #{@pie.numero} actualizado correctamente"
      redirect_to :action => 'show', :id => @pie
    else
      flash[:error] = @pie.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @pie = get_pie(params[:id])
    @pie.destroy
    flash[:success] = "Número de Pie #{@pie.numero} eliminado correctamente"
    redirect_to :action => 'index'
  end

  def show
    @pie = get_pie(params[:id])
    @page_title = "Pie " + @pie.numero.to_s
  end

  def index
    @pies = Pie.all
    @page_title = 'Listado de números de Pie'
  end

  private
  def get_pie(id)
    Pie.find(id);
  end
end
