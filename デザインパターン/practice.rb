class Report
  attr_reader :title,:text,:formatter
  TEXT = %w(text1 text2 text3).freeze

  def initialize(formatter)
    @title = default_title
    @text = TEXT
    @formatter = formatter
  end

  def default_title
    "report title"
  end

  def output_report
    formatter.output_report(self)
  end


end

class Formatter
  def output_report(args)
    raise "Called method!"
  end
end

report = Report.new(Formatter.new)
report.title
report.text
report.output_report

class HTMLFormatter < Formatter
  def output_report(report)

  end
end