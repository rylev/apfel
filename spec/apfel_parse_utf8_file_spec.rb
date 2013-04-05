require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given a UTF8 DotStrings file'do

      it 'the file should be utf-8' do
        File.open('./spec/files/utf8.strings', 'r') do |f|
          f.external_encoding.name.should == 'UTF-8'
          content = f.read
          content.encoding.name.should == 'UTF-8'
        end
      end

      let(:parsed_file) do
        Apfel.parse('./spec/files/utf8.strings')
      end

      it 'returns a ParsedDotStrings object' do
        parsed_file.should be_a(Apfel::ParsedDotStrings)
      end

      #it 'should have the correct keys' do
      #  parsed_file.keys.should include 'key_number_one'
      #  parsed_file.keys.should include 'key_number_two'
      #  parsed_file.keys.should include 'key_number_three'
      #end
      #
      #it 'should have the correct values' do
      #  parsed_file.values.should include 'value number one'
      #  parsed_file.values.should include 'value number two'
      #  parsed_file.values.should include 'value number three'
      #end
      #
      describe 'should have the correct comments' do
        it 'should have the correct comment for anger' do
          parsed_file.comments['anger'].should == 'No comment provided by engineer.'
        end

        it 'should have the correct comment for anxiety' do
          parsed_file.comments['anxiety'].should == 'No comment provided by engineer.'
        end

        it 'should have the correct comment for boredom' do
          parsed_file.comments['boredom'].should == 'No comment provided by engineer.'
        end
      end

    end
  end
end
