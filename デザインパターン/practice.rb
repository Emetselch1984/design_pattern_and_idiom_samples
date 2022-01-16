class Report
  attr_reader :text,:title
  TITLE = "html report title".freeze
  TEXT = ["report line 1", "report line 2", "report line 3"].freeze

  def initialize
    @title = TITLE
    @text = TEXT
  end

  def output_report
    output_start
    output_body
    output_end
  end

  def output_start ;end
  def output_body
    text.each do |line|
      output_line(line)
    end
  end

  def output_line(line)
    raise "Called abstract method !!"
  end

  def output_end ;end

end

class HTMLReport < Report
  def output_start
    puts ""
  end

  def output_line(line)
    format = <<TEXT
    #{line}
TEXT
    puts format
  end

  def output_end
    puts ""
  end
end
report = HTMLReport.new
report.output_report

class PlaneTextReport < Report
  def output_start
    puts "**** #{self.text} ****"
  end

  def output_line(line)
    puts line
  end

end
report = PlaneTextReport.new
report.output_report
