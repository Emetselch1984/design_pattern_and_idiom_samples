require 'active_support/all'
# ロジックではなく、クエリでフィルタリングする
def admin_users
  User.all.select(&:admin?)
end
def admin_users
  User.where(admin: true)
end

# mapではなくpluckを使う

def admin_user_ids
  User.where(admin: true).map(&:id)
end
def admin_user_ids
  User.where(admin: true).pluck(&:id)
end
# tap の代わりに new + ブロックを使う

class User
  require 'active_support/all'
  attr_accessor :age,:admin,:name,:email
  def initialize
    @age = age
    @admin = false
    @name = name
    @email = email
  end
  def admin?
    admin == true
  end
end

def build_user
  User.new.tap do |user|
    user.email = "hoge@hoge.com"
    user.name = "Taro Yamada"
  end
end
def build_user
  User.new do |user|
    user.email = "hoge@hoge.com"
    user.name = "Taro Yamada"
  end
end