#encoding: utf-8
class PasswordResetController < ApplicationController
  def new
  	@page_title = "Olvidé mi contraseña"
  end

  def create
    user = User.find_by_email(params[:email])
    if user
    	user.send_password_reset
    	flash[:notice] = "Se le ha enviado un email con las instrucciones para reiniciar su contraseña."
    else
    	flash[:warning] = "No existe ningún usuario con el email proporcionado"
    end

    redirect_to root_url
  end

  def edit
  	@page_title = "Actualizando contraseña"
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	#Aquí se entra desde la url enviada por correo
    @user = User.find_by_password_reset_token!(params[:id])

    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :warning => "El tiempo para reiniciar la contraseña ha expirado."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "¡Contraseña reiniciada! Bienvenido de nuevo #{@user.name}"
    else
      render :edit
    end
  end

end
