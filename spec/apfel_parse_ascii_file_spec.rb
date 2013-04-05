require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given a ASCII DotStrings file'do

      it 'the file should be ascii' do
        res = `file  -I ./spec/files/ascii.strings`
        encoding = res.split(/=/).last.gsub!("\n",'')
        encoding.should == 'us-ascii'
      end

      let(:parsed_file) do
        Apfel.parse('./spec/files/ascii.strings')
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
        it 'should have the correct comment for avoided social event' do
          parsed_file.comments['avoided social event'].should == 'No comment provided by engineer.'
        end

        it 'should have the correct comment for binged' do
          parsed_file.comments['binged'].should == 'No comment provided by engineer.'
        end

        it 'should have the correct comment for called a friend' do
          parsed_file.comments['called a friend'].should == 'No comment provided by engineer.'
        end
      end
    end
  end
end
