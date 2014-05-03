# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140502182336) do

  create_table "cart_items", :force => true do |t|
    t.integer  "ropa_id"
    t.integer  "cart_id"
    t.float    "precio"
    t.integer  "cantidad"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "colors", :force => true do |t|
    t.string "nombre"
  end

  create_table "marcas", :force => true do |t|
    t.string   "nombre"
    t.string   "pais"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  create_table "ropas", :force => true do |t|
    t.string   "tipo"
    t.string   "nombre"
    t.string   "modelo"
    t.string   "deporte"
    t.float    "precio"
    t.string   "nom_equipo"
    t.integer  "num_pie"
    t.integer  "marca_id"
    t.integer  "color_id"
    t.integer  "talla_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "imagen_file_name"
    t.string   "imagen_content_type"
    t.integer  "imagen_file_size"
    t.datetime "imagen_updated_at"
  end

  add_index "ropas", ["marca_id"], :name => "fk_ropas_marcas"

  create_table "tallas", :force => true do |t|
    t.integer  "nombre_euro"
    t.string   "nombre_usa"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
