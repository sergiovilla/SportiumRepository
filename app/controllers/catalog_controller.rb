#encoding: utf-8
class CatalogController < ApplicationController
  def index
  	@page_title = 'Catálogo de productos'
  end

  def index_catalogo
  	@ropas = pagination(params[:tipo])
  	@page_title = 'Catálogo de ' + params[:tipo]
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
  
  def get_tipos()
    Ropa.select(:tipo).distinct;
  end
end
