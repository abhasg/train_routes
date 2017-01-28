require 'train_routes'

routes = TrainRoutes.new ['AB5', 'BC4', 'CD8', 'DC8', 'DE6', 'AD5', 'CE2', 'EB3', 'AE7']

# 1. The distance of the route A-B-C.
puts "Output #1: #{routes.distance_by_exact_path('A','B','C')}"

# 2. The distance of the route A-D.
puts "Output #2: #{routes.distance_by_exact_path('A','D')}"

# 3. The distance of the route A-D-C.
puts "Output #3: #{routes.distance_by_exact_path('A','D','C')}"

# 4. The distance of the route A-E-B-C-D.
puts "Output #4: #{routes.distance_by_exact_path('A','E','B','C','D')}"

# 5. The distance of the route A-E-D.
puts "Output #5: #{routes.distance_by_exact_path('A','E','D')}"

# 6. The number of trips starting at C and ending at C with a maximum of 3
#    stops.  In the sample data below, there are two such trips: C-D-C (2
#    stops). and C-E-B-C (3 stops).
puts "Output #6: #{routes.routes_by_exact_stop(['C','C'],3)}"

# 7. The number of trips starting at A and ending at C with exactly 4 stops.
#    In the sample data below, there are three such trips: A to C (via B,C,D); A
#    to C (via D,C,D); and A to C (via D,E,B).
puts "Output #7: #{routes.routes_by_exact_stop(['A','C'],4,true)}"

# 8. The length of the shortest route (in terms of distance to travel) from A
#    to C.
puts "Output #8: #{routes.distance_by_shortest_path('A','C')}"

# 9. The length of the shortest route (in terms of distance to travel) from B
#    to B.
puts "Output #9: #{routes.distance_by_shortest_path('B','B')}"

# 10. The number of different routes from C to C with a distance of less than
#     30.  In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC,
#     CEBCEBC, CEBCEBCEBC.
puts "Output #10: #{routes.routes_by_exact_distance(['C','C'],30)}"