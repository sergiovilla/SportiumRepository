class Talla < ActiveRecord::Base

	validates :nombre_euro, :presence => true,
										 :uniqueness => true,
										 :length => { :maximum => 3 }
	validates :nombre_usa, :presence => true,
										 :uniqueness => true,
										 :length => { :maximum => 3 }
										 
  attr_accessible :nombre_euro, :nombre_usa
end
