
a=%w(guests_controller.rb application_controller.rb)

a.sort! do |x , y|
  x[0] <=> y[0]

end

puts a