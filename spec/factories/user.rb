FactoryBot.define do
  factory :user do
    nickname{"name"}
    email { Faker::Internet.email }
    phone_number { "12345678909" }
    last_name{"名字"}
    first_name{"名前"}
    last_name_kana{"ミョウジ"}
    first_name_kana{"ナマエ"}
    postal_code {"0000000"}
    address{"address"}
    icon_image_id{"image_id"}
    is_deleted { "consent" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end