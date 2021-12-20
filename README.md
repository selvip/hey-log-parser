# Hey::Log::Parser

Welcome to Hey Log Parser!

This is a Ruby app which intended to help parsing a web log file and to sort it based on popularity.

The input should be a file like this:
```
/about 184.123.665.067
/about 184.123.665.060
/contact 836.973.694.403
...
```

And the output should go like this:
```
/about 29, /contact 18, ...
```

And now we can see which path is visited the most :)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hey-log-parser'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hey-log-parser

## Usage

1. Prepare your log file in this format:
```
/about 184.123.665.067
/contact 836.973.694.403
```
2. Put it inside directory `config` using file name `webserver.log`
3. Then run `rake test` to run the tests.
4. To start parsing, run `bin/start` on the terminal.
5. Once the result is ready, you can open `config/result` and `config/unique_result`
6. You can also see `config/result.html` to view result using HTML table format.
7. If there is any errors, you can find `config/error_result` 

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/selvip/hey-log-parser. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/selvip/hey-log-parser/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hey::Log::Parser project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/selvip/hey-log-parser/blob/master/CODE_OF_CONDUCT.md).
