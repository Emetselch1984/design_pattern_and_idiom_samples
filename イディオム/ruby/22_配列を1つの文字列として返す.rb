# 配列を1つの文字列として返す
def numbers_text(numbers)
  text = ''
  numbers.each_with_index do |number, i|
    text += ', ' if i > 0
    text += number.to_s
  end
  text
end

numbers = (1..100).to_a
numbers_text(numbers)

def numbers_text(numbers)
  numbers.join(', ') # [1, 2, 3] => "1, 2, 3"
end

# 最大の要素を返す

class User
  attr_accessor :age
  def initialize(args)
    @age = args[:age]
  end
end

def oldest_user(users)
  oldest = nil
  users.each do |user|
    oldest = user if oldest.nil? || user.age > oldest.age
  end
  oldest
end

def oldest_user(users)
  users.max_by(&:age)
end

users = ["alice","bob","carol","charlie"]
alice = User.new(age: 15)
bob = User.new(age: 44)
carol = User.new(age: 68)
users = []
users << alice
users << bob
users << carol
