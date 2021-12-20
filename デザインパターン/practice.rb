require 'observer'

class Employee
  include Observable
  attr_reader :name,:title,:salary

  def initialize(name,title,salary)
    @name = name
    @title = title
    @salary = salary
    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end
end

class Payroll
  def update(changed_employee)
    text =
        <<TEXT
彼の給料は#{changed_employee.salary}に変更されました。
#{changed_employee.title}のために新しい小切手を発行します。
TEXT
    puts text
  end

end
class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.name}に新しい請求書を送ります"
  end
end

employ = Employee.new("alice","学費",300000)
employ.salary = 250000

