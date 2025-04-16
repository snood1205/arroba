# Arroba

An unofficial client for ATProto.

## Installation

This gem has minimal dependencies, so it should install well as long as you have Ruby >= 3.4. To install it, add this line to your application's Gemfile:

```ruby
gem 'arroba'
```

or install it yourself as:

```bash
gem install arroba
```

## Usage

```ruby
require 'arroba'
identifier = 'example.com'
password = 'password'
# This assume you are using 'bsky.social' to auth. You can provide a different url with the auth_url: param.
client = Arroba::Client.new(identifier:, password:)
puts client.app.bsky.actor.get_preferences # => {'preferences' => ... }
client.chat.bsky.convo.send_message convo_id: 'not-a-real-convo', message: 'Ahoy hoy!'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/rspec` to run the specs. You can also run `bin/console` for an interactive prompt powered by [`pry`](https://github.com/pry/pry) that will allow you to experiment.

To install this gem onto your local machine, run `bin/rake install`. To release a new version, update the version number in `version.rb`, and then run `bin/rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/snood1205/arroba.
