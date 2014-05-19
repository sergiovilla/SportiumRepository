class CreateComentarios < ActiveRecord::Migration
  def change
    create_table :comentarios do |t|
      t.string :autor
      t.text :cuerpo

      #clave foránea
      t.references :post

      t.timestamps
    end

    #restricciones de claves foráneas
    say_with_time 'Añadiendo clave foránea' do
    	execute 'ALTER TABLE comentarios ADD CONSTRAINT fk_comentarios_posts
    		FOREIGN KEY ( post_id ) REFERENCES posts( id ) ON DELETE CASCADE'
    end
  end
end
