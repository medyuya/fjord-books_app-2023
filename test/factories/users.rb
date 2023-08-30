FactoryBot.define do
  factory :user do
    email { 'ken@example.com' }
    password { 'password' }
  end
end


# t.string "email", default: "", null: false
# t.string "encrypted_password", default: "", null: false
# t.string "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "name"
# t.string "postal_code"
# t.string "address"
# t.text "self_introduction"
