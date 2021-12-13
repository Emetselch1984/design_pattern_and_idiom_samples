def authentication_response(options = {})
  yield(options[:user], options[:failure]) if block_given?

  options[:return_value]
end

def foo
  yield(1,2)
end

# fooに「2引数手続き、その働きは引数を配列に括ってpで印字する」というものを渡して実行させる
foo {|a,b|
  p [a, b]
}  # => [1, 2] (要するに p [1, 2] を実行した)