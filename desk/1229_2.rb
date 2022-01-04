class Saxophone
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def play
    puts "サックス#{name}は音を奏でています"
  end
end
class Trumpet
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def play
    puts "トランペット#{name}は音を奏でています"
  end
end

class InstrumentFactory
  attr_accessor :instruments
  attr_reader :number_instruments

  def initialize(number_instruments)
    @number_instruments = number_instruments
    @instruments = []
  end

  def build ;end

  def play
    instruments.each do |instrument|
      instrument.play
    end
  end

  def ship_out
    @tmp = instruments.dup
    self.instruments = []
    @tmp
  end

end

class SaxophonesFactory < InstrumentFactory

  def build
    number_instruments.times do |i|
      saxophone = Saxophone.new(i)
      self.instruments << saxophone
    end
  end
end
class TrumpetsFactory < InstrumentFactory
  def build
    number_instruments.times do |i|
      trumpet = Trumpet.new(i)
      self.instruments << trumpet
    end
  end
end

factory = TrumpetsFactory.new(10)
factory.build
factory.play
factory.ship_out
factory = SaxophonesFactory.new(10)
factory.build
factory.play
factory.ship_out

