require 'active_support/all'
a = { nick: 'dfd', ip: '123' }.select{|k,v| v.present?}.to_a.map {|x| "#{x[0]} = '#{x[1]}'"}
p a
p a.join(" and ")