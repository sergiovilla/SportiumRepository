#encoding: utf-8
class CatalogController < ApplicationController
  def index
  	@tipos = get_tipos()
  	@page_title = 'Catálogo de productos'
  end

  def camisetas
  	@camisetas = pagination('Camiseta')
  	@page_title = 'Camisetas'
  end

  def calzonas
  	@calzonas = pagination('Calzonas')
  	@page_title = 'Calzonas'
  end

  def equipaciones
  	@equipaciones = pagination('Equipación')
  	@page_title = 'Equipaciones'
  end

  def zapatillas
  	@zapatillas = pagination('Zapatillas')
  	@page_title = 'Zapatillas'
  end

  def chandals
  	@chandals = pagination('Chándal')
  	@page_title = 'Chandals'
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
