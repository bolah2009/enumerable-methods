# Rebuild some basic enumerable methods in ruby.
module Enumerable
  # rubocop:disable Style/For
  def my_each
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    counter = 0
    for i in self
      yield(i, counter)
      counter += 1
      end
  end

  def my_select
    array = []
    my_each {|i| array << i if yield(i)}
    array
  end
  # rubocop:enable Style/For
end

array = [3, 5, 1, 2, 3, 4, 5, 6, 8, 9, 45]

# array.my_each { |number| puts number }
# array.my_each_with_index { |number, index| puts "#{index}: #{number}" }

p array.my_select {|x| x< 20}