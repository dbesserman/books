require 'find'

class Expression
  def |(other)
    Or.new(self, other)
  end

  def &(other)
    And.new(self, other)
  end

  def all
    All.new
  end

  def bigger(size)
    Bigger.new(size)
  end

  def name(pattern)
    FileName.new(pattern)
  end

  def except(expression)
    Not.new(expression)
  end

  def writable
    Writable.new
  end
end

class All < Expression
  def evaluate(dir)
    results = []

    Find.find(dir) do |p|
      results << p if File.file?(p)
    end

    results
  end
end

class FileName < Expression
  attr_reader :pattern

  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []

    File.find(dir) do |p|
      next unless File.file?(p)

      name = File.basename(p)
      results << p if File.fnmatch(pattern, name)
    end

    results
  end
end

class Bigger < Expression
  attr_reader :size

  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []

    Find.find(dir) do |p|
      next unless File.file?(p)
      results << p if File.size(p) > size
    end

    results
  end
end

class Not < Expression
  attr_reader :expression

  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - expression.evaluate(dir)
  end
end

class Or < Expression
  attr_reader :expression1, :expression2

  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = expression1.evaluate(dir)
    result2 = expression2.evaluate(dir)

    (result1 & result2)
  end
end

class And < Expression
  attr_reader :expression1, :expression2

  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = expression1.evaluate(dir)
    result2 = expression2.evaluate(dir)

    (result1 + result2).sort.uniq
  end
end

class Parser
  attr_reader :tokens

  def initializek(text)
    @tokens = text.scan(/\(|\)|[\w\.\*]+/)
  end

  def next_token
    tokens.shift
  end

  def expression
    token = next_token

    case token
    when nil
      nil
    when '('
      result = expression
      raise 'Expected )' unless next_token == ')'
      result
    when 'all'
      All.new
    when 'writable'
      Writable.new
    when 'bigger'
      Bigger.new(next_token.to_i)
    when 'filename'
      FileName.new(next_token)
    when 'not'
      Not.new(expression)
    when 'and'
      And.new(expression, expression)
    when 'or'
      Or.new(expression, expression)
    else
      raise "Unexpected token: #{token}"
    end
  end
end
