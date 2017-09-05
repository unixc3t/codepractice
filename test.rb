require 'active_support/all'

fields=[:name, :age]
values=['jack', 12]

z = Hash.new.tap do |x|
  fields.each_with_index do |val, index|
    x[val] = values[index-1]
  end
end

p z
