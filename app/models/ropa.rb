class Ropa < ActiveRecord::Base
	belongs_to :marca
	belongs_to :color
	belongs_to :talla
	
	has_attached_file :imagen, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>"}
	validates_attachment_content_type :imagen, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates :marca, :presence => true
	validates_associated :marca

	validates_associated :color

	validates_associated :talla
	
	validates :tipo, :presence => true
	validates :nombre, :presence => true, :uniqueness => true
	validates :precio, :presence => true,  numericality: true
	validates :modelo, :presence => true
	validates :num_pie, allow_nil: true, :length => { :is => 2 }, numericality: { only_integer: true }
	
  	attr_accessible :marca_id, :color_id, :talla_id, :tipo, :nombre, :precio, :modelo, :num_pie, :nom_equipo, :deporte, :imagen
end
