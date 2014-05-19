#encoding: utf-8
class UserMailer < ActionMailer::Base
  default from: "sportium.ine@gmail.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Reiniciar contraseña"
  end
end
