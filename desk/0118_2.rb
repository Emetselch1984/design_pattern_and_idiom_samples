class Client
  attr_reader :name

  def initialize(aras)
    @name = aras[:name]
  end

  def print_name
    puts "My name is #{name}"
  end

  def print_strong_name
    puts "My name is #{name.upcase}!!!!!!!!!"
  end

end
args = {
    name: "Alice"
}
client = Client.new(args)
client.print_name

class Printer
  attr_reader :obj

  def initialize(obj)
    @obj = obj
  end

  def print_name
    obj.print_name
  end

  def print_strong_name
    obj.print_strong_name
  end

end
printer = Printer.new(client)
printer.print_name

class OldPrinter
  attr_reader :string

  def initialize(string)
    @string = string.dup
  end

  def show_with_paren
    puts "(#{string})"
  end

  def show_with_aster
    puts "*#{string}*"
  end

end
string = "hello"
old_printer = OldPrinter.new(string)
old_printer.show_with_aster

class Adapter
  attr_reader :old_printer

  def initialize(string)
    @old_printer = OldPrinter.new(string)
  end

  def print_name
    old_printer.show_with_paren
  end

  def print_strong_name
    old_printer.show_with_aster
  end

end
adapter = Adapter.new("hello")
printer = Printer.new(adapter)
printer.print_strong_name