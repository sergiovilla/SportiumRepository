class Marca < ActiveRecord::Base

	validates :nombre, :presence => true,
										 :uniqueness => true
	validates :pais, 	 :presence => true

  attr_accessible :nombre, :pais
end
