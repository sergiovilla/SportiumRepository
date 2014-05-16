#encoding: utf-8
class CatalogController < ApplicationController
  before_filter :initialize_cart, :except => [:show, :latest]
  
  def index
  	@page_title = 'Catálogo de productos'
  end

  def index_catalogo
    if params[:tipo].eql? 'Marcas'
        @marcas = pagination_marcas()
        @page_title = 'Catálogo de marcas'
        render 'index_marcas'
    else
      	@ropas = pagination(params[:tipo])
      	@page_title = 'Catálogo de ' + params[:tipo]
    end
  end
  
  def index_catalogo_marcas
  	@marca = Marca.where(nombre: params[:nombre]).first
  	@ropas = pagination_ropas_marcas(@marca.id)
  	@page_title = 'Catálogo de ' + @marca.nombre
  	render 'index_catalogo'
  end

  def show
  	@ropa = Ropa.find(params[:id])
  	@page_title = @ropa.nombre
  	@tipo = @ropa.tipo
  	if @tipo.eql? 'Zapatillas'
  		@tipoZapatillas = true
  	else 
        @tipoZapatillas = false
  	end
  end

  def search
    @page_title = 'Búsqueda'
    @ropas = Ropa.search(params[:query]).paginate :page => params[:page], 
            :order => "ropas.id desc",
            :per_page => 6
  end

  def latest
  	@ropas = Ropa.latest 6 # invoca "latest" method para obtener las 6 últimas ropas
    @page_title = 'Últimos artículos'
  end

  private
  def pagination(tipo)
  	Ropa.paginate :page => params[:page], 
  				  :order => "ropas.id desc",
  				  :per_page => 6,
  				  :conditions => ["tipo = '#{tipo}'"]
  end
  
  def pagination_marcas()
  	Marca.paginate :page => params[:page], 
  				  :order => "marcas.id desc",
  				  :per_page => 6
  end
  
  def pagination_ropas_marcas(marca)
  	Ropa.paginate :page => params[:page], 
  				  :order => "ropas.id desc",
  				  :per_page => 6,
  				  :conditions => ["marca_id = '#{marca}'"]
  end
  
  def get_tipos()
    Ropa.select(:tipo).distinct;
  end
  
end
