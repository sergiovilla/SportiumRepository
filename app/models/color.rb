class Color < ActiveRecord::Base
	has_many :ropas
	
	validates :nombre, :presence => true,
										 :uniqueness => true
										 
  attr_accessible :nombre
end
