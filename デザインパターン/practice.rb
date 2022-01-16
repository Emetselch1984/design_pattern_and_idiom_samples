class BankAccount
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
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
    puts "___________"
    puts "#{Etc.getlogin}"
    puts "#{owner_name}"
    if(Etc.getlogin != owner_name)
      puts "sucess"
      raise "不適切なアクセスです: #{owner_name}"
    end
  end
  
end

bank_account = BankAccount.new(10000)
proxy = BankAccountProxy.new(bank_account,"foo")
proxy.owner_name
proxy.balance
proxy.withdraw(10000)

