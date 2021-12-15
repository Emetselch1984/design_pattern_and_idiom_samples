# 銀行の入出金業務を行う(対象オブジェクト/subject)
class BankAccount
  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  # 出金
  def deposit(amount)
     balance += amount
  end

  # 入金
  def withdraw(amount)
     balance -= amount
  end
end

# etcはRubyの標準ライブラリで、/etc に存在するデータベースから情報を得る
# この場合は、ログインユーザー名を取得するために使う
require "etc"

# ユーザーログインを担当する防御Proxy
class BankAccountProxy
  attr_reader :real_object,:owner_name
  def initialize(real_object, owner_name)
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
      raise "不適切なアクセスです: #{owner_name} cannot access account."
    end
  end
end

# 仮想プロキシ

# 銀行の入出金業務を行う(対象オブジェクト/subject)
class BankAccount
  attr_accessor :balance

  def initialize(balance)
    puts "BankAccountを生成しました"
    @balance = balance
  end

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    self.balance -= amount
  end
end

# BankAccountの生成を遅らせる仮想Proxy
class VirtualAccountProxy
  attr_reader :starting_balance
  attr_accessor :bank_account
  def initialize(args)
    puts "VirtualAccountPoxyを生成しました。BankAccountはまだ生成していません。"
    @starting_balance = args[:starting_balance]
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

  def announce
    "Virtual Account Proxyが担当するアナウンスです"
  end

  def subject
    self.bank_account || ( self.bank_account = BankAccount.new(starting_balance))
  end
end
proxy = VirtualAccountProxy.new({:starting_balance => 100})
proxy.deposit(100)
proxy.balance
user_bou = BankAccountProxy.new(proxy,"foo")
user_bou.balance
