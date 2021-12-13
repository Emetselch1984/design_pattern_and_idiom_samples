class Config
  attr_accessor :config

  def initialize
    @defauluts = {
        :@config => "hello"
    }
    reset!
  end
  def reset!
    @defauluts.each do |key,value|
      instance_variable_set(key,value)
    end
  end
end
module Foo
  def set_config
    @config = Config.new
    extend ClassMethods
    include InstanceMethods
  end
end

module ClassMethods
  def config
    @config
  end
end
module InstanceMethods
  def config
    self.class.config
  end
end

class Customer
  extend Foo
  set_config
end

class Foo
  def self.hello
    puts "hello"
  end
  def hello
    self.class.hello
  end
end
