class BankAccount
  attr_accessor :balance

  def initialize(balance)
    announce
    @balance = balance
  end

  def announce
    puts "#{self.class}を作成しました"
  end

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    self.balance -= amount
  end
end

require 'etc'

class BankAccountProxy
  attr_reader :real_object,:owner_name

  def initialize(real_object,owner_name)
    @real_object = real_object
    @owner_name = owner_name
  end

  def balance
    check_access
    real_object.balance
  end

  def deposit(amount)
    check_access
    real_object.deposit(amount)
  end

  def withdraw(amount)
    check_access
    real_object.withdraw(amount)
  end

  def check_access
    if(Etc.getlogin != owner_name)
      raise "不適切なアクセスです: #{owner_name}"
    end
  end

end

bank_account = BankAccount.new(10000)

class VirtualAccountProxy
  attr_reader :starting_balance
  attr_accessor :bank_account

  def initialize(args)
    announce
    @starting_balance = args[:starting_balance]
  end

  def announce
    puts "#{self.class}を作成しました.BankAccountはまだ生成していません。"
  end

  def message
    "Virtual Account Proxyが担当するアナウンスです"
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def subject
    self.bank_account || (self.bank_account = BankAccount.new(starting_balance))
  end
end
args = {
    starting_balance: 1000
}
proxy = VirtualAccountProxy.new(args)
proxy.balance
proxy.deposit(10000)
user_foo = BankAccountProxy.new(proxy,"foo")
user_foo.balance
user_bou = BankAccountProxy.new(proxy,"bou")
user_bou.balance