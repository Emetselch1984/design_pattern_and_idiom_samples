# Singletonは、Mix-inしたクラスのinstanceは同一のインスタンスを返すようになる
require 'singleton'

# シングルトン
class SingletonObject
  # instanceメソッドが定義され、newメソッドがprivateに設定される
  include Singleton
  attr_accessor :counter

  def initialize
    @counter = 0
  end
end

obj1 = SingletonObject.instance
obj1.counter += 1
puts obj1.counter

obj2 = SingletonObject.instance
obj2.counter += 1
puts obj2.counter
