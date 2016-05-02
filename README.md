# AnalyZ

This is gem for text analyze.
Now you can analyze hse-tf-idf value about each words.

## What is hse-tf-idf

hse-tf-idf = hse * tf-idf

### What is hse

Hse is HTML Semantic Element (valuation).
Evaluate HTML tag and express it's value in number.

for example

| tag name   | font-size   | font-weight  | valuation  |
|:----------:|:-----------:|:------------:|:----------:|
| h1         | 2           | 1.75         | 3.5        |
| h2         | 1.5         | 1.75         | 2.625      |
| h3         | 1.17        | 1.75         | 2.0475     |
| h4         | 1           | 1.75         | 1.75       |

`valuation = font-size * font-weight`

And I'm looking for another valuation.
Please tell me if you find out more good tag or style.

I want to add hse valuation logic below,
- font size by css
- font color

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'analy_z'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install analy_z


## Usage

```ruby
require 'analy_z'

# file_path : file path for files you want to analyze
#             for example 'html/*.html'
#             NOTE please add more than 2 files
#             because only 1 file, analy_z can't calucurate idf
# selector  : selector for place you want to analyze
#             for example '#main .content'

a = AnalyZ::HTML.word_val(file_path, selector)

a.tf          # tf
a.idf         # idf
a.tf_idf      # tf-idf
a.hse_tf_idf  # hse-tf-idf
a.words       # words analy_z analyzed
a.texts       # texts analy_z analyzed
a.sentences   # sentences analy_z analyzed

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/nao215/analy_z/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
