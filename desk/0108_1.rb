require 'find'

class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end


class All < Expression

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p
    end
    results
  end

end

class FileName < Expression
  attr_reader :pattern

  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(pattern,name)
    end
    results
  end

end

filename = FileName.new("*.mp3")
filename.evaluate('test')

class Bigger < Expression

  attr_reader :size

  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if(File.size(p) > size)
    end
    results
  end

end

bigger = Bigger.new(100)
bigger.evaluate('test')

class Writable < Expression

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if(File.writable?(p))
    end
    results
  end

end

writable = Writable.new
writable.evaluate('test')

class Not < Expression
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - expression.evaluate(dir)
  end

end

filename = FileName.new("*.mp3")
tmp = Not.new(filename)
tmp.evaluate('test')

class Or < Expression
  attr_reader :expression1,:expression2

  def initialize(expression1,expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = expression1.evaluate(dir)
    result2 = expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end

end

ary1 = %w(1 45 8).to_a
ary2 = %w(1 88 8).to_a
result = ary1 + ary2
result.sort
result.sort.uniq

class And < Expression
  attr_reader :expression1,:expression2

  def initialize(expression1,expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = expression1.evaluate(dir)
    result2 = expression2.evaluate(dir)
    (result1 & result2)
  end
end

filename1 = FileName.new("*.mp3")
filename2 = FileName.new("*.jpg")

tmp = And.new(filename1,filename2)
tmp.evaluate('test')
tmp = Or.new(filename1,filename2)
tmp.evaluate('test')

filename1 = FileName.new("*.mp3")
filename2 = FileName.new("a.*")

tmp = And.new(filename1,filename2)
tmp.evaluate('test')
