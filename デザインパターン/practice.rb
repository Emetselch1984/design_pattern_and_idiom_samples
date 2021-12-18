require "fileutils"

class CreateFile
  attr_reader :description,:path,:contents
  def initialize(path,contents)
    @description = default(path)
    @path = path
    @contents = contents

  end

  def default(path)
    "Create file : #{path}"
  end

  def execute
    f = File.open(path,"w")
    f.write(contents)
    f.close
  end

  def undo_execute
    File.delete(path)
  end


end

command = CreateFile.new("file1.txt","hello world \n")
command.execute
command.undo_execute
