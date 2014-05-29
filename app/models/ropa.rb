class Ropa < ActiveRecord::Base
  acts_as_taggable

	belongs_to :marca
	belongs_to :color
	belongs_to :talla
	has_many :cart_items
	has_many :carts, :through => :cart_items
	
	has_attached_file :imagen, :styles => { :large => "500x500>", :medium => "300x300>", :thumb => "100x100>"}
	validates_attachment_content_type :imagen, :content_type => ["image/jpg", "image/jpeg", "image/png"]

	validates_associated :marca
	validates_associated :color
	validates_associated :talla

	validates :marca, :presence => true	
	validates :tipo, :presence => true
	validates :nombre, :presence => true
	validates :precio, :presence => true,  numericality: true
	validates :modelo, :presence => true
	validates :num_pie, :presence => true, :if => :tipoZapatillas?, :length => { :is => 2 }, numericality: { only_integer: true }
	
	
  	attr_accessible :marca_id, :color_id, :talla_id, :tipo, :nombre, :precio, :modelo, :num_pie, :nom_equipo, :deporte, :imagen

  	def self.latest(num)
    	find :all, :limit => num, :order => "ropas.id desc"
    end

    def self.search(search)
    	if search
    		where('nombre LIKE ?', "%#{search}%")
    	else
    		scoped
    	end
    end
    
    def tipoZapatillas?
    	tipo == 'Zapatillas'
    end
    
    #método que devuelve la URL del ejemplo de imagen para el catálogo de cada tipo
    def sampleURL()
    	"/imagenesCatalogo/catalogo_#{tipo}"
    end
    
end
