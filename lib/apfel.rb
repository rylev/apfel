# encoding: UTF-8

module Apfel
require 'apfel/reader'
require 'apfel/dot_strings_parser'
  # Public module for parsing DotStrings files and returning a parsed dot
  # strings object
  def self.parse(file)
    file = read(file)
    # confirmed that read does remove the first comment in utf
    DotStringsParser.new(file).parse_file
  end

  def self.read(file)
    # confirmed that read does remove the first comment in utf
    Reader.read(file)
  end
end
