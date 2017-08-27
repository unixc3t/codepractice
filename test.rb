def hel(**options)
  options.each do |meth,val|
    puts meth
    puts val
  end
end

 hel({hello=>'jack'})
