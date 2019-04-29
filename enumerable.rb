# Rebuild some basic enumerable methods in ruby.
module Enumerable
  def my_each
    each do |i|
      yield(i)
    end
  end
end

array = [3, 5, 1, 2, 3, 4, 5, 6, 8, 9, 45]

array.my_each { |number| print number }
