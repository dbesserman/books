class Computer
  attr_accessor :display, :motherboard
  attr_reader :drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @motherboard = motherboard
    @display     = display
    @drives      = drives
  end
end

class CPU
  # Common CPU stuff...
end

class BasicCPU < CPU
  # Lots of not very fast CPU-related stuff...
end

class TurboCPU < CPU
  # Lots of very fast CPU stuff...
end

class Motherboard
  attr_accessor :cpu, :memory_size

  def initialize(cpu=BasicCPU.new, memory_size=1000)
    @cpu         = cpu
    @memory_size = memory_size
  end
end

class Drive
  attr_reader :type # either :hard_disk, :cd or :dvd
  attr_reader :size
  attr_reader :writable

  def initialize(type, size, writable)
    @type     = type
    @size     = size
    @writable = writable
  end
end

### Process of building a computer without a builder
# motherboard = Motherboard(TurboCPU.new, 4000)
# drives      = []

# drives << Drive.new(:hard_drive, 200000, true)
# drives << Drive.new(:cd, 760, true)
# drives << Drive.new(:dvd, 4700, false)

# Computer.new(:lcd, motherboard, drives)


class ComputerBuilder
  attr_reader :computer

  def initialize
    @computer = Computer.new
  end

  def turbo(has_turbo_cpu=true)
    computer.motherboard.cpu = TurboCPU.new
  end

  def display=(display)
    computer.display = display
  end

  def memory_size=(size_in_mb)
    computer.motherboard.memory_size = size_in_mb
  end

  def add_cd(writer=false)
    computer.drives << Drive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    computer.drives << Drive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end

  def method_missing(name, *args)
    words = name.to_s.split("_")
    return super(name, *args) unless words.shift == 'add'

    words.each do |word|
      case word
      when 'and'      then next
      when 'cd'       then add_cd
      when 'dvd'      then add_dvd
      when 'harddisk' then add_hard_disk(1000000)
      end
  end
end

builder = ComputerBuilder.new
builder.turbo
builder.add_cd(true)
builder.add_dvd
builder.add_hard_disk(100000)

computer = builder.computer
