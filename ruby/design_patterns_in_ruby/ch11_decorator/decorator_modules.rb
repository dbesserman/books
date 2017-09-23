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

class NumberingWriter
  attr_reader :line_number

  def write(line)
    @line_number = 1 unless @line_number
    real_writer.write_line("#{@line_number}: #{line}")
    @line_number += 1
  end
end

module TimeStampingWriter
  def write_line(line)
    real_writer.write_line("#{Time.new}: #{line}")
  end
end
