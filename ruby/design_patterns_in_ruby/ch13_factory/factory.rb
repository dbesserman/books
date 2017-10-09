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
  attr_reader :animals

  def initialize(number_animals)
    @animals = []

    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    animals.each(&:speak)
    animals.each(&:eat)
    animals.each(&:sleep)
  end
end

class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end
