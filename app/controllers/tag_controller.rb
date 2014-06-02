#encodign: utf-8

class TagController < ApplicationController
  before_filter :require_user, :except => [:list, :show]
  
  def list
    @page_title = 'Listado de Etiquetas'
    @tags = Tag.paginate :page => params[:page], :order => :name, :per_page => 10
  end

  def show
  	tag = params[:name]
    @page_title = "Ropa etiquetada con '#{tag}'"
    @ropas = Ropa.tagged_with(tag, :any => true).paginate :page => params[:page], :per_page => 6
  end

  def new
    @tag = Tag.new
    @page_title = 'Añadir nueva Etiqueta'
  end

  def create
    @tag = Tag.new(params[:tag])
    if @tag.save
      flash[:success] = "Etiqueta '#{@tag.name}' creada correctamente"
      redirect_to :action => 'list'
    else
      @page_title = 'Añadir nueva Etiqueta'
      flash[:error] = @tag.errors.full_messages
      render :action => 'new'
    end
  end

  def edit
  	@tag = Tag.find params[:id]
  	@page_title = "Editando etiqueta '#{@tag.name}'"
  end

  def update
  	tag = Tag.find(params[:id])
    if tag.update_attribute(:name, params[:tag][:name])
      flash[:success] = "Etiqueta '#{tag.name}' actualizada correctamente"
      redirect_to :action => 'show', :name => tag.name
    else
      flash[:error] = tag.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
  	tag = Tag.find(params[:id])
    tag.destroy
    flash[:success] = "Etiqueta '#{tag.name}' eliminada correctamente"
    redirect_to :action => 'list'
  end

end
