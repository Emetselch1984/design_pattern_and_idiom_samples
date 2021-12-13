class Client
  attr_accessor :name

  def initialize(args)
    @name = args[:name]
  end

  def print_name
    puts "My name is #{self.name}"
  end

  def print_strong_name
    puts "My name is #{self.name}!!!!!!"
  end

end


# 利用者(Client)へのインターフェイス (Target)
class Printer
  def initialize(obj)
    @obj = obj
  end

  def print_name
    @obj.print_name
  end

  def print_strong_name
    @obj.print_strong_name
  end
end

# Targetにはないインターフェイスを持つ (Adaptee)
class OldPrinter
  def initialize(string)
    @string = string.dup
  end

  # カッコに囲って文字列を表示する
  def show_with_paren
    puts "(#{@string})"
  end

  # アスタリスクで囲って文字列を表示する
  def show_with_aster
    puts "*#{@string}*"
  end
end
# Targetが利用できるインターフェイスに変換 (Adapter)
class Adapter
  def initialize(string)
    @old_printer = OldPrinter.new(string)
  end

  def print_name
    @old_printer.show_with_paren
  end

  def print_strong_name
    @old_printer.show_with_aster
  end
end

client = Client.new({
                        name: "Alice"
                    })
p = Printer.new(client)
p.print_strong_name
p.print_name

p = Printer.new(Adapter.new("My name is Alice"))
p.print_strong_name
p.print_name

#特異メソッド
class OldPrinter
  def initialize(string)
    @string = string.dup
  end

  # カッコに囲って文字列を表示する
  def show_with_paren
    puts "(#{@string})"
  end

  # アスタリスクで囲って文字列を表示する
  def show_with_aster
    puts "*#{@string}*"
  end
end
class Client
  attr_accessor :name

  def initialize(args)
    @name = args[:name]
  end

  def print_name
    puts "My name is #{self.name}"
  end

  def print_strong_name
    puts "My name is #{self.name}!!!!!!"
  end

end


# 利用者(Client)へのインターフェイス (Target)
class Printer
  def initialize(obj)
    @obj = obj
  end

  def print_name
    @obj.print_name
  end

  def print_strong_name
    @obj.print_strong_name
  end
end

text = OldPrinter.new("My name is Alice")

def text.print_name
  show_with_paren
end
def text.print_strong_name
  show_with_aster
end

p = Printer.new(text)
p.print_name
p.print_strong_name
