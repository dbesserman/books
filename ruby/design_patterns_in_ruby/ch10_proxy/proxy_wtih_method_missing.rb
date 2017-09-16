class BankAccount
  attr_accessor :balance

  def initialize(starting_balance=0)
    @balance = starting_balance
  end

  def deposit(amount)
    self.balance += amount
  end

  def withdraw(amount)
    self.balance -= amount
  end
end

class AccountProxy
  attr_accessor :subject

  def initialize(real_account)
    @subject = real_account
  end

  def method_missing(name, *args)
    puts "Delegating #{name} message to subject."
    subject.send(name, *args)
  end
end

require 'pry'; binding.pry
