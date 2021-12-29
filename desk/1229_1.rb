class Saxophone
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def play
    puts "#{name}は音を奏でています"
  end
end

class InstrumentFactory
  attr_accessor :saxophones
  attr_reader :number_saxophones

  def initialize(number_saxophones)
    @number_saxophones = number_saxophones
    @saxophones = []
  end

  def build
    number_saxophones.times do |i|
      saxophone = Saxophone.new("サックス")
      self.saxophones << saxophone
    end
  end

  def play
    saxophones.each do |saxophone|
      saxophone.play
    end
  end

  def ship_out
    @tmp = saxophones.dup
    self.saxophones = []
    @tmp
  end

end
factory = InstrumentFactory.new(10)
factory.build
factory.play
factory.ship_out