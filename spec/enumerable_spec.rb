# frozen_string_literal: true

require_relative '../lib/enumerables'

ARRAY_SIZE = 100
LOWEST_VALUE = 0
HIGHEST_VALUE = 9

describe 'enumerables' do
  let(:array) { Array.new(ARRAY_SIZE) { rand(LOWEST_VALUE...HIGHEST_VALUE) } }
  let(:block) { proc { |num| num < (LOWEST_VALUE + HIGHEST_VALUE) / 2 } }
  let(:words) { %w[dog door rod blade] }
  let(:range) { Range.new(5, 50) }
  let(:numbers) { [1, 2i, 3.14] }

  describe '#my_each' do
    it 'calls the given block once for each element in self' do
      my_each_output = ''
      block = proc { |num| my_each_output += num.to_s }
      array.each(&block)
      each_output = my_each_output.dup
      my_each_output = ''
      array.my_each(&block)
      expect(my_each_output).to eq(each_output)
      expect(range.my_each(&block)).to eq(range.each(&block))
    end

    it 'returns an Enumerator if no block is given' do
      expect(array.my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'calls the given block once for each element in self' do
      my_each_output = ''
      block = proc { |num, idx| my_each_output += "Num: #{num}, idx: #{idx}\n" }
      array.each_with_index(&block)
      each_output = my_each_output.dup
      my_each_output = ''
      array.my_each_with_index(&block)
      expect(my_each_output).to eq(each_output)
      expect(range.my_each_with_index(&block)).to eq(range.each_with_index(&block))
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array containing all elements of enum for which the given block returns a true value' do
      expect(array.my_select(&block)).to eq(array.select(&block))
      expect(range.my_select(&block)).to eq(range.select(&block))
    end

    it 'returns an enumerator if no block is given' do
      expect(array.my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    let(:true_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num > HIGHEST_VALUE } }
    it 'returns true if the block never returns false or nil' do
      expect(array.my_all?(&true_block)).to eq(array.all?(&true_block))
      expect(array.my_all?(&false_block)).to eq(array.all?(&false_block))
      expect(range.my_all?(&false_block)).to eq(range.all?(&false_block))
    end

    context 'when no block or argument is given' do
      let(:true_array) { [1, true, 'hi', []] }
      let(:false_array) { [1, false, 'hi', []] }
      it 'returns true when none of the collection members are false or nil' do
        expect(true_array.my_all?).to be true_array.all?
        expect(false_array.my_all?).to be false_array.all?
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if all of the collection is a member of such class' do
        expect(array.my_all?(Integer)).to be array.all?(Integer)
        array[0] = 'word'
        expect(array.my_all?(Integer)).to be array.all?(Integer)
        expect(numbers.my_all?(Numeric)).to be numbers.all?(Numeric)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns true if all of the collection matches the Regex' do
        expect(words.my_all?(/d/)).to be words.all?(/d/)
        expect(words.my_all?(/o/)).to be words.all?(/o/)
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns true if all of the collection matches the pattern' do
        expect(array.my_all?(3)).to be array.all?(3)
        array = []
        5.times { array << 3 }
        expect(array.my_all?(3)).to be array.all?(3)
      end
    end
  end

  describe '#my_any?' do
    let(:true_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num > HIGHEST_VALUE } }
    it 'returns true if the block ever returns a value other than false or nil' do
      expect(array.my_any?(&true_block)).to eq(array.any?(&true_block))
      expect(array.my_any?(&false_block)).to eq(array.any?(&false_block))
      expect(range.my_any?(&false_block)).to eq(range.any?(&false_block))
    end

    context 'when no block or argument is given' do
      let(:true_array) { [nil, false, true, []] }
      let(:false_array) { [nil, false, nil, false] }
      it 'returns true if at least one of the collection is not false or nil' do
        expect(true_array.my_any?).to be true_array.any?
        expect(false_array.my_any?).to be false_array.any?
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if at least one of the collection is a member of such class' do
        expect(array.my_any?(Numeric)).to be array.any?(Numeric)
        expect(words.my_any?(Integer)).to be words.any?(Integer)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns false if none of the collection matches the Regex' do
        expect(words.my_any?(/z/)).to be words.any?(/z/)
        expect(words.my_any?(/d/)).to be words.any?(/d/)
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns false if none of the collection matches the pattern' do
        expect(words.my_any?('cat')).to be words.any?('cat')
        words[0] = 'cat'
        expect(words.my_any?('cat')).to be words.any?('cat')
      end
    end
  end

  describe '#my_none?' do
    let(:true_block) { proc { |num| num > HIGHEST_VALUE } }
    let(:false_block) { proc { |num| num <= HIGHEST_VALUE } }
    let(:true_array) { [nil, false, true, []] }
    let(:false_array) { [nil, false, nil, false] }
    it 'returns true if the block never returns true for all elements' do
      expect(array.my_none?(&true_block)).to eq(array.none?(&true_block))
      expect(array.my_none?(&false_block)).to eq(array.none?(&false_block))
      expect(range.my_none?(&false_block)).to eq(range.none?(&false_block))
    end

    context 'when no block or argument is given' do
      it 'returns true only if none of the collection members is true' do
        expect(false_array.my_none?).to be true
        expect(true_array.my_none?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if none of the collection is a member of such class' do
        expect(array.my_none?(String)).to be array.my_none?(String)
        array[0] = 'hi'
        expect(array.my_none?(String)).to be array.my_none?(String)
        expect(array.my_none?(Numeric)).to be array.my_none?(Numeric)
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns true only if none of the collection matches the Regex' do
        expect(words.my_none?(/z/)).to be words.none?(/z/)
        expect(words.my_none?(/d/)).to be words.none?(/d/)
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns true only if none of the collection matches the pattern' do
        expect(words.my_none?(5)).to be words.none?(5)
        words[0] = 5
        expect(words.my_none?(5)).to be words.none?(5)
      end
    end
  end

  describe '#my_count' do
    it 'returns the number of items in enum through enumeration' do
      expect(array.my_count).to eq array.count
      expect(range.my_count).to eq range.count
    end

    it 'counts the number of items in enum that are equal to item if an argument is given' do
      expect(array.my_count(LOWEST_VALUE)).to eq array.count(LOWEST_VALUE)
    end

    it 'counts the number of elements yielding a true value if a block is given' do
      expect(array.my_count(&block)).to eq array.count(&block)
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of running block once for every element in enum.' do
      expect(array.my_map(&block)).to eq array.map(&block)
      expect(range.my_map(&block)).to eq range.map(&block)
    end

    it 'returns an Enumerator if no block is given' do
      expect(array.my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    let(:operation) { proc { |sum, n| sum + n } }
    let(:search) { proc { |memo, word| memo.length > word.length ? memo : word } }

    it 'raises a "LocalJumpError" when no block or argument is given' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end

    it 'searches for the longest word in an array of strings' do
      expect(words.my_inject(&search)).to eq words.inject(&search)
    end

    context 'when a block is given without an initail value' do
      it 'combines all elements of enum by applying a binary operation, specified by a block' do
        expect(array.my_inject(&operation)).to eq array.inject(&operation)
        actual = range.my_inject { |prod, n| prod * n }
        expected = range.inject { |prod, n| prod * n }
        expect(actual).to eq expected
      end
    end

    context 'when a block is given with an initail value' do
      it 'combines all elements of enum by applying a binary operation, specified by a block' do
        actual = range.my_inject(4) { |prod, n| prod * n }
        expected = range.inject(4) { |prod, n| prod * n }
        expect(actual).to eq expected
      end
    end

    context 'when a symbol is specified without an initail value' do
      it 'combines each element of the collection by applying the symbol as a named method' do
        expect(array.my_inject(:+)).to eq array.inject(:+)
        expect(range.my_inject(:*)).to eq range.inject(:*)
      end
    end

    context 'when a symbol is specified with an initail value' do
      it 'combines each element of the collection by applying the symbol as a named method' do
        expect(range.my_inject(2, :*)).to eq range.inject(2, :*)
        expect(array.my_inject(20, :*)).to eq array.inject(20, :*)
      end
    end
  end

  describe '#multiply_els' do
    it 'accepts an array as an argument and multiplies all the elements of the array together using #my_inject' do
      actual = multiply_els [2, 4, 5]
      expect(actual).to eq 40
    end
  end
end
