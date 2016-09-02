# Functional Operations

This gem provides a simple framework for creating Operations that encapsulate
business logic generally found in Models (or hooks).

## Installation

Add this line to your application's Gemfile:

```ruby
gem "functional_operations"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install functional_operations

## Usage

Here is a simple RegisterUser operation that demonstrates most of the functionality
of this gem:

```ruby
class RegisterUser < FunctionalOperations::Operation
    def validate
        required :name, String
        optional :email, String
    end

    def perform
        user = User.create!(name: params[:name], email: params[:email])
        user.save!
        # send e-mail to user or other logic that usually goes into after hooks
        user
    end
end
```

Then call the operation:

```ruby
user = RegisterUser.new.call(name: "John")
```

Or include `FunctionalOperations::DSL` and use:
```ruby
run RegisterUser, name: "John"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/juanibiapina/functional_operations. This project is intended
to be a safe, welcoming space for collaboration, and contributors are expected
to adhere to the [Contributor Covenant](http://contributor-covenant.org) code
of conduct.


## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).

