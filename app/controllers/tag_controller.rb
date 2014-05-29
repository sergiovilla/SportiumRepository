#encodign: utf-8

class TagController < ApplicationController
  
  def list
    @page_title = 'Listado de Etiquetas'
    @tags = Tag.paginate :page => params[:page], :order => :name, :per_page => 10
  end

  def show
  	tag = params[:name]
    @page_title = "Ropa etiquetada con '#{tag}'"
    @ropas = Ropa.tagged_with(tag, :any => true).paginate :page => params[:page], :per_page => 6
  end
end
