class City
  attr_accessor :name, :routes

  def initialize(name)
    self.name = name
    self.routes = {}
  end

  def add_route(route)
    self.routes[route.destination.name] = route
  end
end