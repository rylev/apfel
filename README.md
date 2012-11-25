# Apfel

## Introduction

Apfel is simple parser for .strings (DotStrings) files written in Ruby. DotStrings files are used by Apple platforms for localization. Apfel reads DotStrings files, parses them for key-value pairs and comments, and then converts the dot strings file to a hash.

Once in the form of a hash, the content of the DotStrings file can easily be
rebuilt as JSON (using the built in Hash.to_json method), XML and RESX
(with the help of Builder https://github.com/jimweirich/builder) and more!

## Use

TO-DO

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
