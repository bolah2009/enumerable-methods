# frozen_string_literal: true

require_relative '../lib/enumerable'

describe Enumerable do
  describe '#each' do
    it 'calls the given block once for each element' do
      expect([1, 2, 3, 4].my_each { |i| i }).to eq [1, 2, 3, 4]
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each).to be_an(Enumerator)
    end
  end

  describe '#my_each_with_index' do
    it 'calls block with two arguments, the item and its index' do
      hash_with_two_arguments = {}
      [1, 2, 3, 4].my_each_with_index do |value, index|
        hash_with_two_arguments[index] = value
      end
      expect(hash_with_two_arguments[0]).to eq 1
    end

    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each_with_index).to be_an(Enumerator)
    end
  end

  describe '#my_select' do
    it 'returns an array containing all elements for which the given block returns a true value.' do
      actual = [2, 3, 4, 5, 6, 7].my_select(&:even?)
      expected = [2, 4, 6]
      expect(actual).to eq expected
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_select).to be_an(Enumerator)
    end
  end

  describe '#my_all?' do
    it 'returns true if the block never returns false or nil' do
      expect([1, 2, 3, 4, 5].my_all? { |i| i < 10 }).to be true
      expect([1, 2, 3, 4, 5].my_all? { |i| i < 5 }).to be false
    end

    context 'when no block or argument is given' do
      it 'returns true when none of the collection members are false or nil' do
        expect([0, true, 3, 'hello'].my_all?).to be true
        expect([0, true, 3, nil].my_all?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if all of the collection is a member of such class' do
        expect([1, 2, 3, 4].my_all?(Integer)).to be true
        expect([nil, false, 3, 'hello'].my_all?(Integer)).to be false
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns true if all of the collection matches the Regex' do
        expect(%w[dog door rod blade].my_all?(/d/)).to be true
        expect([nil, false, 3, 'hello'].my_all?(/d/)).to be false
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns true if all of the collection matches the pattern' do
        expect([nil, false, 3, 'hello'].my_all?(3)).to be false
        expect([3, 3, 3, 3].my_all?(3)).to be true
      end
    end
  end

  describe '#my_any?' do
    it 'returns true if the block ever returns a value other than false or nil' do
      expect([1, 2, 3, 4, 5].my_any? { |i| i < 2 }).to be true
      expect([1, 2, 3, 4, 5].my_any? { |i| i > 10 }).to be false
    end

    context 'when no block or argument is given' do
      it 'returns true if at least one of the collection is not false or nil' do
        expect([nil, false, 3, 'hello'].my_any?).to be true
        expect([nil, false, nil, false].my_any?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if at least one of the collection is a member of such class' do
        expect([nil, false, 3, 'hello'].my_any?(Integer)).to be true
        expect(%w[dog door rod blade].my_any?(Integer)).to be false
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns false if none of the collection matches the Regex' do
        expect([nil, false, 3, 'hello'].my_any?(/d/)).to be false
        expect(%w[dog door rod blade].my_any?(/d/)).to be true
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns false if none of the collection matches the pattern' do
        expect([nil, false, 8, 'hello'].my_any?(3)).to be false
        expect([nil, false, 3, 'hello'].my_any?(3)).to be true
      end
    end
  end

  describe '#my_none?' do
    it 'returns true if the block never returns true for all elements' do
      expect([1, 2, 3, 4, 5].my_none? { |i| i < 0 }).to be true
      expect([1, 2, 3, 4, 5].my_none? { |i| i < 2 }).to be false
    end

    context 'when no block or argument is given' do
      it 'returns true only if none of the collection members is true' do
        expect([nil, false, nil, false].my_none?).to be true
        expect([nil, false, true, false].my_none?).to be false
      end
    end

    context 'when a class is passed as an argument' do
      it 'returns true if none of the collection is a member of such class' do
        expect([nil, false, 3, []].my_none?(String)).to be true
        expect([nil, 'hi', 3, []].my_none?(String)).to be false
      end
    end

    context 'when a Regex is passed as an argument' do
      it 'returns true only if none of the collection matches the Regex' do
        expect([nil, false, 3, 'hi'].my_none?(/o/)).to be true
        expect([nil, 'oh', 3, 'hi'].my_none?(/o/)).to be false
      end
    end

    context 'when a pattern other than Regex or a Class is given' do
      it 'returns true only if none of the collection matches the pattern' do
        expect([nil, false, 8, 'hello'].my_none?(3)).to be true
        expect([nil, false, 3, 'hello'].my_none?(3)).to be false
      end
    end
  end

  describe '#my_count' do
    it 'returns the number of items in enum through enumeration' do
      actual = [2, 4, 5, 6].my_count
      expect(actual).to eq 4
    end

    context 'when an argument is given' do
      it 'counts the number of items in enum that are equal to argument given' do
        actual = [2, 4, 5, 6].my_count(4)
        expect(actual).to eq 1
      end
    end

    context 'when a block is given' do
      it 'counts the number of elements yielding a true value' do
        actual = [2, 4, 5, 6].my_count(&:even?)
        expect(actual).to eq 3
      end
    end
  end

  describe '#my_map' do
    it 'returns a new array with the results of running block once for every element' do
      expected = [2, 4, 6, 8, 10]
      actual = [1, 2, 3, 4, 5].my_map { |i| i * 2 }
      expect(actual).to eq expected
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_map).to be_an(Enumerator)
    end
  end

  describe '#my_inject' do
    it 'combines all elements of enum by applying a binary operation,' do
      actual = (5..10).my_inject { |sum, n| sum + n }
      expect(actual).to eq 45
      expect((5..10).my_inject(1) { |product, n| product * n }).to eq 151_200
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eq 'sheep'
    end

    context 'when a symbol is specified' do
      it 'combines each element of the collection by applying the symbol as a named method' do
        expect((5..10).my_inject(:+)).to eq 45
        expect((5..10).my_inject(1, :*)).to eq 151_200
      end
    end
  end

  describe '#multiply_els' do
    it 'multiplies all the elements of the array together' do
      actual = multiply_els [1, 2, 3, 4, 5]
      expect(actual).to eq 120
    end
  end
end
