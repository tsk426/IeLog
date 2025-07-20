# db/seeds.rb

tags = [
  { name: "吹き抜け", category: "間取り・空間" },
  { name: "和室", category: "間取り・空間" },
  { name: "天井高", category: "間取り・空間" },
  { name: "大空間リビング", category: "間取り・空間" },
  { name: "リビング収納", category: "間取り・空間" },
  { name: "ウォークインクローゼット", category: "間取り・空間" },
  { name: "シューズクローク", category: "間取り・空間" },
  { name: "ウッドデッキ", category: "間取り・空間" },
  { name: "庭", category: "間取り・空間" },
  { name: "スキップフロア", category: "間取り・空間" },
  { name: "階段下収納", category: "間取り・空間" },
  { name: "土間収納", category: "間取り・空間" },

  { name: "生活導線", category: "家事・生活" },
  { name: "修繕費用", category: "家事・生活" },
  { name: "バリアフリー", category: "家事・生活" },
  { name: "多世帯住宅", category: "家事・生活" },
  { name: "長期優良住宅", category: "家事・生活" },
  { name: "書斎", category: "家事・生活" },
  { name: "子供部屋", category: "家事・生活" },
  { name: "趣味部屋", category: "家事・生活" },
  { name: "ガレージ", category: "家事・生活" },
  { name: "カーポート", category: "家事・生活" },

  { name: "対面式キッチン", category: "キッチン・水回り" },
  { name: "独立式キッチン", category: "キッチン・水回り" },
  { name: "アイランドキッチン", category: "キッチン・水回り" },
  { name: "2F浴室", category: "キッチン・水回り" },
  { name: "2Fトイレ", category: "キッチン・水回り" },

  { name: "無垢材", category: "内装・素材" },
  { name: "間接照明", category: "内装・素材" },
  { name: "ファミリークローゼット", category: "内装・素材" },
  { name: "パントリー", category: "内装・素材" },
  { name: "ロフト", category: "内装・素材" },

  { name: "ガルバリウム", category: "外装・屋根" },
  { name: "タイル", category: "外装・屋根" },
  { name: "塗り壁", category: "外装・屋根" },
  { name: "サイディング", category: "外装・屋根" },
  { name: "切妻屋根", category: "外装・屋根" },
  { name: "寄棟屋根", category: "外装・屋根" },
  { name: "片流れ屋根", category: "外装・屋根" },
  { name: "陸屋根", category: "外装・屋根" },
  { name: "方形屋根", category: "外装・屋根" },
  { name: "差しかけ屋根", category: "外装・屋根" },
  { name: "入母屋屋根", category: "外装・屋根" },
  { name: "招き屋根", category: "外装・屋根" },

  { name: "内断熱", category: "構造・性能" },
  { name: "外断熱", category: "構造・性能" },
  { name: "ソーラーパネル", category: "構造・性能" },
  { name: "ZEH", category: "構造・性能" },
  { name: "耐震", category: "構造・性能" },
  { name: "制振", category: "構造・性能" },
  { name: "免振", category: "構造・性能" },
  { name: "光熱費削減", category: "構造・性能" },
  { name: "修繕費用削減", category: "構造・性能" }
]
tags.each do |tag|
  Tag.find_or_create_by!(name: tag[:name], category: tag[:category])
end


# ユーザーの作成・更新
user = User.find_or_create_by!(email: "taro@example.com") do |u|
  u.name = "山田太郎"
  u.password = "password123"
  u.password_confirmation = "password123"
  u.nickname = "タロー"
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
  r.content = "この家はとても素晴らしいです！"
  r.price = 5000000
  r.area = "東京都"
  r.floor_plan = "3LDK"
  r.tags = ["新築", "広い", "駅近"]
end

review2 = Review.find_or_create_by!(title: "使い勝手の良い家", user: user) do |r|
  r.content = "広さも十分で便利な場所にあります。"
  r.price = 4000000
  r.area = "神奈川県"
  r.floor_plan = "2LDK"
  r.tags = ["リフォーム済み", "駅近"]
end

# いいねの作成・更新
Like.find_or_create_by!(user: user, review: review1)

# 見積もりの作成・更新
Estimate.find_or_create_by!(user: user) do |e|
  e.land_price = 2000000
  e.building_price = 5000000
  e.floor_count = 2
  e.area_size = 30
  e.condition_tags = ["駅近", "ペット可"]
  e.total_cost = 2000000 + 5000000 + 300000
end

puts "Seed data has been created or updated!"
