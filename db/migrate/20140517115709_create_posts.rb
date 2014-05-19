#encoding: utf-8
class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :autor
      t.string :titulo
      t.string :subject
      t.text :cuerpo

      t.timestamps
    end
  end
end
