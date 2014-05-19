class Post < ActiveRecord::Base
  make_like_a_tree

  validates :nombre, :length => { :in => 2..50 }
  validates :subject, :length => { :in => 5..255 }
  validates :texto, :length => { :in => 5..5000 }

  validates_presence_of :nombre, :subject, :texto
  
  attr_accessible :nombre, :subject, :texto, :parent_id
end
