require 'observer'
class Employee
  include Observable
  attr_reader :name,:title
  attr_accessor :salary

  def initialize(args)
    @name = args[:name]
    @title = args[:title]
    @salary = args[:salary]

    add_observer(Payroll.new)
    add_observer(TaxMan.new)
  end

  def salary=(new_salary)
    @salary = new_salary
    changed
    notify_observers(self)
  end

end


class TaxMan
  def update(changed_employee)
    puts "#{changed_employee.name}に新しい税金の請求書を送ります"
  end
end
class Payroll

  def update(changed_employee)
    puts "彼の給料は#{changed_employee.salary}"
  end
end

args = {
    name: "foo",
    title: "bar",
    salary: 10000
}

foo = Employee.new(args)
foo.salary = 50000
