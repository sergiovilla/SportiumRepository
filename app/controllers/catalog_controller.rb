#encoding: utf-8
class CatalogController < ApplicationController
  def index
  	@page_title = 'Catálogo de productos'
  end

  def camisetas
  	@camisetas = pagination('Camiseta')
  	@page_title = 'Camisetas'
  end

  def calz#encoding: utf-8onas
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
  end

  def search
  end

  def latest
  	@ropas = Ropa.latest 5 # invoques "lastest" method to get the five latest books
    	@page_title = 'Últimos artículos'
  end

  private
  def pagination(tipo)
  	Ropa.paginate :page => params[:page], 
  				  :order => "ropas.id desc",
  				  :per_page => 5,
  				  :conditions => ["tipo = #{tipo}"]
  end
end
