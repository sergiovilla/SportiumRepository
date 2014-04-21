class Marca < ActiveRecord::Base
	has_many :ropas
	
	has_attached_file :imagen, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>"}
	validates_attachment_content_type :imagen, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :nombre, :presence => true, :uniqueness => true
	
	validates :pais, :presence => true

  	attr_accessible :nombre, :pais, :imagen
end
