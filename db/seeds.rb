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

Brand.create!(name: "A.P.C.")
Brand.create!(name: "Allege")
Brand.create!(name: "BALENCIAGA")
Brand.create!(name: "BEAMS")
Brand.create!(name: "COMME des GARCONS")
Brand.create!(name: "DIOR")
Brand.create!(name: "DIESEL")
Brand.create!(name: "FENDI")
Brand.create!(name: "GUCCI")
Brand.create!(name: "GU")
Brand.create!(name: "H&M")
Brand.create!(name: "ISSEY MIYAKE")
Brand.create!(name: "JIL SANDER")
Brand.create!(name: "JieDa")
Brand.create!(name: "JOHN LAWRENCE SULLIVAN")
Brand.create!(name: "kolor")
Brand.create!(name: "LOEWE")
Brand.create!(name: "MARNI")
Brand.create!(name: "NEEDLES")
Brand.create!(name: "NEON SIGN")
Brand.create!(name: "PRADA")
Brand.create!(name: "Paul Smith")
Brand.create!(name: "RAF SIMONS")
Brand.create!(name: "SOSHIOTSUKI")
Brand.create!(name: "sacai")
Brand.create!(name: "STÜSSY")
Brand.create!(name: "URU")
Brand.create!(name: "UNIQLO")
Brand.create!(name: "Yohji Yamamoto")


Color.create!(name: "ホワイト系", color_code: "#f8f8ff")
Color.create!(name: "ブラック系", color_code: "#333")
Color.create!(name: "グレイ系", color_code: "#d3d3d3")
Color.create!(name: "ブラウン系", color_code: "#8b451")
Color.create!(name: "ベージュ系", color_code: "#f5deb3")
Color.create!(name: "グリーン系", color_code: "#3cb371")
Color.create!(name: "ブルー系", color_code: "#1e90ff")
Color.create!(name: "パープル系", color_code: "#9370db")
Color.create!(name: "イエロー系", color_code: "#fff462")
Color.create!(name: "ピンク系", color_code: "#ffc0cb")
Color.create!(name: "レッド系", color_code: "#ff6347")
Color.create!(name: "オレンジ系", color_code: "#ffa500")

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