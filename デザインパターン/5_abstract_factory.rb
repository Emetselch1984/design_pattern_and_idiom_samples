# アヒル
class Duck
  def initialize(name)
    @name = name
  end

  # 食べる(eat)
  def eat
    puts "アヒル #{@name} は食事中です"
  end
end

# カエル
class Frog
  def initialize(name)
    @name = name
  end

  # 食べる(eat)
  def eat
    puts "カエル #{@name} は食事中です"
  end
end
# 植物/藻
class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts "藻 #{@name} は成長中です"
  end
end

# 植物/スイレン
class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts "スイレン #{@name} は成長中です"
  end
end
# 池の生態系を作る (Abstract Factory)
class OrganismFactory
  def initialize(number_animals, number_plants)
    @animals = []
    # 池の動物を定義する
    number_animals.times do |i|
      animal = new_animal("動物 #{i}")
      @animals << animal
    end

    @plants = []
    # 池の植物を定義する
    number_plants.times do |i|
      plant = new_plant("植物 #{i}")
      @plants << plant
    end
  end

  # 植物についてのオブジェクトを返す
  def get_plants
    @plants
  end

  # 動物についてのオブジェクトを返す
  def get_animals
    @animals
  end
end

# カエル(Frog)と藻(Algae)の生成を行う (Concrete Factory)
class FrogAndAlgaeFactory < OrganismFactory
  private

  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# アヒル(Duck)とスイレン(WaterLily)の生成を行う(Concrete Factory)
class DuckAndWaterLilyFactory < OrganismFactory
  private

  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end
