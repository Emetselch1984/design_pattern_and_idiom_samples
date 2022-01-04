File.basename("ruby/ruby.c")
File.basename("ruby/ruby.c",".c")
File.basename("ruby/ruby.c",".*")

array = %w(foo foobar bar)
array.each do |element|
  p File.fnmatch("foo*",element)
end

results = []
