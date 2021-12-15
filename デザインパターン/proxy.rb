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