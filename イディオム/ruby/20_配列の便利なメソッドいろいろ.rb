def find_admin(users)
  users.each do |user|
    return user if user.admin?
  end
  nil
end

# 最初に見つかったものを返す
# find
def find_admin(users)
  users.find(&:admin?)
end
# 条件に合うものを全て返す
# select

def find_admins(users)
  admins = []
  users.each do |user|
    admins << user if user.admin?
  end
end

def find_admins(users)
  users.select(&:admin?)
end
# falseの要素を集める場合はreject

# 条件に合う要素の数を返す
# count

def count_admin(users)
  count = 0
  users.each do |user|
    count +=1 if user.admin?
  end
  count
end

def count_admin(users)
  users.count(&:admin?)
end

# ある配列から別の配列を作る

def users_names(users)
  names = []
  users.each do |user|
    names << user.name
  end
  names
end

def users_names(users)
  users.map(&:name)
end

# mapの結果をネストしないフラットな配列として受け取る
nested_array = [[1,2,3],[4,5,6]]
mapped_array = nested_array.map {|array|array.map{|n| n * 10}}
flat_array = mapped_array.flatten

nested_array = [[1,2,3],[4,5,6]]
mapped_array = nested_array.flat_map {|array| array.map{|n| n * 10}}

# nil以外の要素を集める

numbers_and_nil = [1,2,3,nil,nil,6]
only_numbers = numbers_and_nil.reject(&:nil?)

numbers_and_nil = [1,2,3,nil,nil,6]
only_numbers = numbers_and_nil.compact

# any?:最低でも1つ条件に合う要素があればtrueを返す

def constains_nil?(users)
  users.each do |user|
    return true if user.nil?
  end
  false
end

def contains_nil?(users)
  users.any?(&:nil?)
end

