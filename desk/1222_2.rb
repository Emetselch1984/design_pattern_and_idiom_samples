class SaltWater
  attr_accessor :water,:salt

  def initialize(water,salt)
    @water = water
    @salt = salt
  end

  def add_material(material_amount)
    self.salt += material_amount
  end

  def result
    puts "塩の数は#{salt}"
    puts "水の量は#{water}"
  end


end

class SugarWater
  attr_accessor :water,:sugar

  def initialize(water,sugar)
    @water = water
    @sugar = sugar
  end

  def add_material(material_amount)
    self.sugar += material_amount
  end

  def result
    puts "砂糖の数は#{sugar}"
    puts "水の量は#{water}"
  end


end

class WaterWithMaterialBuilder
  attr_accessor :water_with_material

  def initialize(class_name)
    @water_with_material = class_name.new(0,0)
  end

  def add_water(water_amount)
    water_with_material.water += water_amount
  end

  def add_material(material_amount)
    water_with_material.add_material(material_amount)
  end

  def result
    water_with_material.result
  end

end

class Director
  attr_reader :builder

  def initialize(builder)
    @builder = builder
  end

  def cook
    builder.add_water(100)
    builder.add_water(300)
    builder.add_water(100)
    builder.add_water(100)
    builder.add_material(500)
    builder.add_water(100)
    builder.add_water(300)
    builder.add_water(100)
    builder.add_water(100)
    builder.add_material(500)
  end

  def result
    builder.result
  end

end

builder = WaterWithMaterialBuilder.new(SugarWater)
director = Director.new(builder)
director.cook
director.result