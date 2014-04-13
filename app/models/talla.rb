class Talla < ActiveRecord::Base

	validates :nombre, :presence => true,
										 :uniqueness => true,
										 :length => { :maximum => 3 }
										 
  attr_accessible :nombre
end
