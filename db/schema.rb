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

ActiveRecord::Schema.define(version: 20150223070552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_stat_statements"

  create_table "applicants", force: true do |t|
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial",         limit: 3
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.boolean  "payment",                          default: false
    t.string   "facebook_image"
    t.string   "google_image"
    t.string   "authentication_token"
  end

  add_index "applicants", ["email"], name: "index_applicants_on_email", unique: true, using: :btree
  add_index "applicants", ["reset_password_token"], name: "index_applicants_on_reset_password_token", unique: true, using: :btree

  create_table "applicants_roommate_groups", force: true do |t|
    t.integer "applicant_id"
    t.integer "roommate_group_id"
  end

  add_index "applicants_roommate_groups", ["applicant_id", "roommate_group_id"], name: "index_on_applicant_id_and_roommate_group_id", using: :btree
  add_index "applicants_roommate_groups", ["applicant_id"], name: "index_applicants_roommate_groups_on_applicant_id", using: :btree
  add_index "applicants_roommate_groups", ["roommate_group_id"], name: "index_applicants_roommate_groups_on_roommate_group_id", using: :btree

  create_table "applies", force: true do |t|
    t.integer  "applicable_id",                      null: false
    t.integer  "rental_offering_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.string   "applicable_type"
    t.boolean  "custom_agreement",   default: false
    t.string   "agreement_status"
    t.string   "agreement_guid"
    t.string   "agreement_url"
  end

  add_index "applies", ["rental_offering_id", "applicable_id"], name: "index_applies_on_rental_offerings_and_applicants", unique: true, using: :btree

  create_table "attachments", force: true do |t|
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "property_manager_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "co_signers", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "ssn"
    t.date     "dob"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "phone"
    t.string   "email"
    t.string   "rent_own"
    t.string   "landlord_phone"
    t.integer  "rent_mortage"
    t.string   "employer_name"
    t.string   "emp_position"
    t.integer  "m_gross_income"
    t.string   "a_source_income"
    t.string   "marrital_status"
    t.string   "spouse_name"
    t.string   "spouse_ssn"
    t.date     "spouse_dob"
    t.string   "spouse_employer_name"
    t.string   "spouse_position"
    t.integer  "spouse_monthly_gross_income"
    t.string   "spouse_additional_source_income"
    t.string   "saving_account_bank_name"
    t.string   "checking_account_bank_name"
    t.string   "lenders_name"
    t.string   "loan_type"
    t.boolean  "o_court_judgement"
    t.boolean  "party_lawsuit"
    t.boolean  "property_foreclosed"
    t.boolean  "declared_bankruptcy"
    t.boolean  "is_felony"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "co_signs", force: true do |t|
    t.integer  "co_signer_id"
    t.integer  "apply_id"
    t.string   "cosigning_for"
    t.string   "relationship"
    t.date     "signature_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "invitations", force: true do |t|
    t.string   "email"
    t.boolean  "status",            default: false
    t.integer  "roommate_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["roommate_group_id"], name: "index_invitations_on_roommate_group_id", using: :btree

  create_table "profiles", force: true do |t|
    t.date     "born_on"
    t.string   "ssn"
    t.string   "drivers_license_number"
    t.string   "drivers_license_state"
    t.string   "phone_number"
    t.string   "bank_name"
    t.string   "bank_city_and_state"
    t.text     "pets_description"
    t.text     "vehicles_description"
    t.boolean  "was_ever_evicted"
    t.text     "was_ever_evicted_explanation"
    t.boolean  "is_felon"
    t.text     "is_felon_explanation"
    t.string   "character_reference_name"
    t.string   "character_reference_contact_info"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_phone_number"
    t.string   "current_home_street_address"
    t.date     "current_home_moved_in_on"
    t.text     "current_home_dissatisfaction_explanation"
    t.string   "current_home_owner"
    t.string   "current_home_owner_contact_info"
    t.string   "previous_home_street_address"
    t.date     "previous_home_moved_in_on"
    t.date     "previous_home_moved_out"
    t.text     "previous_home_dissatisfaction_explanation"
    t.string   "previous_home_owner"
    t.string   "previous_home_owner_contact_info"
    t.string   "employment_status"
    t.string   "current_employment_position"
    t.integer  "current_employment_monthly_income"
    t.string   "current_employment_supervisor"
    t.string   "current_employment_employer"
    t.string   "current_employment_employer_phone_number"
    t.string   "current_employment_employer_email_address"
    t.string   "current_employment_started_on"
    t.string   "previous_employment_position"
    t.integer  "previous_employment_monthly_income"
    t.string   "previous_employment_supervisor"
    t.string   "previous_employment_employer"
    t.string   "previous_employment_employer_phone_number"
    t.string   "previous_employment_employer_email_address"
    t.string   "previous_employment_started_on"
    t.string   "previous_employment_ended_on"
    t.integer  "other_income_monthly_amount"
    t.string   "other_income_sources"
    t.string   "cosigner_name"
    t.string   "cosigner_email_address"
    t.date     "desires_to_move_in_on"
    t.text     "roommates_description"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "victig_order_id"
    t.string   "victig_url"
  end

  add_index "profiles", ["applicant_id"], name: "index_profiles_on_applicant_id", using: :btree

  create_table "property_managers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                                                       null: false
    t.string   "customer_contact_email_address"
    t.integer  "customer_contact_phone_number",  limit: 8
    t.boolean  "accepts_cash",                               default: true,  null: false
    t.boolean  "accepts_checks",                             default: true,  null: false
    t.boolean  "accepts_credit_cards_offline",               default: false, null: false
    t.boolean  "accepts_online_payments",                    default: false, null: false
    t.boolean  "accepts_money_orders",                       default: false, null: false
    t.string   "url",                            limit: 511,                 null: false
    t.integer  "applicant_id"
  end

  add_index "property_managers", ["applicant_id"], name: "index_property_managers_on_applicant_id", using: :btree
  add_index "property_managers", ["name"], name: "index_property_managers_on_name", unique: true, using: :btree

  create_table "property_photos", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "rental_offering_id"
    t.string   "photo_thumb_url"
    t.string   "photo_full_url"
  end

  add_index "property_photos", ["rental_offering_id"], name: "index_property_photos_on_rental_offering_id", using: :btree

  create_table "providers", force: true do |t|
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "applicant_id"
    t.string   "email"
    t.string   "name"
    t.boolean  "connected",    default: true
  end

  add_index "providers", ["applicant_id"], name: "index_providers_on_applicant_id", using: :btree

  create_table "rental_complexes", force: true do |t|
    t.integer  "property_manager_id",                        null: false
    t.float    "latitude",                                   null: false
    t.float    "longitude",                                  null: false
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",                            limit: 511
    t.string   "full_address",                   limit: 511, null: false
    t.string   "customer_contact_email_address"
    t.integer  "customer_contact_phone_number",  limit: 8
    t.text     "salesy_description"
    t.string   "street_name",                                null: false
    t.string   "cross_street_name",                          null: false
    t.string   "walk_time"
    t.text     "nearby_places"
  end

  add_index "rental_complexes", ["latitude", "longitude"], name: "index_rental_complexes_on_latitude_and_longitude", using: :btree
  add_index "rental_complexes", ["property_manager_id"], name: "index_rental_complexes_on_property_manager_id", using: :btree

  create_table "rental_offerings", force: true do |t|
    t.integer  "rental_complex_id",                                  null: false
    t.date     "earliest_available_on"
    t.integer  "bedroom_count",                                      null: false
    t.integer  "full_bathroom_count",                                null: false
    t.integer  "half_bathroom_count",                default: 0,     null: false
    t.text     "salesy_description"
    t.string   "rental_offering_type"
    t.string   "headline"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "url",                    limit: 511
    t.integer  "monthly_rent_floor",                                 null: false
    t.integer  "monthly_rent_ceiling",                               null: false
    t.integer  "square_footage_floor"
    t.integer  "square_footage_ceiling"
    t.string   "origin_listing_id"
    t.integer  "amenities",                          default: 0,     null: false
    t.text     "scrape_amenities"
    t.boolean  "sold_out",                           default: false
    t.integer  "applies_count",                      default: 0
  end

  add_index "rental_offerings", ["rental_complex_id", "origin_listing_id"], name: "index_offerings_on_complex_id_and_origin_listing_id", unique: true, using: :btree

  create_table "roommate_groups", force: true do |t|
    t.string   "name"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roommate_groups", ["applicant_id"], name: "index_roommate_groups_on_applicant_id", using: :btree

  create_table "starred_properties", force: true do |t|
    t.integer  "applicant_id"
    t.integer  "rental_offering_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "starred_properties", ["applicant_id"], name: "index_starred_properties_on_applicant_id", using: :btree
  add_index "starred_properties", ["rental_offering_id"], name: "index_starred_properties_on_rental_offering_id", using: :btree

  create_table "transactions", force: true do |t|
    t.string   "transaction_id"
    t.string   "status"
    t.decimal  "amount"
    t.integer  "applicant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "card_type"
    t.string   "cardholder_name"
    t.string   "purchased_type"
  end

  add_index "transactions", ["applicant_id"], name: "index_transactions_on_applicant_id", using: :btree

end
