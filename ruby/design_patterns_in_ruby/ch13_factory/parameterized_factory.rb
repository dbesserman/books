class Algae
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def grow
    puts "The Algaw #{name} soacks up the sun and grows"
  end
end
class WaterLily
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def grow
    puts "The water lily #{name} floats, soaks up the sun, and grows"
  end
end

class Duck
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eat
    puts "Duck #{name} is eating."
  end

  def speak
    puts "Duck #{name} says Quack!"
  end

  def sleep
    puts "Duck #{name} sleeps quietly."
  end
end

class Frog
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eat
    puts "Duck #{name} is eating."
  end

  def speak
    puts "Duck #{name} says Croooaaaak!"
  end

  def sleep
    puts "Frog #{name} doesn't sleep; he croaks all night!"
  end
end

class Pond
  attr_reader :animals, :plants

  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    plants.each(&:grow)
    animals.each(&:speak)
    animals.each(&:eat)
    animals.each(&:sleep)
  end
end

class DuckWaterLilyPond < Pond
  def new_organism(type, name)
    if type == :animal
      Duck.new(name)
    elsif type == :plant
      WaterLily.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

class FrogAlgaePond < Pond
  def new_organism(type, name)
    if type == :animal
      Frog.new(name)
    elsif type == :plant
      Algae.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end
