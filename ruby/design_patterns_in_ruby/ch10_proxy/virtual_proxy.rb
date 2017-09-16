require 'etc'

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

class VirtualAccountProxy
  attr_reader :creation_block
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def deposit(amount)
    s = subject
    s.deposit(amount)
  end

  def withdraw(amount)
    s = subject
    s.withdraw(amount)
  end

  def balance
    s = subject
    s.balance
  end

  def subject
    @subject ||= creation_block.call
  end
end

require 'pry'; binding.pry
