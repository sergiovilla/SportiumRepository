#encoding: utf-8
class Foro::PostsController < ApplicationController
  before_filter :get_post, :except => [:new, :create, :index]

  def index
    @page_title = 'Foro'
    @posts = Post.all
  end

  def new
  	@page_title = 'Nuevo Post'
  	@post = Post.new
  	@post.comentarios.build
  end

  def create
  	@post = Post.new(params[:post])
  	if @post.save
      flash[:notice] = "Post creado con éxito"
      redirect_to :action => 'index'
    else
      @page_title = 'Nuevo Post'
  	  flash[:error] = @post.errors.full_messages
  	  render :action => 'new'
  	end
  end

  def show
  	@page_title = "Post: #{@post.titulo}"
  end

  def reply
  	@page_title = 'Comentando Post'
  	@comentario = @post.comentarios.build
  end

  def save_reply
  	@comentario = @post.comentarios.build(params[:comentario])

  	if @comentario.save
  	  flash[:notice] = "Post comentado con éxito"
  	  redirect_to :action => 'show', :id => @post
  	else
  	  @page_title = 'Comentando Post'
  	  flash[:error] = @comentario.errors.full_messages
  	  render :action => 'reply'
  	end
  end

  def edit
  	@page_title = "Editando Post: #{@post.titulo}"
  end

  def update
    if @post.update_attributes(params[:talla])
      flash[:success] = "Post atualizado correctamente"
      redirect_to :action => 'show', :id => @post
    else
      flash[:error] = @post.errors.full_messages
      render :action => 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post eliminado correctamente"
    redirect_to :action => 'index'
  end

  private
  def get_post
  	@post = Post.find(params[:id])
  end

end
