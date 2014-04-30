#encoding: utf-8
class CatalogController < ApplicationController
  def index
  	@page_title = 'Catálogo de productos'
  end

  def index_catalogo
  	@ropas = pagination(params[:tipo])
  	@page_title = 'Catálogo de ' + params[:tipo]
  end
  
  def index_marcas
  	@marcas = pagination_marcas()
  	@page_title = 'Catálogo de marcas'
  end
  
  def index_catalogo_marcas
  	@marca = Marca.find(params[:id])
  	@ropas = pagination_ropas_marcas(@marca.id)
  	@page_title = 'Catálogo de ' + @marca.nombre
  	render 'index_catalogo'
  end

  def show
  	@ropa = Ropa.find(params[:id])
  	@page_title = @ropa.nombre
	@tipo = @ropa.tipo
	if @tipo  == 'Zapatillas'
  		@tipoZapatillas = true
  	else @tipoZapatillas = false
  	end
  end

  def search
  end

  def latest
  	@ropas = Ropa.latest 5 # invoca "lastest" method para obtener las 5 ultimas ropas
    @page_title = 'Últimos artículos'
  end

  private
  def pagination(tipo)
  	Ropa.paginate :page => params[:page], 
  				  :order => "ropas.id desc",
  				  :per_page => 5,
  				  :conditions => ["tipo = '#{tipo}'"]
  end
  
  def pagination_marcas()
  	Marca.paginate :page => params[:page], 
  				  :order => "marcas.id desc",
  				  :per_page => 5
  end
  
  def pagination_ropas_marcas(marca)
  	Ropa.paginate :page => params[:page], 
  				  :order => "ropas.id desc",
  				  :per_page => 5,
  				  :conditions => ["marca_id = '#{marca}'"]
  end
  
  def get_tipos()
    Ropa.select(:tipo).distinct;
  end
  
end
