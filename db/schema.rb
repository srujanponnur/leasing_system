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

ActiveRecord::Schema.define(version: 2021_09_25_004028) do

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "name"
    t.string "phonenumber"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["user_id"], name: "index_admins_on_user_id"
  end

  create_table "applicants", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.index ["email"], name: "index_applicants_on_email"
    t.index ["user_id"], name: "index_applicants_on_user_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "leasing_agent_id"
    t.integer "applicant_id", null: false
    t.integer "property_id", null: false
    t.index ["applicant_id"], name: "index_applications_on_applicant_id"
    t.index ["leasing_agent_id"], name: "index_applications_on_leasing_agent_id"
    t.index ["property_id"], name: "index_applications_on_property_id"
  end

  create_table "leasing_agents", force: :cascade do |t|
    t.string "password_digest"
    t.string "name"
    t.string "phone_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.integer "user_id", null: false
    t.index ["email"], name: "index_leasing_agents_on_email", unique: true
    t.index ["user_id"], name: "index_leasing_agents_on_user_id"
  end

  create_table "occupants", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "property_id", null: false
    t.integer "applicant_id", null: false
    t.index ["applicant_id"], name: "index_occupants_on_applicant_id"
    t.index ["property_id"], name: "index_occupants_on_property_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "size"
    t.integer "terms_available"
    t.date "earliest_start_date"
    t.integer "application_fee"
    t.integer "monthly_rent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "applicant_id"
    t.integer "property_feature_id"
    t.integer "units"
    t.index ["applicant_id"], name: "index_properties_on_applicant_id"
    t.index ["property_feature_id"], name: "index_properties_on_property_feature_id"
  end

  create_table "property_features", force: :cascade do |t|
    t.boolean "are_pets_allowed"
    t.boolean "in_unit_laundry"
    t.boolean "parking"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "user_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "admins", "users"
  add_foreign_key "applicants", "users"
  add_foreign_key "applications", "applicants"
  add_foreign_key "applications", "leasing_agents"
  add_foreign_key "applications", "properties"
  add_foreign_key "leasing_agents", "users"
  add_foreign_key "occupants", "applicants"
  add_foreign_key "occupants", "properties"
  add_foreign_key "properties", "applicants"
  add_foreign_key "properties", "property_features"
end
