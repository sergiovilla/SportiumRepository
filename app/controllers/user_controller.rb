#encoding: utf-8
class UserController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new
    @page_title = 'Crear nueva cuenta'
    if current_user
      flash[:notice] = 'Sólo puede tener una cuenta.'
      redirect_to :controller => 'about', :action => 'index'
    else
      # only when there are no accounts it allows to create a new one, unique in the system
      redirect_to :controller => 'user_session', :action => 'new' unless User.count == 0
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save # the new user has been logged in automatically
      flash[:notice] = "Cuenta #{@user.name} ha sido creada correctamente."
      redirect_to :action => 'show'
    else
      @page_title = 'Crer nueva cuenta'
      flash[:error] = @user.errors.full_messages
      render :action => :new
    end
  end

  def edit
    @user = current_user
    @page_title = 'Editar cuenta'
  end

  def update
    @user = current_user

    if params[:user][:password].to_s.blank?
      if update_single_attributes(@user, params[:user])
        flash[:notice] = "Cuenta #{@user.name} ha sido actualizada correctamente."
        redirect_to :action => 'show'
      else
        @page_title = 'Editar cuenta'
        flash[:error] = @user.errors.full_messages
        render :action => 'edit'
      end
    elsif @user.update_attributes(params[:user])
      flash[:notice] = "Cuenta #{@user.name} ha sido actualizada correctamente."
      redirect_to :action => 'show'
    else
      @page_title = 'Editar cuenta'
      flash[:error] = @user.errors.full_messages
      render :action => 'edit'
    end
  end

  def show
    @user = current_user
    @page_title = @user.name
  end

  private
  def update_single_attributes(user, attrs)
    user.name = attrs[:name]
    user.login = attrs[:login]
    user.email = attrs[:email]
    user.valid?

    user.errors.delete :password
    user.errors.delete :password_confirmation

    if !user.errors[:name].blank? or !user.errors[:login].blank? or !user.errors[:email].blank?
      return false
    else
      user.update_attribute :name, attrs[:name]
      user.update_attribute :login, attrs[:login]
      user.update_attribute :email, attrs[:email]
      return true
    end
  end
end
