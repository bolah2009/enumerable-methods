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
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?
    my_each { |i| return false if yield(i) == false }
    true
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) == true }
    elsif arg.class == Class
      my_each { |i| return false if i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return false if (i =~ arg).is_a? Integer }
    elsif arg.nil?
      my_each { |i| return false if i == true }
    end
    true
  end

  def my_count(arg = nil)
    count = 0
    if block_given?
      my_each { |i| count += 1 if yield(i) == true }
    elsif arg.nil?
      my_each { count += 1 }
    else
      my_each { |i| count += 1 if i == arg }
    end
    count
  end

  def my_map
    array = []
    my_each { |i| array << yield(i) }
    array
  end

  def my_inject
    array = self.to_a
    inject = array[0]
    array[1..-1].my_each { |i| inject = yield(inject, i) }
    inject
  end

  def multiply_els(array)
    array.my_inject { |mul, n| mul * n }
  end

  # rubocop:enable Style/For
end

array = [3, 5, 1, 2, 3, 4, 5, 6, 8, 9, 45]

# my_each
# array.my_each { |number| puts number }

# my_each_with_index
# array.my_each_with_index { |number, index| puts "#{index}: #{number}" }

# my_select
# array.my_select {|x| x< 20}

# array.my_all? { |x| x < 20 }
# p %w[ant bear cat].none? { |word| word.length == 5 } #=> true
# p %w[ant bear cat].none? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].none?(/d/)                        #=> true
# p [1, 3.14, 42].none?(Float)                         #=> false
# p [].none?                                           #=> true
# p [nil].none?                                        #=> true
# p [nil, false].none?                                 #=> true
# p [nil, false, true].none?                           #=> false
# puts '--------------------'
# p %w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
# p %w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
# p %w[ant bear cat].my_none?(/d/)                        #=> true
# p [1, 3.14, 42].my_none?(Float)                         #=> false
# p [].my_none?                                           #=> true
# p [nil].my_none?                                        #=> true
# p [nil, false].my_none?                                 #=> true
# p [nil, false, true].my_none?                           #=> false

# my_count
# p ary = [1, 2, 4, 2]
# p ary.count               #=> 4
# p ary.count(2)            #=> 2
# p ary.count{ |x| x%2==0 } #=> 3
# puts '--------------------'
# p ary = [1, 2, 4, 2]
# p ary.my_count               #=> 4
# p ary.my_count(2)            #=> 2
# p ary.my_count{ |x| x%2==0 } #=> 3

# my_map
# a = [ "a", "b", "c", "d" ]
# p a.map { |x| x + "!" } 
# puts '--------------------'
# p a.my_map { |x| x + "!" } 


# Same using a block and inject
p (5..10).inject { |sum, n| sum + n }            #=> 151200
puts '--------------------'
p (5..10).my_inject { |sum, n| sum + n }            #=> 151200

p (5..10).my_inject { |sum, n| sum + n }  
