# レポートの出力を抽象化したクラス(抽象戦略)
class Formatter
  def output_report(title, text)
    raise 'Called abstract method !!'
  end
end

# HTML形式に整形して出力(具体戦略)
class HTMLFormatter < Formatter
  def output_report(report)
    puts ""
    report.text.each { |line| puts "
                                   #{line}

                                   " }
    puts '
         '
  end
end

# PlaneText形式(*****で囲う)に整形して出力(具体戦略)
class PlaneTextFormatter < Formatter
  def output_report(report)
    puts "***** #{report.title} *****"
    report.text.each { |line| puts(line) }
  end
end
# レポートを表す(コンテキスト)
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'report title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end


report = Report.new(HTMLFormatter.new)
report.output_report


class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'report title'
    @text = %w(text1 text2 text3)
    @formatter = formatter
  end

  def output_report
    self.formatter.call(self)
  end
end

HTML_FORMATTER = ->(context) do
  puts ""
  context.text.each { |line| puts "
                                  #{line}

                                  " }
  puts ''
end

PLANE_TEXT_FORMATTER = ->(context) do
  puts "***** #{context.title} *****"
  context.text.each { |line| puts(line) }
end

report = Report.new(&HTML_FORMATTER)
report.output_report

