# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_12_04_210349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "image"
    t.string "name"
    t.string "effect"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moves", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "category"
    t.integer "pp"
    t.integer "power"
    t.integer "accuracy"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_in_teams", force: :cascade do |t|
    t.integer "team_id"
    t.integer "unique_pokemon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.string "national_dex_num"
    t.string "name"
    t.string "first_type"
    t.string "second_type"
    t.string "abilities"
    t.decimal "hp", precision: 9, scale: 4
    t.decimal "atk", precision: 9, scale: 4
    t.decimal "defe", precision: 9, scale: 4
    t.decimal "spa", precision: 9, scale: 4
    t.decimal "spd", precision: 9, scale: 4
    t.decimal "spe", precision: 9, scale: 4
    t.string "url"
    t.string "icon"
    t.string "first_type_image"
    t.string "second_type_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer "trainer_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainers", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.integer "level"
    t.integer "experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  create_table "unique_pokemons", force: :cascade do |t|
    t.string "nickname"
    t.string "nature"
    t.boolean "shiny"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hp_ev"
    t.integer "atk_ev"
    t.integer "defe_ev"
    t.integer "spa_ev"
    t.integer "spd_ev"
    t.integer "spe_ev"
    t.integer "hp_iv"
    t.integer "atk_iv"
    t.integer "defe_iv"
    t.integer "spa_iv"
    t.integer "spd_iv"
    t.integer "spe_iv"
    t.integer "pokemon_id"
    t.integer "trainer_id"
    t.integer "level"
    t.integer "hp"
    t.integer "atk"
    t.integer "defe"
    t.integer "spa"
    t.integer "spd"
    t.integer "spe"
    t.string "ability"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.integer "current_trainer_id"
  end

end
