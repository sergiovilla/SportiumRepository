#encoding: utf-8
class Admin::RopasController < ApplicationController
  def new
    @page_title = 'Añadir nueva Ropa'
  end

  def new_ropa
  	@ropa = Ropa.new
  	@tipo = params[:tipo]
  	@marcas = get_all_marcas()
  	@colores = get_all_colors()
  	@tallas = get_all_tallas()
  	if @tipo.nil?
  		@page_title = "Errores de formulario"
  	else
  		@page_title = "Añadiendo #{@tipo}"
    end
  end
  
  def new_zapatillas
  	@ropa = Ropa.new
  	@tipo = 'Zapatillas'
  	@marcas = get_all_marcas()
  	@colores = get_all_colors()
  	@page_title = 'Añadiendo nuevas zapatillas'
  end
  
  def create
    @ropa = Ropa.new(params[:ropa])
    if @ropa.save
      flash[:notice] = "#{@ropa.tipo} #{@ropa.nombre} creada correctamente."
      redirect_to :action => 'index'
    else
      flash[:error] = @ropa.errors.full_messages
      if @ropa.tipo == 'Zapatillas'
      	redirect_to :action => 'new_zapatillas'
      else
      	redirect_to :action => 'new_ropa'
      end
    end
  end

  def edit
  	@ropa = get_ropa(params[:id])
  	@marcas = get_all_marcas()
  	@colores = get_all_colors()
  	@tallas = get_all_tallas()
  	@tipo = @ropa.tipo
  	if @tipo  == 'Zapatillas'
  		@tipoZapatillas = true
  	else @tipoZapatillas = false
  	end
    @page_title = "Editando #{@ropa.nombre} "
  end

  def update
 	@ropa = get_ropa(params[:id])
    if @ropa.update_attributes(params[:ropa])
      flash[:success] = "#{@ropa.nombre} actualizada correctamente"
      redirect_to :action => 'show', :id => @ropa
    else
      flash[:error] = @ropa.errors.full_messages
      redirect_to :action => 'edit'
    end
  end

 def destroy
    @ropa = get_ropa(params[:id])
    @ropa.destroy
    flash[:success] = "#{@ropa.nombre}  eliminada correctamente"
    redirect_to :action => 'index'
  end

  def show
    @ropa = get_ropa(params[:id])
    @page_title = "#{@ropa.nombre}"
  end

  def index
    @ropas = get_all_ropas(params[:id])
    @page_title = 'Listado de Ropas'
  end

  private
  def get_ropa(id)
    Ropa.find(id);
  end
  
  def get_all_ropas(id)
  	Ropa.all
  end
  
  def get_all_marcas()
  	Marca.all
  end
  
  def get_all_colors()
  	Color.all
  end
  
  def get_all_tallas()
  	Talla.all
  end
  
  
end
