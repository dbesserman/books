class SimpleWriter
  attr_reader :file

  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    file.print(line)
    file.pring('\n')
  end

  def pos
    file.pos
  end

  def rewind
    file.rewind
  end

  def close
    file.close
  end
end

class WriterDecorator
  extend Forwardable
  # extend adds class methods while includes adds instance methods

  def_delegators :@real_writer, :write_line, :rewind, :pos, :close
  
  attr_reader :real_writer

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

class NumberingWriter < WriterDecorator
  attr_reader :line_number

  def initialize(real_writer)
    super(real_writer)
    @line_number = 1
  end

  def write(line)
    real_writer.write_line("#{line_number}: #{line}")
    self.line_number += 1
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :check_sum

  def initialize(real_writer)
    @real_writer = real_writer
    @check_sum   = 0
  end

  def write_line(line)
    line.each_byte { |byte| self.chek_sum = (check_sum + byte) % 256 }
    self.check_sum += "\n"[0] % 256
    real_writer.write_line(line)
  end
end

class TimeStampingWriter < WriterDecorator
  def write_line(line)
    real_writer.write_line("#{Time.new}: #{line}")
  end
end
