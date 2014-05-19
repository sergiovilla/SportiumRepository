class User < ActiveRecord::Base
  acts_as_authentic do |a|
    a.validate_login_field = true
    a.validate_password_field = true
    a.require_password_confirmation = true
    a.logged_in_timeout = 10.minutes # default is 10.minutes
  end

  attr_accessible :name, :login, :email, :password, :password_confirmation
  validates_presence_of :name, :login, :email, :password, :password_confirmation
  validates_length_of :name, :in => 3..225
  validates_uniqueness_of :name, :login, :email

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
    UserMailer.password_reset(self).deliver
  end
end
