
class FileEntry
  attr_reader :name
  def initialize(name)
    @name = name
  end

  def get_name
    name
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end

  def remove
    puts name + "を削除しました"
  end
end

root = FileEntry.new("root")
root.ls_entry("")
root.remove

class DirEntry
  attr_reader :name,:directory
  def initialize(name)
    @name = name
    @directory = Array.new
  end

  def get_name
    name
  end

  def add(entry)
    directory << entry
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    directory.each do |e|
      e.ls_entry(prefix + "/" + name)
    end
  end

  def remove
    puts name + "を削除しました"
  end
end


