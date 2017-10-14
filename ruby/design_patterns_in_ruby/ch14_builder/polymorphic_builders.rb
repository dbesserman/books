class Computer
  attr_accessor :display, :motherboard
  attr_reader :drives

  def initialize(display=:crt, motherboard=Motherboard.new, drives=[])
    @motherboard = motherboard
    @display     = display
    @drives      = drives
  end
end

class DesktopComuter < Computer
  # Lots of interesting desktop details omitted...
end

class LaptopComputer < Computer
  def initialize(motherboard=Motherboard.new, drives=[])
    super(:lcd, motherboard, drives)
  end
  
  # Lots of interesting laptop details omitted...
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

class ComputerBuilder
  def turbo(has_turbo_cpu=true)
    computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size=(size_in_mb)
    computer.motherboard.memory_size = size_in_mb
  end

  def computer
    hard_disk = @computer.drives.find { |drive| drive.type == :hard_disk }

    raise "Not enough memory" if @computer.motherboard.memory_size < 250
    raise "Too many drives" if @computer.drives.size > 4

    if !hard_disk
      raise "No room to add hard disk." if @computer.drives.size > 4
      add_hard_disk(1000000)
    end

    @computer
  end
end

class DesktopBuilder < ComputerBuilder
  def initialize
    @computer = DesktopComputer.new
  end

  def display=(display)
    computer.display = display
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
end

class LaptopComputer < ComputerBuilder
  def initialize
    @computer = LaptopComputer.new
  end

  def display=(display)
    raise "Laptop display must be lcd" unless display == :lcd
  end

  def add_cd(writer=false)
    computer.drives << LaptopDrive.new(:cd, 760, writer)
  end

  def add_dvd(writer=false)
    computer.drives << LaptopDrive.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    computer.drives << LaptopDrive.new(:hard_disk, size_in_mb, true)
  end
end
