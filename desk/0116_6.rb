class Duck
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eat
    puts eat_text
  end

  def eat_text
    "アヒル #{name} は食事中です"
  end

end

duck = Duck.new("Alice")
duck.eat

class Frog
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eat
    puts eat_text
  end

  def eat_text
    "カエル #{name} は食事中です"
  end

end

frog = Frog.new("Alice")
frog.eat

class WaterLily
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def grow
    puts grow_text
  end

  def grow_text
    "睡蓮 #{name} は成長中です"
  end

end

waterlily = WaterLily.new("Alice")
waterlily.grow

class OrganismFactory
  attr_reader :animals,:plants
  def initialize(number_animals,number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("動物 #{i + 1}")
      @animals << animal
    end
    @plants = []
    number_plants.times do |i|
      plant = new_plant("植物 #{i + 1}")
      @plants << plant
    end

  end

  def get_animals
    animals
  end
  def get_plants
    plants
  end

  def animals_eat
    animals.each do |animal|
      animal.eat
    end
  end

  def plants_grow
    plants.each do |plant|
      plant.grow
    end
  end

end

class FrogAndWaterLilyFactory < OrganismFactory
  private

  def new_animal(duck)
    Duck.new(duck)
  end

  def new_plant(waterlily)
    WaterLily.new(waterlily)
  end
end
factory = FrogAndWaterLilyFactory.new(10,15)
factory.get_animals
factory.get_plants
factory.animals_eat
factory.plants_grow
