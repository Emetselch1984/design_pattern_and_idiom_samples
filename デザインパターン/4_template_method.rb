class Report
  attr_reader :text,:title
  def initialize
    @title = "html report title"
    @text = ["report line 1", "report line 2", "report line 3"]
  end

  # レポートの出力手順を規定
  def output_report
    output_start
    output_body
    output_end
  end

  # レポートの先頭に出力
  def output_start
  end

  # レポートの本文の管理
  def output_body
    text.each do |line|
      output_line(line)
    end
  end

  # 本文内のLINE出力部分
  # 今回は個別クラスに規定するメソッドとする。規定されてなければエラーを出す
  def output_line(line)
    raise 'Called abstract method !!'
  end

  # レポートの末尾に出力
  def output_end
  end
end

# HTML形式でのレポート出力を行う
class HTMLReport < Report
  # レポートの先頭に出力
  def output_start
    puts ""
  end

  # 本文内のLINE出力部分
  def output_line(line)
    puts "
         #{line}

         "
  end

  # レポートの末尾に出力
  def output_end
    puts '
         '
  end
end

# PlaneText形式(`*****`で囲う)でレポートを出力
class PlaneTextReport < Report
  # レポートの先頭に出力
  def output_start
    puts "**** #{self.title} ****"
  end

  # 本文内のLINE出力部分
  def output_line(line)
    puts line
  end
end

html_report = HTMLReport.new
html_report.output_report
plane_report = PlaneTextReport.new
plane_report.output_report

