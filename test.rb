class Father
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

end

class Son < Father
end


son = Son.new('jack', 23)


puts son.name