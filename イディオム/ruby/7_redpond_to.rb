class F
  def hello
    "Bonjour"
  end
end

class D
  private
  def hello
    "Guten Tag"
  end
end

list = [F.new,D.new]
list.each{|it| puts it.hello if it.respond_to?(:hello)}
#=> Bonjour
list.each{|it| it.instance_eval("puts hello if it.respond_to?(:hello, true)")}
#=> Bonjour
#   Guten Tag

module Template
  def main
    start
    template_method
    finish
  end

  def start
    puts "start"
  end

  def template_method
    raise NotImplementedError.new
  end

  def finish
    puts "finish"
  end
end

class User
  extend Template
end

class ImplTemplateMethod
  include Template
  def template_method
    "implement template_method"
  end
end

class NotImplTemplateMethod
  include Template

  # not implement template_method
end
puts ImplTemplateMethod.new.respond_to?(:template_method) # => true
# NotImplementedError が発生しているが、Rubyによる実装部のため true を返す
puts NotImplTemplateMethod.new.respond_to?(:template_method) # => true
# GNU/Linux で実行。C言語による実装部のため false を返す
puts File.respond_to?(:lchmod)         # => false