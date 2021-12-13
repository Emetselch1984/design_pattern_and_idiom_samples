class C
end
a = 1
C.class_eval %Q{
  def m                   # メソッドを動的に定義できる。
    return :m, #{a}
  end
}

p C.new.m        #=> [:m, 1]

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
