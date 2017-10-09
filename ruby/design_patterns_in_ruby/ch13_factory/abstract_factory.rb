class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

class JungleOrganismFactory
  def new_animal(name)
    Tiger.new(name)
  end

  def new_plant(name)
    Tree.new(name)
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
end
