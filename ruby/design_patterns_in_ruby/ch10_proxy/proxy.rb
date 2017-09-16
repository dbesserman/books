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

class AccountProtectionProxy
  attr_reader :subject, :owner_name

  def initialize(subject, owner_name)
    @subject    = subject
    @owner_name = owner_name
  end

  def balance
    check_access
    subject.balance
  end

  def deposit(amount)
    check_access
    subject.deposit(amount)
  end

  def withdraw(amount)
    check_access
    subject.withdraw(amount)
  end

  def check_access
    if Etc.getlogin != owner_name
      raise "Illegal access: #{Etc.getlogin} cannot access account"
    end
  end
end

require 'pry'; binding.pry
