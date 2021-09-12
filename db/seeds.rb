# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: "Tシャツ（半袖）")
Category.create!(name: "Tシャツ（長袖）")
Category.create!(name: "アウター（春秋用）")
Category.create!(name: "アウター（冬用）")
Category.create!(name: "ボトムス（夏）")
Category.create!(name: "ボトムス（冬）")

Color.create!(name: "黒",color_code: "#000000")
Color.create!(name: "白",color_code: "#f5f5f5")
Color.create!(name: "緑",color_code: "#3cd371")
Color.create!(name: "青",color_code: "#6295ed")
Color.create!(name: "赤",color_code: "#ff6347")

Brand.create!(name: "BEAMS")
Brand.create!(name: "UNITED ARROWS")
Brand.create!(name: "SHIPS")
Brand.create!(name: "UNIQLO")
Brand.create!(name: "GU")

Item.create!(user_id: 1,
             color_id: 4,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - 3.months,
             size: 1,
             name: "テスト",
             item_image_id: "a",
             item__status: "discarded"
             )

Item.create!(user_id: 1,
             color_id: 1,
             brand_id: 1,
             category_id: 2,
             price: "1000",
             purchase_date: Date.today - 2.months,
             size: 1,
             name: "テスト",
             item_image_id: "a",
             item_status: "discarde"
             )

