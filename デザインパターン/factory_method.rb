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