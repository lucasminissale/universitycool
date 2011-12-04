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

<<<<<<< HEAD
ActiveRecord::Schema.define(:version => 20111204032302) do

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
=======
ActiveRecord::Schema.define(:version => 20111203171636) do
>>>>>>> 4ba6afa2fa0264ea008fc5489cc4a04878a03e21

  create_table "university_searches", :force => true do |t|
    t.string   "university_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
