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

ActiveRecord::Schema.define(:version => 20111204043717) do

  create_table "universities", :force => true do |t|
    t.string   "name"
    t.string   "fundation"
    t.string   "address"
    t.string   "city"
    t.string   "rector"
    t.integer  "students"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "university_data", :force => true do |t|
    t.integer  "university_id"
    t.string   "creditos_aprobados"
    t.string   "sueldos"
    t.string   "gastos"
    t.string   "adicional_dr"
    t.string   "adicional_ms"
    t.string   "ejecucion"
    t.string   "incentivo"
    t.string   "total"
    t.datetime "date_from"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "university_searches", :force => true do |t|
    t.string   "university_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
