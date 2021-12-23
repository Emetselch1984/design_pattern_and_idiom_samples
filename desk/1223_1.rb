require "fileutils"

class Command
  attr_reader :description
  def initialize(description)
    @description = description
  end
end

class CreateFile < Command
  attr_reader :path,:contents

  def initialize(path,contents)
    super(description)
    @path = path
    @contents = contents
  end

  def description
    "Create: #{path}を作成する。内容は#{contents}"
  end

  def execute
    notification_create_file
    f = File.open(path,"w")
    f.write(contents)
    f.close
  end

  def undo_execute
    notification_delete_file
    File.delete(path)
  end

  def notification_execute
    puts "Create file : #{path}"
  end

  def notification_undo_execute
    puts "Delete file : #{path}"
  end

end

class DeleteFile < Command
  attr_reader :path
  attr_accessor :contents

  def initialize(path)
    super(description)
    @path = path
  end

  def description
    "Delete: #{path}を削除する"
  end

  def execute
    notification_execute
    if File.exists?(path)
      self.contents = File.read(path)
    end
    File.delete(path)

  end

  def undo_execute
    notification_undo_execute
    f = File.open(path,"w")
    f.write(contents)
    f.close
  end

  def notification_execute
    puts "Delete file : #{path}"
  end

  def notification_undo_execute
    puts "Delete file : #{path}をキャンセルしました"
  end

end

class CopyFile < Command
  attr_reader :source,:target
  attr_accessor :contents

  def initialize(source,target)
    super(description)
    @source = source
    @target = target
  end

  def description
    "Copy: #{source}をコピーして、#{target}を作成する"
  end

  def execute
    notification_execute
    self.contents = File.read(source)
    FileUtils.copy(source,target)
  end

  def undo_execute
    notification_undo_execute
    File.delete(target)
    if self.contents
      file =File.open(source,"w")
      file.write(self.contents)
      file.close
    end
  end

  def notification_execute
    puts "Copy file : #{source}"
  end

  def notification_undo_execute
    puts "Copy file : #{source}をキャンセルしました"
  end

end

class CompositeCommand < Command
  attr_reader :commands

  def initialize
    @commands = []
  end

  def add_command(command)
    commands << command
  end

  def delete_command
    commands.delete(-1)
  end

  def all_clear_commands
    commands.clear
  end

  def execute
    commands.each {|command| command.execute}
  end

  def undo_execute
    commands.reverse.each {|command| command.undo_execute}
  end

  def description
    description = ""
    commands.each {|command| description += "#{command.description} \n"}
    description
  end

end

class Director
  attr_reader :builder

  def initialize(class_name)
    @builder = class_name.new
  end

  def execute
    builder.add_command(CreateFile.new("test1223.txt","hello"))
    builder.add_command(DeleteFile.new("test1223.txt"))
    builder.add_command(CopyFile.new("test1223.txt","test1223_1.txt"))
  end

  def description
    puts builder.description
  end
end

director = Director.new(CompositeCommand)
director.execute
director.description

