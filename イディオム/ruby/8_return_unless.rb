# unless　以下がfalseなら処理を止める
# trueなら処理を続ける。

def hello(option)
  return unless 1 == option
  puts "hello world"
end

module Foo
  def hello
    puts "hello world"
  end
end

class User
  include Foo
  def check_hello
    return unless respond_to?(:hello)
    send(:hello)
  end
end