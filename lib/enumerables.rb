# frozen_string_literal: true

# Rebuild some basic enumerable methods in ruby.
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a.dup
    i = 0
    while i < arr.length
      yield arr[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    arr = to_a.dup
    counter = 0
    i = 0
    while i < arr.length
      yield(arr[i], counter)
      counter += 1
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    my_each { |i| array << i if yield(i) }
    array
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |i| return false unless yield(i) }
    elsif arg.nil?
      my_each { |i| return false unless i }
    else
      my_each { |i| return false unless check_pattern(i, arg) }
    end
    true
  end

  def my_any?(arg = nil, &block)
    if block
      my_each { |i| return true if block.yield(i) }
    elsif arg.nil?
      my_each { |i| return true if i }
    else
      my_each { |i| return true if check_pattern(i, arg) }
    end
    false
  end

  def my_none?(arg = nil, &block)
    !my_any?(arg, &block)
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
    return to_enum(:my_map) unless block_given?

    array = []
    my_each { |i| array << yield(i) }
    array
  end

  def my_inject(arg_1 = nil, arg_2 = nil, &block)
    array = to_a.dup
    (inject, sym, array) = get_inject_and_sym(arg_1, arg_2, array, block_given?)
    inject = if sym
               inject_sym(array, sym, inject)
             else
               inject_block(array, inject, &block)
             end
    inject
  end

  private

  def check_pattern(index, arg)
    return index.is_a?(arg) if arg.is_a? Class

    return arg.match?(index) if arg.is_a? Regexp

    index == arg
  end

  def get_inject_and_sym(arg1, arg2, arr, block)
    arg1 = arr.shift if arg1.nil? && block
    return [arg1, nil, arr] if block
    return [arr.shift, arg1, arr] if arg2.nil?

    [arg1, arg2, arr]
  end

  def inject_sym(array, sym, inject)
    array[0..-1].my_each { |i| inject = inject.send(sym, i) }
    inject
  end

  def inject_block(array, inject, &block)
    raise LocalJumpError, 'no block given' unless block

    array[0..-1].my_each { |i| inject = block.yield(inject, i) }
    inject
  end
end

def multiply_els(array)
  array.my_inject { |mul, n| mul * n }
end
