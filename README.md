# destroy_backgrounded

Backgrounded Destroy ActiveRecord instances.

## Usage

```ruby
class Blog < ActiveRecord::Base
  acts_as_destroy_backgrounded
end
blog = Blog.create! :name => 'foo'

# backgrounded destroy the instance
blog.destroy

# immediately destroy the instance
blog.destroy_immediate

```

## Features
* simple configuration
* support for immediately destroying

## Contributing

* Fork the project
* Add tests
* Fix the issue
* Submit a pull request on github

see CONTRIBUTORS.txt for complete list of contributors

## Copyright

Copyright (c) 2011 Socialcast Inc. 
See LICENSE.txt for further details.

