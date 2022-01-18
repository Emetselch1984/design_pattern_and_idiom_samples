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

class SugarWater
  attr_accessor :water,:sugar

  def initialize(water,sugar)
    @water = water
    @sugar = sugar
  end

  def add_material(sugar_amount)
    self.sugar += sugar_amount
  end

end


class SaltWater
  attr_accessor :water,:salt

  def initialize(water,salt)
    @water = water
    @salt = salt
  end

  def add_material(salt_amount)
    self.salt += salt_amount
  end
end

class WaterWithMaterialBuilder
  attr_accessor :water_with_material
  def initialize(class_name)
    @water_with_material = class_name.new(0,0)
  end

  def add_water(water_amount)
    self.water_with_material.water += water_amount
  end

  def add_material(material_amount)
    self.water_with_material.add_material(material_amount)
  end


  def result
    water_with_material
  end

end
water_with_material = WaterWithMaterialBuilder.new(SugarWater)
water_with_material.add_water(100)
water_with_material.add_material(500)
water_with_material.result
class Director
  attr_reader :builder

  def initialize(builder)
    @builder = builder
  end

  def cook
    builder.add_water(100)
    builder.add_material(300)
    builder.add_water(100)
    builder.add_material(300)
    builder.add_water(100)
    builder.add_material(300)
    builder.add_water(100)
    builder.add_material(300)
  end

  def result
    builder.result
  end

end
builder = WaterWithMaterialBuilder.new(SugarWater)
director = Director.new(builder)
director.cook
director.result
