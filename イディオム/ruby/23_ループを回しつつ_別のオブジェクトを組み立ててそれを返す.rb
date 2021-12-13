# ループを回しつつ、別のオブジェクトを組み立ててそれを返す

class User
  attr_accessor :age,:admin,:name
  def initialize(args)
    @age = args[:age]
    @admin = false
    @name = args[:name]
  end

  def admin?
    admin == true
  end

end

def admin_names(users)
  ret = []
  users.each do |user|
    ret << user.name if user.admin?
  end
  ret
end

alice = User.new({
                     age: 15,
                     name: "alice"
                 })
bob = User.new({
                   age: 44,
                   name: "bob"
               })
carol = User.new(
    {
        age: 68,
        name: "carol"
    })
users = []
users << alice
users << bob
users << carol

alice.admin = true

def admin_names(users)
  users.each_with_object([]) do |user, names|
    names << user.name if user.admin?
  end
end

users.select(&:admin?).map(&:name)