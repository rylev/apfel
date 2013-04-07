# encoding: UTF-8

module Apfel
require 'apfel/reader'
require 'apfel/dot_strings_parser'
  # Public module for parsing DotStrings files and returning a parsed dot
  # strings object
  def self.parse(file)
    file = read(file)
    DotStringsParser.new(file).parse_file
  end

  def self.read(file)
    Reader.read(file)
  end
end
