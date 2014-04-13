class Pie < ActiveRecord::Base

	validates :numero, :presence => true,
										 :uniqueness => true,
										 :numericality => { :only_integer => true,
																				:greater_than => 29,
																				:less_than => 61 }
  
  attr_accessible :numero
end
