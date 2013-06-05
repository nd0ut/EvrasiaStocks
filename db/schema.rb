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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130604144716) do

  create_table "cities", force: true do |t|
    t.string "name"
  end

  create_table "restaurants", force: true do |t|
    t.integer "city_id"
    t.string  "title"
    t.string  "street"
    t.string  "metro"
    t.string  "phone"
    t.string  "business_hours"
  end

  create_table "stock_hours", force: true do |t|
    t.integer "stock_id"
    t.integer "restaurant_id"
    t.string  "hours"
  end

  create_table "stocks", force: true do |t|
    t.string "title"
    t.text   "description"
    t.string "image_url"
  end

end
