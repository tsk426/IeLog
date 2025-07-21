# db/seeds.rb
tags = [
  { name: "吹き抜け", category: "間取り・空間", price: 200 },
  { name: "和室", category: "間取り・空間", price: 0 },
  { name: "天井高", category: "間取り・空間", price: 200 },
  { name: "大空間リビング", category: "間取り・空間", price: 200 },
  { name: "リビング収納", category: "間取り・空間", price: 0 },
  { name: "ウォークインクローゼット", category: "間取り・空間", price: 0 },
  { name: "シューズクローク", category: "間取り・空間", price: 0 },
  { name: "ウッドデッキ", category: "間取り・空間", price: 0 },
  { name: "庭", category: "間取り・空間", price: 0 },
  { name: "スキップフロア", category: "間取り・空間", price: 50 },
  { name: "階段下収納", category: "間取り・空間", price: 0 },
  { name: "土間収納", category: "間取り・空間", price: 0 },

  { name: "生活導線", category: "家事・生活", price: 0 },
  { name: "修繕費用", category: "家事・生活", price: 0 },
  { name: "バリアフリー", category: "家事・生活", price: 0 },
  { name: "多世帯住宅", category: "家事・生活", price: 0 },
  { name: "長期優良住宅", category: "家事・生活", price: 0 },
  { name: "書斎", category: "家事・生活", price: 0 },
  { name: "子供部屋", category: "家事・生活", price: 0 },
  { name: "趣味部屋", category: "家事・生活", price: 0 },
  { name: "ガレージ", category: "家事・生活", price: 200 },
  { name: "カーポート", category: "家事・生活", price: 100 },

  { name: "対面式キッチン", category: "キッチン・水回り", price: 0 },
  { name: "独立式キッチン", category: "キッチン・水回り", price: 0 },
  { name: "アイランドキッチン", category: "キッチン・水回り", price: 0 },
  { name: "2F浴室", category: "キッチン・水回り", price: 50 },
  { name: "2Fトイレ", category: "キッチン・水回り", price: 50 },

  { name: "無垢材", category: "内装・素材", price: 200 },
  { name: "間接照明", category: "内装・素材", price: 0 },
  { name: "ファミリークローゼット", category: "内装・素材", price: 0 },
  { name: "パントリー", category: "内装・素材", price: 0 },
  { name: "ロフト", category: "内装・素材", price: 0 },

  { name: "ガルバリウム", category: "外装・屋根", price: 0 },
  { name: "タイル", category: "外装・屋根", price: 50 },
  { name: "塗り壁", category: "外装・屋根", price: 0 },
  { name: "サイディング", category: "外装・屋根", price: 0 },
  { name: "切妻屋根", category: "外装・屋根", price: 100 },
  { name: "寄棟屋根", category: "外装・屋根", price: 100 },
  { name: "片流れ屋根", category: "外装・屋根", price: 100 },
  { name: "陸屋根", category: "外装・屋根", price: 100 },
  { name: "方形屋根", category: "外装・屋根", price: 100 },
  { name: "差しかけ屋根", category: "外装・屋根", price: 100 },
  { name: "入母屋屋根", category: "外装・屋根", price: 100 },
  { name: "招き屋根", category: "外装・屋根", price: 100 },

  { name: "内断熱", category: "構造・性能", price: 0 },
  { name: "外断熱", category: "構造・性能", price: 0 },
  { name: "ソーラーパネル", category: "構造・性能", price: 200 },
  { name: "ZEH", category: "構造・性能", price: 0 },
  { name: "耐震", category: "構造・性能", price: 0 },
  { name: "制振", category: "構造・性能", price: 0 },
  { name: "免振", category: "構造・性能", price: 0 },
  { name: "光熱費削減", category: "構造・性能", price: 200 },
  { name: "修繕費用削減", category: "構造・性能", price: 0 }
]
tags.each do |tag_attrs|
  tag = Tag.find_or_initialize_by(name: tag_attrs[:name])
  tag.category = tag_attrs[:category]
  tag.price = tag_attrs[:price]
  tag.save!
end

# ユーザーの作成・更新
user = User.find_or_create_by!(email: "taro@example.com") do |u|
  u.name = "山田太郎"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.phone_number = "09012345678"
  u.is_public = true
end

# 管理者の作成・更新
admin = Admin.find_or_create_by!(email: "admin@example.com") do |a|
  a.password = "adminpassword"
  a.password_confirmation = "adminpassword"
end

# レビューの作成・更新
review1 = Review.find_or_create_by!(title: "素晴らしい家", user: user) do |r|
  r.body = "この家はとても素晴らしいです！"
  r.house_budget = 40000000
  r.land_budget = 20000000
  r.prefecture_code = "2"
  r.floor_plan = "3LDK"
  r.tags = ["ロフト"]
end

review2 = Review.find_or_create_by!(title: "使い勝手の良い家", user: user) do |r|
  r.body = "広さも十分で便利な場所にあります。"
  r.house_budget = 30000000
  r.land_budget = 15000000
  r.prefecture_code = "1"
  r.floor_plan = "2LDK"
  r.tags = ["2Fトイレ", "無垢材"]
end

# いいねの作成・更新
Like.find_or_create_by!(user: user, review: review1)

# 見積もりの作成・更新
Estimate.find_or_create_by!(user: user) do |e|
  e.land_price = 2000000
  e.building_price = 5000000
  e.floor_count = 2
  e.area_size = 30
  e.condition_tags = ["吹き抜け", "ガレージ"]
  e.total_cost = 2000000 + 5000000 + 300000
end

puts "Seed data has been created or updated!"
