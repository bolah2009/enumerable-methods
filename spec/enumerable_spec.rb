require './enumerable'

describe Enumerable do
  context '#each' do
    it 'calls the given block once for each element' do
      expect([1, 2, 3, 4].my_each { |i| i }).to eq [1, 2, 3, 4]
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each.class).to eq Enumerator
    end
  end

  context '#my_each_with_index' do
    it 'calls block with two arguments, the item and its index' do
      hash_with_two_arguments = {}
      [1, 2, 3, 4].my_each_with_index do |value, index|
        hash_with_two_arguments[index] = value
      end
      expect(hash_with_two_arguments[0]).to eq 1
    end

    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_each_with_index.class).to eq Enumerator
    end
  end

  context '#my_select' do
    it 'returns an array containing all elements for which the given block returns a true value.' do
      actual = [2, 3, 4, 5, 6, 7].my_select(&:even?)
      expected = [2, 4, 6]
      expect(actual).to eq expected
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_select.class).to eq Enumerator
    end
  end

  context '#my_all?' do
    it 'passes each element of the collection to the given block' do
      expected = []
      actual = [2, 4, 5, 6]
      actual.my_all? { |i| expected << i }
      expect(actual).to eq expected
    end

    it 'returns true if the block never returns false or nil' do
      expect([1, 2, 3, 4, 5].my_all? { |i| i < 10 }).to be true
    end

    context 'when no block is given' do
      it 'return true when none of the collection members are false or nil ' do
        expect([0, true, 3, 'hello'].my_all?).to be true
      end
    end
  end

  context '#my_any?' do
    it 'returns true if the block ever returns a value other than false or nil' do
      expect([1, 2, 3, 4, 5].my_any? { |i| i < 2 }).to be true
    end

    context 'when no block is given' do
      it 'return true if at least one of the collection is not false or nil' do
        expect([nil, false, 3, 'hello'].my_any?).to be true
      end
    end
  end

  context '#my_none?' do
    it 'returns true if the block never returns true for all elements' do
      expect([1, 2, 3, 4, 5].my_none? { |i| i < 0 }).to be true
    end

    context 'when no block is given' do
      it 'return true only if none of the collection members is true' do
        expect([nil, false, nil, false].my_none?).to be true
      end
    end
  end

  context '#my_count' do
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

  context '#my_map' do
    it 'returns a new array with the results of running block once for every element' do
      expected = [2, 4, 6, 8, 10]
      actual = [1, 2, 3, 4, 5].my_map { |i| i * 2 }
      expect(actual).to eq expected
    end

    it 'returns an Enumerator if no block is given' do
      expect([1, 2, 3, 4].my_map.class).to eq Enumerator
    end
  end

  context '#my_inject' do
    it 'combines all elements of enum by applying a binary operation,' do
      actual = (5..10).my_inject { |sum, n| sum + n }
      expect(actual).to eq 45
    end
  end

  context '#multiply_els' do
    it 'multiplies all the elements of the array together' do
      actual = multiply_els [1, 2, 3, 4, 5]
      expect(actual).to eq 120
    end
  end
end
