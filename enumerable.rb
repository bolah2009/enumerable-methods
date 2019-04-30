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
