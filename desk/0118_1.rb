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

def old_printer.print_name
  show_with_aster
end

printer = Printer.new(old_printer)
printer.print_name
