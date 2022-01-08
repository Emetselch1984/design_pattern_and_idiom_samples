class Foo
  def initialize data
    @key = data
  end
  private
  def do_fuga
    p 'secret'
  end
end

some = Foo.new 'XXX'
some.instance_eval{p @key} #=> "XXX"
some.instance_eval{do_fuga } #=> "secret" # private メソッドも呼び出せる

some.instance_eval 'raise' # ..:10: (eval):1:  (RuntimeError)
messg = 'unknown'
some.instance_eval 'raise messg','file.rb',999 # file.rb:999: unknown (RuntimeError)

class Bar < BasicObject
  def call1
    instance_eval("::ENV.class")
  end
  def call2
    instance_eval("ENV.class")
  end
end

bar = Bar.new
bar.call1 # => Object
bar.call2 # raise NameError