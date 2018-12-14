# GpsExtractor
A command line utility that finds all JPEGs inside of a folder
recursively and extracts their EXIF GPS data if present. It will default to
scanning the pwd unless a directory is provided as an argument.

Results are written to a file in the pwd as the scan runs. CSV files will be
produced by default, use -html for HTML files instead. If the app is not
installed as a gem, the HTML output requires configuration when being called
from outside the app folder.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gps_extractor'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gps_extractor

### SYNOPSIS

Usage: gps_extractor.rb [options] [/target/folder/path]


## Usage
```
 ruby lib/gps_extractor.rb
 ruby lib/gps_extractor.rb -v
 ruby lib/gps_extractor.rb /home
 ruby lib/gps_extractor.rb -html /home
```

### OPTIONS

--help        - provide brief help notice

-html         - outputs an HTML document rather than a CSV

-v, --verbose - outputs additional information as the script runs

### OUTPUT

The output file is created in the pwd/tmp, which requires write permission.

`{folder_name}_{timestamp}.{csv|html}`

### BUGS

Circular symbolic links are not handled

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aashishsaini/gps_extractor. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GpsExtractor project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/gps_extractor/blob/master/CODE_OF_CONDUCT.md).
