# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   email: 'minimum@gmail.com',
   password: 'minimum',
)

Category.create!(name: "インナー")
Category.create!(name: "アウター")
Category.create!(name: "ボトムス")

Brand.create!(name: "JieDa")
Brand.create!(name: "Allege")
Brand.create!(name: "COMME des GARCONS")
Brand.create!(name: " YOHJIYAMAMOTO")
Brand.create!(name: " ISSEY MIYAKE")

Color.create!(name: "赤系", color_code: "#ff7f50")
Color.create!(name: "青系", color_code: "#4682b4")
Color.create!(name: "黄系", color_code: "#ffd700")
Color.create!(name: "ベージュ系", color_code: "#d2b48c")
Color.create!(name: "白", color_code: "#f8f8ff")
Color.create!(name: "黒", color_code: "#ffffff")

User.create!(
    email: 'minimum@gmail.com',
    password: 'minimum',
    nickname: 'テストユーザー',
    last_name: '名字',
    first_name: '名前',
    last_name_kana: 'ミョウジ',
    first_name_kana: 'ナマエ',
    postal_code: '0000000',
    address: '東京都0-0-0',
    phone_number: '12345678909'
)