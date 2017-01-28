require 'pry'

class NumberOfTrips
  attr_accessor :travelled, :number_of_routes

  def initialize(network)
    @network = network
    self.travelled = 0
    self.number_of_routes = 0
  end

  def exact_stop starting_station, destination_station, max_stops, exact_stops
    connections = @network[starting_station].routes
    connections.each do |station, _|
      self.travelled += 1

      if check_stop_limit(station, destination_station, max_stops, exact_stops)
        self.number_of_routes += 1
      elsif travelled < max_stops
        exact_stop(station, destination_station, max_stops, exact_stops)
      end

      self.travelled -= 1
    end
  end

  def exact_distance starting_station, destination_station, max_distance
    connections = @network[starting_station].routes
    connections.each do |station,route|
      self.travelled += route.distance

      if self.travelled < max_distance
        self.number_of_routes += 1 if (destination_station == station)
        exact_distance(station, destination_station, max_distance)
      end

      self.travelled -= route.distance
    end
  end

  private
  def check_stop_limit(station, destination_station, max_stops, exact_stops)
    stop_limit = (self.travelled <= max_stops)
    stop_limit = (self.travelled == max_stops) if exact_stops
    (destination_station == station) && stop_limit
  end
end