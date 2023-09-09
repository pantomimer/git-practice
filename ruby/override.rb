class Car
  def run(distance)
    puts "車で#{distance}キロ走ります。"
  end
end

class Bus < Car
  def run(distance)
    puts "バスで#{distance}キロ走ります。"
    puts "30人を乗せて、走っています。"
  end
end

bus = Bus.new
bus.run(5)

car = Car.new
car.run(5)