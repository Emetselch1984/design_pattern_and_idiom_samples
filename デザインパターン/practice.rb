require "find"

class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end

class FileName < Expression

  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      name = File.basename(p)
      results << p if File.fnmatch(@pattern,name)
    end
    results
  end
end
# 終端以外の表現(構造木の節) NonterminalExpression
class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

# 終端以外の表現(構造木の節) NonterminalExpression
# Or: 2ファイル検索式をORで結合する
class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 + result2).sort.uniq
  end
end

# 終端以外の表現(構造木の節) NonterminalExpression
# And: 2ファイル検索式をANDで結合する
class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    (result1 & result2)
  end
end

expression1 = FileName.new('*.mp3')
expression2 = FileName.new('big*')
And.new(expression1,expression2)