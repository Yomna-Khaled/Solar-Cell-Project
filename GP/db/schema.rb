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

ActiveRecord::Schema.define(version: 20150525081145) do

  create_table "categories", force: :cascade do |t|
    t.string   "category",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "containers", force: :cascade do |t|
    t.float    "width",       limit: 24
    t.float    "height",      limit: 24
    t.string   "serialNo",    limit: 255
    t.integer  "capacity",    limit: 4
    t.float    "price",       limit: 24
    t.float    "total_power", limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "crews", force: :cascade do |t|
    t.string   "no_of_workers", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "employee_managers", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.integer  "crew_id",     limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "employee_managers", ["crew_id"], name: "index_employee_managers_on_crew_id", using: :btree
  add_index "employee_managers", ["employee_id"], name: "index_employee_managers_on_employee_id", using: :btree

  create_table "employee_phones", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.string   "phone",       limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "employee_phones", ["employee_id"], name: "index_employee_phones_on_employee_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.float    "salary",             limit: 24
    t.float    "houre_rate",         limit: 24
    t.text     "education_level",    limit: 65535
    t.string   "Governamental_ID",   limit: 255
    t.string   "position",           limit: 255
    t.integer  "crew_id",            limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "password",           limit: 255
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size",    limit: 4
    t.datetime "image_updated_at"
    t.integer  "category_id",        limit: 4
    t.string   "user_name",          limit: 255
  end

  add_index "employees", ["category_id"], name: "index_employees_on_category_id", using: :btree
  add_index "employees", ["crew_id"], name: "index_employees_on_crew_id", using: :btree

  create_table "machines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "material_properties", force: :cascade do |t|
    t.integer  "material_id", limit: 4
    t.integer  "property_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "value",       limit: 255
  end

  add_index "material_properties", ["material_id"], name: "index_material_properties_on_material_id", using: :btree
  add_index "material_properties", ["property_id"], name: "index_material_properties_on_property_id", using: :btree

  create_table "material_vendors", force: :cascade do |t|
    t.integer  "vendor_id",   limit: 4
    t.integer  "material_id", limit: 4
    t.date     "date"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "material_vendors", ["material_id"], name: "index_material_vendors_on_material_id", using: :btree
  add_index "material_vendors", ["vendor_id"], name: "index_material_vendors_on_vendor_id", using: :btree

  create_table "materials", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "quantity_value",      limit: 4
    t.float    "price",               limit: 24
    t.integer  "Min_Number",          limit: 4
    t.string   "stockNo",             limit: 255
    t.string   "shelfNo",             limit: 255
    t.date     "production_date"
    t.date     "expiration_date"
    t.integer  "quantity_id",         limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "materials", ["quantity_id"], name: "index_materials_on_quantity_id", using: :btree

  create_table "prices", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.float    "price",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "production_shifts", force: :cascade do |t|
    t.integer  "material_id",       limit: 4
    t.integer  "shift_id",          limit: 4
    t.float    "material_quantity", limit: 24
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "production_shifts", ["material_id"], name: "index_production_shifts_on_material_id", using: :btree
  add_index "production_shifts", ["shift_id"], name: "index_production_shifts_on_shift_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "properties", ["name"], name: "index_properties_on_name", unique: true, using: :btree

  create_table "quantities", force: :cascade do |t|
    t.string   "unit_name",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "shifts", force: :cascade do |t|
    t.integer  "employee_id",      limit: 4
    t.integer  "crew_id",          limit: 4
    t.date     "start_shift_date"
    t.date     "end_shift_date"
    t.time     "start_shift_time"
    t.time     "end_shift_time"
    t.float    "production_rate",  limit: 24, default: 0.0
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "shifts", ["crew_id"], name: "index_shifts_on_crew_id", using: :btree
  add_index "shifts", ["employee_id"], name: "index_shifts_on_employee_id", using: :btree

  create_table "solar_panels", force: :cascade do |t|
    t.date     "production_date"
    t.float    "height",          limit: 24
    t.float    "width",           limit: 24
    t.float    "power",           limit: 24
    t.string   "celltype",        limit: 255
    t.string   "subtype",         limit: 255
    t.float    "price",           limit: 24
    t.integer  "serialNo",        limit: 4
    t.integer  "container_id",    limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "shift_id",        limit: 4
    t.integer  "cellno",          limit: 4
  end

  add_index "solar_panels", ["container_id"], name: "index_solar_panels_on_container_id", using: :btree
  add_index "solar_panels", ["shift_id"], name: "index_solar_panels_on_shift_id", using: :btree

  create_table "spare_parts", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.integer  "quantity",            limit: 4
    t.float    "price",               limit: 24
    t.integer  "machine_id",          limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "avatar_file_name",    limit: 255
    t.string   "avatar_content_type", limit: 255
    t.integer  "avatar_file_size",    limit: 4
    t.datetime "avatar_updated_at"
  end

  add_index "spare_parts", ["machine_id"], name: "index_spare_parts_on_machine_id", using: :btree

  create_table "vendor_containers", force: :cascade do |t|
    t.integer  "vendor_id",    limit: 4
    t.integer  "container_id", limit: 4
    t.date     "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "vendor_containers", ["container_id"], name: "index_vendor_containers_on_container_id", using: :btree
  add_index "vendor_containers", ["vendor_id"], name: "index_vendor_containers_on_vendor_id", using: :btree

  create_table "vendor_phones", force: :cascade do |t|
    t.integer  "vendor_id",  limit: 4
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "vendor_phones", ["vendor_id"], name: "index_vendor_phones_on_vendor_id", using: :btree

  create_table "vendor_spares", force: :cascade do |t|
    t.date     "date"
    t.integer  "vendor_id",     limit: 4
    t.integer  "spare_part_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "vendor_spares", ["spare_part_id"], name: "index_vendor_spares_on_spare_part_id", using: :btree
  add_index "vendor_spares", ["vendor_id"], name: "index_vendor_spares_on_vendor_id", using: :btree

  create_table "vendors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "employee_managers", "crews"
  add_foreign_key "employee_managers", "employees"
  add_foreign_key "employee_phones", "employees"
  add_foreign_key "employees", "categories"
  add_foreign_key "employees", "crews"
  add_foreign_key "material_properties", "materials"
  add_foreign_key "material_properties", "properties"
  add_foreign_key "material_vendors", "materials"
  add_foreign_key "material_vendors", "vendors"
  add_foreign_key "materials", "quantities"
  add_foreign_key "production_shifts", "materials"
  add_foreign_key "production_shifts", "shifts"
  add_foreign_key "shifts", "crews"
  add_foreign_key "shifts", "employees"
  add_foreign_key "solar_panels", "containers"
  add_foreign_key "solar_panels", "shifts"
  add_foreign_key "spare_parts", "machines"
  add_foreign_key "vendor_containers", "containers"
  add_foreign_key "vendor_containers", "vendors"
  add_foreign_key "vendor_phones", "vendors"
  add_foreign_key "vendor_spares", "spare_parts"
  add_foreign_key "vendor_spares", "vendors"
end
