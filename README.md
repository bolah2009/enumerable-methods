[![Maintainability](https://api.codeclimate.com/v1/badges/47dde54b3f4fddb0b16e/maintainability)](https://codeclimate.com/github/bolah2009/enumerable-methods/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/47dde54b3f4fddb0b16e/test_coverage)](https://codeclimate.com/github/bolah2009/enumerable-methods/test_coverage) [![Build](https://travis-ci.org/bolah2009/enumerable-methods.svg?branch=master)](https://travis-ci.org/bolah2009/enumerable-methods)

# Project 2 & 3: Enumerable Methods in Ruby and testing with RSpec

## PROJECT: ADVANCED BUILDING BLOCKS (Project 2: Enumerable Methods and Testing

This is the second project of the main `Ruby` curriculum at [Microverse](https://www.microverse.org/) - @microverseinc

### [Assignment link](https://www.theodinproject.com/courses/ruby-programming/lessons/advanced-building-blocks)

#### The objective is to add new methods onto the existing [Ruby Enumerable module](https://ruby-doc.org/core-2.6.4/Enumerable.html). Such methods are as follows

1. Create `#my_each`, a method that is identical to #each
2. Create `#my_each_with_index` in the same way.
3. Create `#my_select` in the same way, though you may use #my_each in your definition (but not #each).
4. Create `#my_all?` (continue as above)
5. Create `#my_any?`
6. Create `#my_none?`
7. Create `#my_count`
8. Create `#my_map`
9. Create `#my_inject`
10. Test your `#my_inject` by creating a method called `#multiply_els` which multiplies all the elements of the array together by using `#my_inject`, e.g. `multiply_els([2,4,5]) #=> 40`

### Write tests for the enumerable methods using rspec

Test Results:

```bash
$ rspec

enumerables
  #my_each
    calls the given block once for each element in self
    returns an Enumerator if no block is given
  #my_each_with_index
    calls the given block once for each element in self
    returns an enumerator if no block is given
  #my_select
    returns an array containing all elements of enum for which the given block returns a true value
    returns an enumerator if no block is given
  #my_all?
    returns true if the block never returns false or nil
    when no block or argument is given
      returns true when none of the collection members are false or nil
    when a class is passed as an argument
      returns true if all of the collection is a member of such class
    when a Regex is passed as an argument
      returns true if all of the collection matches the Regex
    when a pattern other than Regex or a Class is given
      returns true if all of the collection matches the pattern
  #my_any?
    returns true if the block ever returns a value other than false or nil
    when no block or argument is given
      returns true if at least one of the collection is not false or nil
    when a class is passed as an argument
      returns true if at least one of the collection is a member of such class
    when a Regex is passed as an argument
      returns false if none of the collection matches the Regex
    when a pattern other than Regex or a Class is given
      returns false if none of the collection matches the pattern
  #my_none?
    returns true if the block never returns true for all elements
    when no block or argument is given
      returns true only if none of the collection members is true
    when a class is passed as an argument
      returns true if none of the collection is a member of such class
    when a Regex is passed as an argument
      returns true only if none of the collection matches the Regex
    when a pattern other than Regex or a Class is given
      returns true only if none of the collection matches the pattern
  #my_count
    returns the number of items in enum through enumeration
    counts the number of items in enum that are equal to item if an argument is given
    counts the number of elements yielding a true value if a block is given
  #my_map
    returns a new array with the results of running block once for every element in enum.
    returns an Enumerator if no block is given
  #my_inject
    combines all elements of enum by applying a binary operation, specified by a block
    when a symbol is specified
      combines each element of the collection by applying the symbol as a named method
  #multiply_els
    multiplies all the elements of the array together

Finished in 0.00825 seconds (files took 0.16168 seconds to load)
29 examples, 0 failures


COVERAGE: 100.00% -- 220/220 lines in 2 files

```

#### Contact

- [Web](https://bolabuari.com/) - [Twitter](https://twitter.com/bolah2009) - [GitHub](https://github.com/bolah2009/) - [GitLab](https://gitlab.com/bolah2009/) - [LinkedIn](https://www.linkedin.com/in/bolah2009/)
