users = nil
def send_direct_mail(user)
  puts "hello#{user}"
end

# usersはnilが渡される場合もあるので分岐する
if users
  users.each{|user| send_direct_mail(user) }
end
# => nil
Array(users).each{|user| send_direct_mail(user)}
# => []
