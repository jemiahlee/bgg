bgg gem [![Build Status](https://travis-ci.org/jemiahlee/bgg.svg)](https://travis-ci.org/jemiahlee/bgg) [![Code Climate](https://codeclimate.com/github/jemiahlee/bgg.png)](https://codeclimate.com/github/jemiahlee/bgg)
===========

An object-oriented API for interacting with the [boardgamegeek](http://boardgamegeek.com) [XML Version 2 API](http://boardgamegeek.com/wiki/page/BGG_XML_API2).

This is based on a fork of earlier work I had done on
[bgg-api](http://github.com/bhardin/bgg-api), along with Brett and a few
other contributors.

## Versions supported

Please note that this code uses Ruby 1.9 hash syntax and thus does not
support versions earlier than that.

## Installing the Gem

Do the following to install the  [bgg gem](http://rubygems.org/gems/bgg) Ruby Gem.

Add the following to your `Gemfile`:

```ruby
gem "bgg"
```

Then run `bundle install` from the command line:

    bundle install

## Using the Gem

Require the gem at the top of any file you want to use.

    require 'bgg'

You can either use the low level basic api and then parse the XML document in a way that suits your needs,
or you can use the specialized methods

There are object types and subtypes for many of the APIs documented at
[BGG_XML_API2](http://boardgamegeek.com/wiki/page/BGG_XML_API2), but not all of them are implemented.
Everything around a user and their game collection should work, as well
as generalized searching for board games.

### Requesting data
There are a few ways you can request data as outlined below.

#### Simple requests
The base object can be called to get a default set of parameters for the
given api command.

```ruby
BggRequest.collection 'username'
BggRequest.hot
BggRequest.search 'query'
```

Of course you can always pass along additional parameters if you hunt
them down from the api.

```ruby
BggRequest.collection('username', { brief: 1 })
BggRequest.hot({ type: 'boardgame' })
BggRequest.search('query', { exact: 1 })
```

#### Predefined requests
These are here to make it so you do not need to know the bgg xml api.
To get the same as above.

```ruby
Bgg::Request::Collection.board_games('username').brief.get
Bgg::Request::Hot.board_games.get
Bgg::Request::Search.board_games('query').exact.get
```

#### The long way
If you would like to pass around the request objects, this is a longer method to do so.

```ruby
my_request = Bgg::Request::Collection.new('username')
my_request.add_params({ rated: 1 })
my_collection = my_request.brief.get
```

### Working with results
Each api method has it's own data structure, although there is some
common themes.

Most results return an enumerated object.
```ruby
my_collection.count
my_hot.first
my_search.map { |item| item.id }
```
The enumerable could possibly have its own set of methods.
```ruby
my_collection.played
my_search.board_games
```
The objects inside the enumerable are unique to the api method.
```ruby
my_collection.first.user_rating
my_search.first.type
```
XML is always available
```ruby
my_collection.xml.xpath('items/item')
my_search.first.xml.at_xpath('@objectid')
```

Contributing to bgg
-----------------------

* Fork the project
* Start a feature/bugfix branch
* Test whatever you are committing. Ensure this test is a specification
  of the behavior of the functionality, not just an error case or
  success case.
* Commit and push until you are happy with your contribution
* Submit a pull request. Squash commits that should be squashed (it is
  not necessary for you to have just one commit to your pull request,
  but have each commit be a logical piece of work.)

Copyright
---------

Copyright (c) 2014 [Kevin Craine](https://github.com/craineum), [Jeremiah Lee](https://github.com/jemiahlee), [Brett Hardin](http://bretthard.in), and [Marcello Missiroli](https://github.com/piffy). See LICENSE.txt for further details.

