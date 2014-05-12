class UserMailer < ActionMailer::Base
  default from: "darkangelsergio@gmail.com"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Reiniciar contraseña"
  end
end
