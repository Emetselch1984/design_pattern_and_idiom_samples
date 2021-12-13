ans_array = 14.divmod(3)
puts "商は#{ans_array[0]}"     # => 商は4
puts "あまりは#{ans_array[1]}" # => あまりは2

quotient,remainder= 14.divmod(3)
puts "商は#{quotient}"
puts "あまりは#{remainder}"

# keyとvalueを配列として受け取る
{name: 'Tom', email: 'hoge@hoge.com'}.each do |key_and_value|
  puts "key: #{key_and_value[0]}"
  puts "value: #{key_and_value[1]}"
end

# keyとvalueを配列として受け取る
{name: 'Tom', email: 'hoge@hoge.com'}.each do |key,value|
  puts "key: #{key}"
  puts "value: #{value}"
end