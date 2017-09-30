class SimpleLogger
  attr_accessor :level, :log
  include 'singleton'
  # creates the class variable
  # initializes it with the singleton instance
  # create an `instance` class method
  # makes the `new` class method private

  ERROR = 1
  WARNING = 2
  INFO = 3

  def initialize
    @log = File.open('log.txt', 'w')
    @level = WARNING
  end

  def error(msg)
    log.puts(msg)
    log.flush
  end

  def warning(msg)
    log.puts(msg) if level >= WARNING
    log.flush
  end

  def info(msg)
    log.puts(msg) if level >= INFO
    log.flush
  end
end

require 'pry'; binding.pry

