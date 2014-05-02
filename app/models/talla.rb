class Talla < ActiveRecord::Base
	has_many :ropas

	validates :nombre_euro, :presence => true,
							:uniqueness => true,
							:length => { :maximum => 2 },
							numericality: { only_integer: true }
	
	validates :nombre_usa, :presence => true,
			               :uniqueness => true,
						   :length => { :maximum => 3 },
						   format: {with: /\A[smlxSMLX]+\z/,
						         		  message: "las tallas solo pueden
							   	 	 		  tener las letras S,M,L o X"}
										 
  attr_accessible :nombre_euro, :nombre_usa
end
