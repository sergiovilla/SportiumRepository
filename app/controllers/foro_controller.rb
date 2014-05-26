#encoding: utf-8

class ForoController < ApplicationController

  def index
    @page_title = 'Foro'
    @posts = Post.paginate :page => params[:page], 
            :order => "root_id desc, lft",
            :per_page => 20
  end

  def reply
    reply_to = Post.find(params[:id])
    @page_title = "Responder a '#{reply_to.subject}'"
    @post = Post.new(:parent_id => reply_to.id)
    render :action => 'post'
  end

  def show
    @post = Post.find(params[:id])
    @page_title = "'#{@post.subject}'"
  end

  def post
    @page_title = 'Postear'
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      flash[:notice] = 'Post creado de forma correcta'
      redirect_to :action => 'index'
    else
      parent = Post.find_by_id(@post.parent_id)
      if @post.parent_id == 0
        @page_title = 'Postear'
      else
        @page_title = "Responder a '#{parent.subject}'"
      end
      flash.now[:error] = @post.errors.full_messages
      render :action => 'post'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    childs = @post.all_children

    childs.each do |post|
      post.destroy
    end

    @post.destroy

    flash[:success] = "Post eliminado correctamente"
    redirect_to :action => 'index'
  end
end
