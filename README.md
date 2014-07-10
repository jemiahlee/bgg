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

### Example

Most of the documentation right now is in the specs. I will work on
beefing this section up shortly.

```ruby
texasjdl = Bgg::User.find_by_id(39488)
texasjdl.collection.played.each do |item|
  puts "#{item.name} is #{item.owned? ? '' : 'not'} owned."
end
```


### Search

Objects for search

#### Bgg::Request::Search

```ruby
request = Bgg::Request::Search.board_games('query', { params: hash })
request = Bgg::Request::Search.board_game_expansions('query', { params: hash })
request = Bgg::Request::Search.rpg_issues('query', { params: hash })
request = Bgg::Request::Search.rpg_items('query', { params: hash })
request = Bgg::Request::Search.rpg_periodicals('query', { params: hash })
request = Bgg::Request::Search.rpgs('query', { params: hash })
request = Bgg::Request::Search.video_games('query', { params: hash })
request.exact # Adds params to the bgg call that will request an exact match only, returns self
request.add_params( { params: to_add } ) # Adds params to the bgg call
result = request.get # Execute bgg call and return result
```

#### Bgg::Result::Search

* Methods
  * Select item type from result set:  board_games, board_game_expansions, rpg_issues, rpg_items, rpg_periodicals, rpgs, video_games

#### Bgg::Result::Search::Item

* Attributes
  * Integers: id, year_published
  * Stings: name, type
* Methods
  * game, request game based on id


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

Copyright (c) 2014 [Jeremiah Lee](https://github.com/jemiahlee), [Brett Hardin](http://bretthard.in), and [Marcello Missiroli](https://github.com/piffy). See LICENSE.txt for further details.

