class OrganismFactory
  attr_reader :animal_class, :plant_class

  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end

  def new_animal(name)
    animal_class.new(name)
  end

  def new_plant(name)
    plant_class.new(name)
  end
end

class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory
    @animals          = []
    @plants           = []

    number_animals.times do |i|
      animal = organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end

    number_plants.times do |i|
      plant = organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end
