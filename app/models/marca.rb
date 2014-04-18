class Marca < ActiveRecord::Base
	has_many :ropas

	validates :nombre, :presence => true, :uniqueness => true
	
	validates :pais, :presence => true

  	attr_accessible :nombre, :pais
end
