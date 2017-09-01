require 'active_support/all'
class A
  class << self
    def hello
      p 'GuestBook'.underscore.pluralize
    end
  end

  def world
    hello
  end
end

class B < A
  define_method :dd do
    puts 'dddddd' if :dd == :dd
  end
end

a = [:abc,:bcd,:created_at].map do |x|
   x == :created_at ? nil: x
end
p a
p ["''", "''", "'df'", "''", nil]
    .join(", ")



