# Apfel

## Introduction

Apfel is simple parser for .strings (DotStrings) files written in Ruby. DotStrings files are used by Apple platforms for localization. Apfel reads DotStrings files, parses them for key-value pairs and comments, and then converts the dot strings file to a hash.

Once in the form of a hash, the content of the DotStrings file can easily be
rebuilt as JSON (using the built in Hash.to_json method), XML and RESX
(with the help of Builder https://github.com/jimweirich/builder) and more!

## Use

To start using Apfel first require the gem
```Ruby
require 'apfel'
```

Next, pass Apfel the .strings file you want to parse:
```Ruby
parsed_file = Apfel.parse('path/to/file')
```

Once the file has been parsed, you can do many things with it:
```Ruby
# Turn it into a ruby hash
parsed_file.to_hash

# Turn it into json
parsed_file.to_json

# Get all the keys as an array
parsed_file.keys

# Get all the values as an array
parsed_file.values

# Return an array of key-value hashes
parsed_file.key_values

# Return an array of key-comment hashes
parsed_file.comments

# Return an array of all the comments without their keys
parsed_file.comments(with_keys: false)
```
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Commit tests (they should pass when rake is run)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
