require 'fileutils'

class CreateFile
  attr_reader :path,:contents

  def initialize(path,contents)
    @path = path
    @contents = contents
  end

  def execute
    file = File.open(path,"w")
    file.write(contents)
  end

  def undo_execute
    File.delete(path)
  end
end
path = "file1.txt"
contents = "hello world"

command = CreateFile.new(path,contents)
command.execute

class CompositeCommand
  attr_reader :commands

  def initialize
    @commands = []
  end

  def add_command(cmd)
    commands << cmd
  end

  def clear_commands
    commands.clear
  end

  def delete_command
    puts commands.size
    puts "delete #{commands[-1]}"
    commands.delete_at(-1)
    puts commands.size
  end

  def execute
    commands.each {|cmd| cmd.execute}
  end

  def undo_execute
    commands.reverse.each {|cmd| cmd.undo_execute}
  end

end

path1 = "file1.txt"
contents1 = "hello world"

command1 = CreateFile.new(path1,contents1)
path2 = "file2.txt"
contents2 = "hello world"

command2 = CreateFile.new(path2,contents2)

composite_command = CompositeCommand.new
composite_command.add_command(command1)
composite_command.add_command(command2)
composite_command.clear_commands
composite_command.add_command(command1)
composite_command.add_command(command2)
composite_command.delete_command
composite_command.add_command(command2)
composite_command.execute