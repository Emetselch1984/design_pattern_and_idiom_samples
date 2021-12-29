require 'forwardable'

class SimpleWriter
  attr_reader :file
  def initialize(path)
    @file = File.open(path,"w")
  end

  def write_line(line)
    file.print(line)
    file.print("\n")
  end

  def pos
    file.pos
  end

  def rewind
    file.rewind
  end

  def close
    file.close
  end
end

class WriterDecorator
  attr_reader :real_writer
  extend Forwardable

  def_delegators :@real_writer,:write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end

end
class NumberingWriter < WriterDecorator
  attr_reader :line_number
  def initialize(real_writer)
    super(real_writer)
    @line_number = default_number
  end

  def default_number
    1
  end

  def write_line(line)
    real_writer.write_line("#{line_number} : #{line}")
  end

end

class TimestampingWriter < WriterDecorator
  attr_reader :real_writer

  def write_line(line)
    real_writer.write_line("#{Time.now} : #{line}")
  end
end
writer = SimpleWriter.new("test1226.txt")
numbering_writer = NumberingWriter.new(writer)
numbering_writer.write_line("foo")
numbering_writer.close

