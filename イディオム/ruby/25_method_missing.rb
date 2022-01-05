class Foo
  def initialize(data)
    @data = data
  end
  def method_missing(name, lang)
    if name.to_s =~ /\Afind_(\d+)_in\z/
      if @data[lang]
        p @data[lang][$1.to_i]
      else
        raise "#{lang} unknown"
      end
    else
      super
    end
  end
end

dic = Foo.new({:English => %w(zero one two), :Esperanto => %w(nulo unu du)})
dic.find_2_in :Esperanto #=> "du"

