require "fileutils"

class CreateFile
  attr_reader :path,:contents

  def initialize(path,contents)
    @path = path
    @contents = contents
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

  def notification_create_file
    puts "Create file : #{path}"
  end

  def notification_delete_file
    puts "Delete file : #{path}"
  end

end

file =CreateFile.new("test1223.txt","hello")
file.execute
class DeleteFile
  attr_reader :path
  attr_accessor :contents

  def initialize(path)
    @path = path
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
file =DeleteFile.new("test1223.txt")
file.execute
file.undo_execute

class CopyFile
  attr_reader :source,:target
  attr_accessor :contents

  def initialize(source,target)
    @source = source
    @target = target
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

file = CopyFile.new("test1223.txt","test1223_1.txt")
file.execute
file.undo_execute