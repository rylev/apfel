require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given a UTF8 DotStrings file'do

      let(:parsed_file) do
        Apfel.parse(valid_file 'utf-8')
      end

      it 'returns a ParsedDotStrings object' do
        parsed_file.should be_a(Apfel::ParsedDotStrings)
      end

      it 'should have the correct keys' do
        parsed_file.keys.should include 'key_number_one'
        parsed_file.keys.should include 'key_number_two'
        parsed_file.keys.should include 'key_number_three'
      end

      it 'should have the correct values' do
        parsed_file.values.should include 'value number one'
        parsed_file.values.should include 'value number two'
        parsed_file.values.should include 'value number three'
      end

      describe 'should have the correct comments' do
        it 'should have the correct comment for first' do
          parsed_file.comments(with_keys: false).should include 'This is the first comment'
        end

        it 'should have the correct comment for second' do
          parsed_file.comments['key_number_two'].should == 'This is a multiline comment'
        end


        it 'should have the correct comment for third' do
          parsed_file.comments(with_keys: false).should include 'This is comment number 3'
        end
      end
    end
  end
end
