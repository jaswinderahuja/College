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

ActiveRecord::Schema.define(version: 20170501125231) do

  create_table "approving_bodies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campus_drives", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "college_id"
    t.datetime "date_of_drive"
    t.string   "address"
    t.integer  "no_of_students"
    t.integer  "department_id"
    t.string   "hod_email"
    t.string   "coordinator_email_1"
    t.string   "coordinator_email_2"
    t.string   "coordinator_phone_1"
    t.string   "coordinator_phone_2"
    t.string   "description"
    t.boolean  "status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["college_id"], name: "index_campus_drives_on_college_id", using: :btree
    t.index ["department_id"], name: "index_campus_drives_on_department_id", using: :btree
  end

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "college_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "landline_number"
    t.string   "address1"
    t.string   "address2"
    t.integer  "pin_code"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "college_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["city_id"], name: "index_college_addresses_on_city_id", using: :btree
    t.index ["college_id"], name: "index_college_addresses_on_college_id", using: :btree
    t.index ["country_id"], name: "index_college_addresses_on_country_id", using: :btree
    t.index ["state_id"], name: "index_college_addresses_on_state_id", using: :btree
  end

  create_table "college_contact_details", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email_1"
    t.string   "email_2"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.integer  "college_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["college_id"], name: "index_college_contact_details_on_college_id", using: :btree
  end

  create_table "college_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "college_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["college_id"], name: "index_college_users_on_college_id", using: :btree
    t.index ["user_id"], name: "index_college_users_on_user_id", using: :btree
  end

  create_table "colleges", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",               null: false
    t.integer  "is_affliated_to_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "colleges_courses", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "college_id"
    t.integer "course_id"
    t.index ["college_id", "course_id"], name: "index_colleges_courses_on_college_id_and_course_id", unique: true, using: :btree
  end

  create_table "countries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "shortname"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "department_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["department_id"], name: "index_courses_on_department_id", using: :btree
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pin_codes", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "pin_code",   null: false
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_pin_codes_on_city_id", using: :btree
  end

  create_table "states", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.integer  "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_states_on_country_id", using: :btree
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities_approving_bodies", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "university_id"
    t.integer "approving_body_id"
  end

  create_table "university_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "landline_number"
    t.string   "address1"
    t.string   "address2"
    t.integer  "pin_code"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.integer  "university_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["city_id"], name: "index_university_addresses_on_city_id", using: :btree
    t.index ["country_id"], name: "index_university_addresses_on_country_id", using: :btree
    t.index ["state_id"], name: "index_university_addresses_on_state_id", using: :btree
    t.index ["university_id"], name: "index_university_addresses_on_university_id", using: :btree
  end

  create_table "university_contact_details", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "university_id"
    t.string   "email_1"
    t.string   "email_2"
    t.string   "phone_number_1"
    t.string   "phone_number_2"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["university_id"], name: "index_university_contact_details_on_university_id", using: :btree
  end

  create_table "university_courses", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "university_id"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["course_id"], name: "index_university_courses_on_course_id", using: :btree
    t.index ["university_id"], name: "index_university_courses_on_university_id", using: :btree
  end

  create_table "university_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "university_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["university_id"], name: "index_university_users_on_university_id", using: :btree
    t.index ["user_id"], name: "index_university_users_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "campus_drives", "colleges"
  add_foreign_key "campus_drives", "departments"
  add_foreign_key "cities", "states"
  add_foreign_key "college_addresses", "cities"
  add_foreign_key "college_addresses", "colleges"
  add_foreign_key "college_addresses", "countries"
  add_foreign_key "college_addresses", "states"
  add_foreign_key "college_contact_details", "colleges"
  add_foreign_key "college_users", "colleges"
  add_foreign_key "college_users", "users"
  add_foreign_key "courses", "departments"
  add_foreign_key "pin_codes", "cities"
  add_foreign_key "states", "countries"
  add_foreign_key "university_addresses", "cities"
  add_foreign_key "university_addresses", "countries"
  add_foreign_key "university_addresses", "states"
  add_foreign_key "university_addresses", "universities"
  add_foreign_key "university_contact_details", "universities"
  add_foreign_key "university_courses", "courses"
  add_foreign_key "university_courses", "universities"
  add_foreign_key "university_users", "universities"
  add_foreign_key "university_users", "users"
end
