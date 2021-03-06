## file.basename
# filename の一番後ろのスラッシュに続く要素を返します。もし、引数 suffix が与えられて、かつそれが filename の末尾に一致するなら、それを取り除いたものを返します。

p File.basename("ruby/ruby.c")          #=> "ruby.c"
p File.basename("ruby/ruby.c", ".c")    #=> "ruby"
p File.basename("ruby/ruby.c", ".*")    #=> "ruby"
p File.basename("ruby/ruby.exe", ".*")  #=> "ruby"
p File.basename("ruby/y.tab.c", ".*")   #=> "y.tab"

#fnmatch

%w(foo foobar bar).each {|f|
  p File.fnmatch("foo*", f)
}
# => true
#    true
#    false

# find(*dirs, ignore_error: true) {|file| ... } -> nil
# dir以下の全てのディレクトリやファイルを一つずつfind引数に渡して、
# ブロックを実行する。
require 'find'
results = []
Find.find('/tmp') {|f|
  # /tmp/bar/以下の検索を省略
  Find.prune if f == "/tmp/bar"
  next unless File.file?(f)
  results << f
}

# 命令・抽象的な表現(AbstractExpression)
# Expression: 共通するコードを持つ
class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end
end
require "find"
# 終端となる表現(構造木の葉) (TerminalExpression)
# All: すべてのファイルを返す
class All < Expression
  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p
    end
    results
  end
end
# 終端となる表現(構造木の葉) (TerminalExpression)
# FileName: 与えられたパターンとマッチするすべてのファイル名を返す
class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results= []
    Find.find(dir) do |p|
      next unless File.file?(p)
      # File.basename => ファイルパスからファイル名だけを抽出
      name = File.basename(p)
      # File.fnmatch => ファイル名がパターンにマッチした場合のみtrueを返す
      results << p if File.fnmatch(@pattern, name)
    end
    results
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
# Bigger: 指定したファイルサイズより大きいファイルを返す
class Bigger < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if( File.size(p) > @size)
    end
    results
  end
end

# 終端となる表現(構造木の葉) (TerminalExpression)
# Writable: 書込可能なファイルを返す
class Writable < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if( File.writable?(p) )
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

# ===========================================
complex_expression1 = And.new(FileName.new('*.mp3'), FileName.new('big*'))
puts complex_expression1.evaluate('13_test_data')
#=> 13_test_data/big.mp3
#=> 13_test_data/big2.mp3

complex_expression2 = Bigger.new(1024)
puts complex_expression2.evaluate('13_test_data')
#=> 13_test_data/big.mp3
#=> 13_test_data/big2.mp3
#=> 13_test_data/subdir/other.mp3

complex_expression3 = FileName.new('*.mp3') & FileName.new('big*')
puts complex_expression3.evaluate('13_test_data')
#=> 13_test_data/big.mp3
#=> 13_test_data/big2.mp3

complex_expression4 = All.new
puts complex_expression4.evaluate('13_test_data')
#=> 13_test_data/big.mp3
#=> 13_test_data/big2.mp3
#=> 13_test_data/small.mp3
#=> 13_test_data/small1.txt
#=> 13_test_data/small2.txt
#=> 13_test_data/subdir/other.mp3
#=> 13_test_data/subdir/small.jpg

result1 = ["13_test_data/big.mp3","13_test_data/big5.mp3","bar"]
result2 = ["13_test_data/big.mp3","13_test_data/big5.mp3","noo"]
puts (result1 & result2)
