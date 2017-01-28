require 'dijkstra'
require 'route'
require 'city'
require 'number_of_trips'

class TrainRoutes
  attr_accessor :network, :dijkstra

  def initialize(all_routes)
    self.network = {}
    add_all_routes(all_routes)
  end

  def distance_by_exact_path(*cities)
    total_distance = 0
    begin
      cities.each_with_index do | source,index |
        destination = cities[index + 1]
        break if cities.count == index + 1
        destination_city = self.network[source].routes[destination]
        raise 'NO SUCH ROUTE' unless destination_city
        total_distance += destination_city.distance
      end
      total_distance
    rescue Exception => ex
      ex.message
    end
  end

  def routes_by_exact_stop(route, max_stops, exact_stops = false)
    current_station = route[0]
    destination_station = route[1]
    number_of_trips = NumberOfTrips.new(self.network)
    number_of_trips.exact_stop current_station, destination_station, max_stops, exact_stops
    number_of_trips.number_of_routes
  end

  def routes_by_exact_distance(route, max_distance)
    current_station = route[0]
    destination_station = route[1]
    number_of_trips = NumberOfTrips.new(self.network)
    number_of_trips.exact_distance current_station, destination_station, max_distance
    number_of_trips.number_of_routes
  end

  def distance_by_shortest_path(source,destination)
    initialize_dijkstra
    d = self.dijkstra
    d.start = source
    d.end = destination
    d.cost
  end

  private
  def add_all_routes all_routes
    all_routes.each do |route|
      city1, city2 = create_source_and_destination(route[0],route[1])
      route = Route.new(city1,city2,route[2])
      city1.add_route(route)
      self.network[route.source.name] = city1
    end
  end

  def create_source_and_destination source, destination
    city1 = self.network.keys.include?(source) ? self.network[source] : City.new(source)
    city2 = self.network.keys.include?(destination) ? self.network[destination] : City.new(destination)
    return city1, city2
  end

  def initialize_dijkstra
    edges = []
    self.network.each do | source,station |
      station.routes.each do |destination, route|
        edges.push([source, destination, route.distance])
      end
    end
    self.dijkstra = Dijkstra.new(edges)
  end
end