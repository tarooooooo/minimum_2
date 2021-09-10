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

Color.create!(name: "黒")
Color.create!(name: "白")
Color.create!(name: "緑")
Color.create!(name: "青")
Color.create!(name: "赤")

Brand.create!(name: "BEAMS")
Brand.create!(name: "UNITED ARROWS")
Brand.create!(name: "SHIPS")
Brand.create!(name: "UNIQLO")
Brand.create!(name: "GU")

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(1).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(2).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(3).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(4).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(5).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(6).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )

Item.create!(user_id: 1,
             color_id: 2,
             brand_id: 1,
             category_id: 1,
             price: "1000",
             purchase_date: Date.today - rand(7).months,
             size: 1,
             name: "テスト",
             item_image_id: "a"
             )