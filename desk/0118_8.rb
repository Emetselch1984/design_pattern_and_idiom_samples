require 'fileutils'

class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute ;end

  def undo_execute ;end


end

class CreateFile < Command
  attr_reader :path,:contents

  def initialize(path,contents)
    super("Create file : #{path}")
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

  def description
    description = ""
    commands.each {|cmd| description+= cmd.description + "\n"}
    description
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
puts composite_command.description

class DeleteFile < Command
  attr_reader :path
  attr_accessor :contents

  def initialize(path)
    super("Delete file : #{path}")
    @path = path
    @contents = nil
  end

  def execute
    if File.exist?(path)
      self.contents = File.read(path)
    end
    File.delete(path)
  end

  def undo_execute
    f = File.open(path, "w")
    f.write(self.contents)
    f.close
  end

end

delete_command = DeleteFile.new(path1)
delete_command.execute
delete_command.undo_execute