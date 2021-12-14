# ファイルへの単純な出力を行う (ConcreteComponent)
class SimpleWriter
  def initialize(path)
    @file = File.open(path, "w")
  end

  # データを出力する
  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  # ファイル出力位置
  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  # ファイル出力を閉じる
  def close
    @file.close
  end
end



複数のデコレータの共通部分(Decorator)
class WriterDecorator
  def initialize(real_writer)
    @real_writer = real_writer
  end

  def write_line(line)
    @real_writer.write_line(line)
  end

  def pos
    @real_writer.pos
  end

  def rewind
    @real_writer.rewind
  end

  def close
    @real_writer.close
  end
end



require "forwardable"

class WriterDecorator
  extend Forwardable

  # forwardableで以下のメソッドの処理を委譲している
  def_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

# 行番号出力機能を装飾する(Decorator)
class NumberingWriter < WriterDecorator
  attr_reader :line_number,:real_writer
  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write_line(line)
    real_writer.write_line("#{line_number} : #{line}")
  end
end

# タイムスタンプ出力機能を装飾する(Decorator)
class TimestampingWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line("#{Time.new} : #{line}")
  end
end

f = TimestampingWriter.new(SimpleWriter.new("sample.txt"))
f.write_line("foo")
