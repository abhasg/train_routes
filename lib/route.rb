class Route
  attr_accessor :source, :destination, :distance

  def initialize(source, destination, distance)
    self.source = source
    self.destination = destination
    self.distance = distance.to_i
  end
end