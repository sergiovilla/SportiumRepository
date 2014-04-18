#encoding: UTF-8
class CreateRopas < ActiveRecord::Migration
  def change
    create_table :ropas do |t|
    	#comunes a todos los tipos
    	t.string :tipo
    	t.string :nombre
    	t.string :modelo
    	t.string :deporte #puede no especificarse
    	t.float :precio
    	
    	t.string :nom_equipo #solo tipo equipacion o camiseta o calzonas si se requiere
    	t.integer :num_pie #solo tipo zapatillas
    	
    	#claves foraneas
    	t.integer :marca_id
    	t.integer :color_id
    	t.integer :talla_id
    	
      	t.timestamps
    end
    
    #restricciones de claves foráneas
    say_with_time 'Añadiendo claves foráneas' do
    	execute 'ALTER TABLE ropas ADD CONSTRAINT fk_ropas_marcas
    		FOREIGN KEY ( marca_id ) REFERENCES marcas( id ) ON DELETE CASCADE'
    		
    	execute 'ALTER TABLE ropas ADD CONSTRAINT fk_ropas_colors
    	FOREIGN KEY ( color_id ) REFERENCES colors( id ) ON DELETE CASCADE'
    	
    	execute 'ALTER TABLE ropas ADD CONSTRAINT fk_ropas_tallas
    	FOREIGN KEY ( talla_id ) REFERENCES tallas( id ) ON DELETE CASCADE'
    end
    
  end
end
