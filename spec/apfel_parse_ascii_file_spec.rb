require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given a ASCII DotStrings file'do

      it 'the file should be ascii' do

        # use unix file instead of File.open because
        # File.open(file, 'r') <==> File.open(file, 'r:UTF-8')
        file_info = `file  -I ./spec/fixtures/ascii.strings`
        file_info.should include('charset=us-ascii')
      end

      let(:parsed_file) do
        Apfel.parse('./spec/fixtures/ascii.strings')
      end

      it 'returns a ParsedDotStrings object' do
        parsed_file.should be_a(Apfel::ParsedDotStrings)
      end

      it 'should have the correct keys' do
        parsed_file.keys[0].should == 'avoided social event'
        parsed_file.keys[1].should == 'binged'
        parsed_file.keys[2].should == 'called a friend'
      end

      it 'should have the correct values' do
        parsed_file.values[0].should == 'vermieden soziales Ereignis'
        parsed_file.values[1].should == 'gegessen exzessiv'
        parsed_file.values[2].should == 'Telefon ein Freund'
      end

      describe 'should have the correct comments' do
        it 'should have the correct comment for avoided social event' do
          parsed_file.comments['avoided social event'].should == 'like a hack-a-thon'
        end

        it 'should have the correct comment for binged' do
          parsed_file.comments['binged'].should == 'one too many lieb kochen'
        end

        it 'should have the correct comment for called a friend' do
          parsed_file.comments['called a friend'].should == 'or maybe you just skyped'
        end
      end
    end
  end
end
