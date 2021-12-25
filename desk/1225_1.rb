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

class DirEntry
  attr_accessor :directory,:name
  def initialize(name)
    @name = name
    @directory = Array.new
  end

  def get_name
    name
  end

  def add(entry)
    directory.push(entry)
  end

  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    directory.each do |e|
      e.ls_entry(prefix + "/" + name)
    end
  end

  def remove
    directory.each do |i|
      i.remove
    end
    puts name + "を削除しました"
  end

end

root = DirEntry.new("root")
tmp = DirEntry.new("tmp")
conf = DirEntry.new("conf")
data = FileEntry.new("data")
conf.add(data)
tmp.add(conf)
root.add(tmp)
root.ls_entry("")
root.remove

