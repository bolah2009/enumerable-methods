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
  # rubocop:enable Style/For

  def my_select
    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?
    my_each { |i| return false if yield(i) == false }
    true
  end

  # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
  # rubocop:disable Metrics/CyclomaticComplexity
  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) == true }
    elsif arg.class == Class
      my_each { |i| return true if i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return true if (i =~ arg).is_a? Integer }
    elsif arg.nil?
      my_each { |i| return true if i == true }
    end
    false
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

  # rubocop:enable Metrics/AbcSize, Metrics/PerceivedComplexity
  # rubocop:enable Metrics/CyclomaticComplexity
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
    array = to_a
    inject = array[0]
    array[1..-1].my_each { |i| inject = yield(inject, i) }
    inject
  end

  def multiply_els(array)
    array.my_inject { |mul, n| mul * n }
  end
end
