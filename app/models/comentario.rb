class Comentario < ActiveRecord::Base
  belongs_to :post

  validates :autor, :presence => true, :length => { :in => 2..15 }
  validates :cuerpo, :presence => true, :length => { :in => 5..5000 }
  
  attr_accessible :autor, :cuerpo
end
