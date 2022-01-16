require 'singleton'

class SingletonObject
  include Singleton
  attr_accessor :counter
  
  def initialize
    @counter = 0
  end

end

obj1 = SingletonObject.instance
obj1_counter = obj1.counter += 1
puts obj1_counter

obj2 = SingletonObject.instance
obj2_counter = obj2.counter += 1
puts obj2_counter

