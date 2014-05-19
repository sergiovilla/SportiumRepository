class Post < ActiveRecord::Base
  has_many :comentarios

  validates :autor, :presence => true, :length => { :in => 2..15 }
  validates :titulo, :presence => true, :length => { :in => 2..50 }
  validates :subject, :presence => true, :length => { :in => 5..255 }
  validates :cuerpo, :presence => true, :length => { :in => 5..5000 }
  
  attr_accessible :autor, :titulo, :cuerpo, :subject
end
