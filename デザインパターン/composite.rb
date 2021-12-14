
## FileEntry, DirEntryクラスの共通メソッドを規定(Component)

class Entry
  # ファイル/ディレクトリの名称を返す
  def get_name
  end

  # ファイル/ディレクトリのパスを返す
  def ls_entry(prefix)
  end

  # ファイル/ディレクトリの削除を行う
  def remove
  end
end

# Leaf (中身)
# プロセスの単純な要素、再帰しない。
class FileEntry < Entry
  attr_reader :name
  def initialize(name)
    @name = name
  end

  # ファイルの名称を返す
  def get_name
    name
  end

  # ファイルのパスを返す
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
  end

  # ファイルの削除を行う
  def remove
    puts name + "を削除しました"
  end
end

# Composite
# 全てのオブジェクトの基底となるクラス
class DirEntry < Entry
  attr_reader :name,:directory
  def initialize(name)
    @name = name
    @directory = Array.new
  end

  # ディレクトリの名称を返す
  def get_name
    name
  end

  # ディレクトリにディレクトリ/ファイルを追加する
  def add(entry)
    directory.push(entry)
  end

  # ファイル/ディレクトリのパスを返す
  def ls_entry(prefix)
    puts(prefix + "/" + get_name)
    directory.each do |e|
      e.ls_entry(prefix + "/" + name)
    end
  end

  # ファイル/ディレクトリの削除を行う
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

#理解するの時間かかったので下記に記す
# ls_entryに`""`が渡される。
# `puts("" + "/" + "root")`
# となり、
# /rootと表示
# 次に、ls_entryに`"" + "/" + "root"`が渡される、
# `puts("" + "/" + "root" + "/" + "tmp")`
# となり、
# /root/tmpと表示
# 次に
# ls_entryに`"" + "/" + "root" + "/" + "tmp"`が渡され、
# `puts("" + "/" + "root" + "/" + "tmp" + "/" + "conf")`
# となり、
# /root/tmp/conf
# と表示
# 最後に、
# ls_entryに`"" + "/" + "root" + "/" + "tmp" + "/" + "conf"`が渡され、
# `puts("" + "/" + "root" + "/" + "tmp" + "/" + "conf" + "/" + "data")`
# となり、
# /root/tmp/conf/data
# と表示される。
