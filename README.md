[![Maintainability](https://api.codeclimate.com/v1/badges/47dde54b3f4fddb0b16e/maintainability)](https://codeclimate.com/github/bolah2009/enumerable-methods/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/47dde54b3f4fddb0b16e/test_coverage)](https://codeclimate.com/github/bolah2009/enumerable-methods/test_coverage) [![Build](https://travis-ci.org/bolah2009/enumerable-methods.svg?branch=master)](https://travis-ci.org/bolah2009/enumerable-methods)

## PROJECT: ADVANCED BUILDING BLOCKS (Enumerable Methods and Testing)

This is the second project of the main `Ruby` curriculum at [Microverse](https://www.microverse.org/) - @microverseinc.

### Objective

The objective is to add new custom methods onto the existing [Ruby Enumerable module](https://ruby-doc.org/core-2.6.4/Enumerable.html) and write a test for each using `RSpec`. Such methods are as follows

1. Create `#my_each`, a method that is identical to `#each`
2. Create `#my_each_with_index` in the same way.
3. Create `#my_select` in the same way, though you may use #my_each in your definition (but not #each).
4. Create `#my_all?` (continue as above)
5. Create `#my_any?`
6. Create `#my_none?`
7. Create `#my_count`
8. Create `#my_map`
9. Create `#my_inject`
10. Test your `#my_inject` by creating a method called `#multiply_els` which multiplies all the elements of the array together by using `#my_inject`, e.g. `multiply_els([2,4,5]) #=> 40`

## 🛠️ Development (Running locally)

- Clone the project

```bash
git clone https://github.com/bolah2009/enumerable-methods.git

```

Install Dependencies

```bash
bundle install
```

To run Rubocop by itself, you may run the lint task:

```bash
rubocop
```

Or to automatically fix issues found (where possible):

```bash
rubocop -a
```

## 🧾 TODO

- Improve existing methods
- Add more Enumerable Methods and Test

## 🤝🏾 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](../../issues).

## ⭐️ Show your support

Give a ⭐️ if you like this project!

## 🙏🏾 Acknowledgments

- Microverse Team

## 👨🏽‍💻 Author

- [Web](https://bolabuari.com/)
- [Twitter](https://twitter.com/bolah2009)
- [GitHub](https://github.com/bolah2009/)
- [GitLab](https://gitlab.com/bolah2009/)
- [LinkedIn](https://www.linkedin.com/in/bolah2009/)

## 📝 License

[MIT licensed](./LICENSE).
