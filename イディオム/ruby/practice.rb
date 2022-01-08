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
some.instance_eval {p @key}
some.instance_eval {do_fuga}