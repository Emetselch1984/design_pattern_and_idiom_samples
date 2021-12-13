# サックス (Product)
class Saxophone
  def initialize(name)
    @name = name
  end

  def play
    puts "#{@name} は音を奏でています"
  end
end

# 楽器工場 (Creator)
class InstrumentFactory
  attr_accessor :saxophones
  def initialize(number_saxophones)
    @saxophones = []
    number_saxophones.times do |i|
      saxophone = Saxophone.new("サックス #{i}")
      @saxophones << saxophone
    end
  end

  # 楽器を出荷する
  def ship_out
    @tmp = saxophones.dup
    self.saxophones = []
    @tmp
  end
end

factory = InstrumentFactory.new(10)
saxophones = factory.ship_out

# トランペット (Product)
class Trumpet
  def initialize(name)
    @name = name
  end

  def play
    puts "トランペット #{@name} は音を奏でています"
  end
end

# 楽器工場 (Creator)
class InstrumentFactory
  def initialize(number_instruments)
    @instruments = []
    number_instruments.times do |i|
      instrument = new_instrument("楽器 #{i}")
      @instruments << instrument
    end
  end

  # 楽器を出荷する
  def ship_out
    @tmp = @instruments.dup
    @instruments = []
    @tmp
  end
end

# SaxophoneFactory: サックスを生成する (ConcreteCreator)
class SaxophoneFactory < InstrumentFactory
  def new_instrument(name)
    Saxophone.new(name)
  end
end

# TrumpetFactory: トランペットを生成する (ConcreteCreator)
class TrumpetFactory < InstrumentFactory
  def new_instrument(name)
    Trumpet.new(name)
  end
end
