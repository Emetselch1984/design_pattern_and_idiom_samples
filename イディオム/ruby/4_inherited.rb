class Foo
  def Foo.inherited(subclass)
    puts "class \"#{self}\" was inherited by \"#{subclass}\""
  end
end
class Noo
  puts "Noo"
end
class Bar < Foo
  puts "executing class body"
end
class Foo
  def Foo.inherited(subclass)
    subclass.class_eval do
      class << self
        attr_accessor :sorcery_config
      end
    end
  end
end
class Bar < Foo
  puts "executing class body"
end
Bar.sorcery_config = "result"

def add_config_inheritance
  class_eval do
    def self.inherited(subclass)
      subclass.class_eval do
        class << self
          attr_accessor :sorcery_config
        end
      end
      subclass.sorcery_config = sorcery_config
      super
    end
  end
end
