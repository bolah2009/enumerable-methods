# frozen_string_literal: true

# Rebuild some basic enumerable methods in ruby.
module Enumerable
  def my_each
    return to_enum unless block_given?

    each do |i|
      yield(i)
    end
  end

  def my_each_with_index
    return to_enum unless block_given?

    counter = 0
    each do |i|
      yield(i, counter)
      counter += 1
    end
  end

  def my_select
    return to_enum unless block_given?

    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg.class == Class
      my_each { |i| return false unless i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return false unless (i =~ arg).is_a? Integer }
    elsif arg.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless i == arg }
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |i| return true if yield(i) }
    elsif arg.class == Class
      my_each { |i| return true if i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return true if (i =~ arg).is_a? Integer }
    elsif arg.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if i == arg }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |i| return false if yield(i) }
    elsif arg.class == Class
      my_each { |i| return false if i.class == arg }
    elsif arg.class == Regexp
      my_each { |i| return false if (i =~ arg).is_a? Integer }
    elsif arg.nil?
      my_each { |i| return false if i }
    else
      my_each { |i| return false if i == arg }
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
    return to_enum unless block_given?

    array = []
    my_each { |i| array << yield(i) }
    array
  end

  def my_inject(arg_1 = nil, arg_2 = nil)
    array = to_a.dup
    (inject, sym) = if arg_1.nil?
                      [array.shift, nil]
                    elsif arg_2.nil? && !block_given?
                      [array.shift, arg_1]
                    elsif arg_2.nil? && block_given?
                      [arg_1, nil]
                    else
                      [arg_1, arg_2]
                    end

    if sym
      inject = inject_sym(array, sym, inject)
    else
      array[0..-1].my_each { |i| inject = yield(inject, i) }
    end
    inject
  end

  def inject_sym(array, sym, inject)
    array[0..-1].my_each { |i| inject = inject.send(sym, i) }
    inject
  end
end

def multiply_els(array)
  array.my_inject { |mul, n| mul * n }
end
