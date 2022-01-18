class SugarWater
  attr_accessor :water,:sugar

  def initialize(water,sugar)
    @water = water
    @sugar = sugar
  end
end

class SugarWaterBuilder
  attr_accessor :sugar_water
  def initialize
    @sugar_water = SugarWater.new(0,0)
  end

  def add_water(sugar_amount)
    self.sugar_water.water += sugar_amount
  end

  def add_sugar(sugar_amount)
    self.sugar_water.sugar += sugar_amount
  end

  def result
    sugar_water
  end

end
builder = SugarWaterBuilder.new
builder.add_water(100)
builder.add_sugar(300)
builder.add_water(100)
builder.add_sugar(300)
builder.add_water(100)
builder.add_sugar(300)
builder.add_water(100)
builder.add_sugar(300)
builder.result

class Director
  attr_reader :builder

  def initialize(builder)
    @builder = builder
  end

  def cook
    builder.add_water(100)
    builder.add_sugar(300)
    builder.add_water(100)
    builder.add_sugar(300)
    builder.add_water(100)
    builder.add_sugar(300)
    builder.add_water(100)
    builder.add_sugar(300)
  end

  def result
    builder.result
  end

end
director = Director.new(builder)
director.cook
director.result

