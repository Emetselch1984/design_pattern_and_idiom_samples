def hello(name)
  puts "#{__FILE__}"
  puts "#{$0}"
  puts "Hello, #{name}!"
end
# requireされた時に実行される
hello("Alice")

if __FILE__ == $0
  hello("Alice")
end