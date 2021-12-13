module Foo
  def hello
    puts "hello_foo"
  end
  module Bar
    module Baz
      p Module.nesting   # => [Foo::Bar::Baz, Foo::Bar, Foo]
      def hello
        puts "hello"
      end
    end
  end
end
