class Color < ActiveRecord::Base

	validates :nombre, :presence => true,
										 :uniqueness => true
										 
  attr_accessible :nombre
end
