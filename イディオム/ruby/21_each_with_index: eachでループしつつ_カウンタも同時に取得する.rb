users = ["alice","bob","carol","charlie"]

counter = 0
users.each do |user|
  puts ", " if counter > 0
  puts user
  counter += 1
end
users.each do |user|
  puts ", "
  puts user
end

users.each_with_index do |user,counter|
  puts "," if counter > 0
  puts user
end

# ループ処理系のメソッド + with_index: カウンタ付きで元のループ処理を実行する
counter = 3
users_with_index = users.map do |user|
  [counter, user]
  counter += 1
end

users_with_index = users.map.with_index(3) do |user,counter|
  [counter + 1 ,user]
end

