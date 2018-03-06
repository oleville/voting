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

ActiveRecord::Schema.define(version: 20180306065100) do

  create_table "ballots", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "election_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["election_id"], name: "index_ballots_on_election_id"
    t.index ["user_id"], name: "index_ballots_on_user_id"
  end

  create_table "candidates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.bigint "election_id"
    t.bigint "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "violations"
    t.string "profile_url"
    t.index ["election_id"], name: "index_candidates_on_election_id"
    t.index ["position_id"], name: "index_candidates_on_position_id"
  end

  create_table "elections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_rank_choice"
    t.boolean "validated"
    t.boolean "results_public"
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "memberships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_memberships_on_group_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "positions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "description"
    t.bigint "election_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["election_id"], name: "index_positions_on_election_id"
    t.index ["group_id"], name: "index_positions_on_group_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.string "email"
    t.string "auth_token", limit: 2048
    t.datetime "auth_token_expiration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.boolean "admin"
  end

  create_table "votes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "rank"
    t.bigint "candidate_id"
    t.bigint "user_id"
    t.bigint "ballot_id"
    t.bigint "position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ballot_id"], name: "index_votes_on_ballot_id"
    t.index ["candidate_id"], name: "index_votes_on_candidate_id"
    t.index ["position_id"], name: "index_votes_on_position_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

  add_foreign_key "ballots", "elections"
  add_foreign_key "ballots", "users"
  add_foreign_key "candidates", "elections"
  add_foreign_key "candidates", "positions"
  add_foreign_key "memberships", "groups"
  add_foreign_key "memberships", "users"
  add_foreign_key "positions", "elections"
  add_foreign_key "positions", "groups"
  add_foreign_key "votes", "ballots"
  add_foreign_key "votes", "candidates"
  add_foreign_key "votes", "positions"
  add_foreign_key "votes", "users"
end
