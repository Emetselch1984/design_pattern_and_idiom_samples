class SugarWater
  attr_accessor :water,:sugar

  def initialize(water,sugar)
    @water = water
    @sugar = sugar
  end

  def result
    puts "砂糖の数は#{sugar}"
    puts "水の量は#{water}"
  end

end

class SugarWaterBuilder
  attr_reader :sugar_water,:default_water_amount,:default_sugar_amount

  def initialize
    @sugar_water = SugarWater.new(default_water_amount,default_sugar_amount)
  end

  def default_water_amount
    0
  end

  def default_sugar_amount
    0
  end

  def add_sugar(sugar_amount)
    sugar_water.sugar += sugar_amount
  end

  def add_water(water_amount)
    sugar_water.water += water_amount
  end

  def result
    sugar_water.result
  end

end

class Director
  attr_reader :builder

  def initialize(builder)
    @builder = builder
  end

  def cook
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
    builder.add_water(1000)
    builder.add_sugar(500)
  end

  def result
    builder.result
  end

end

director = Director.new(SugarWaterBuilder.new)
director.cook
director.result