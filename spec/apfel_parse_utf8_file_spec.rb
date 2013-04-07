require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given a UTF8 .strings file'do

      let(:utf8_file) do
        './spec/fixtures/utf8.strings'
      end

      it 'the file should be utf-8' do
        # use unix file instead of File.open because
        # File.open(file, 'r') <==> File.open(file, 'r:UTF-8')
        file_info = `file  -I #{utf8_file}`
        file_info.should include('charset=utf-8')
      end

      it 'the file should have the BOM as the 0 char' do
        File.open(utf8_file, 'r') do |f|
          content = f.read.force_encoding('UTF-8')
          content.chars.first == "\xEF\xBB\xBF".force_encoding('UTF-8')
        end
      end

      let(:parsed_file) do
        Apfel.parse(utf8_file)
      end

      it 'returns a ParsedDotStrings object' do
        parsed_file.should be_a(Apfel::ParsedDotStrings)
      end

      it 'should have the correct keys' do
        parsed_file.keys[0].should == 'anger'
        parsed_file.keys[1].should == 'anxiety'
        parsed_file.keys[2].should == 'boredom'
      end

      it 'should have the correct values' do
        parsed_file.values[0].should == 'Zorn'
        parsed_file.values[1].should == 'Sorge'
        parsed_file.values[2].should == 'Langeweile'
      end

      describe 'should have the correct comments' do
        it 'should have the correct comment for anger' do
          parsed_file.comments['anger'].should ==  'when the toast falls butter-side down'
        end

        it 'should have the correct comment for anxiety' do
          parsed_file.comments['anxiety'].should == 'when you realize you left the oven on'
        end

        it 'should have the correct comment for boredom' do
          parsed_file.comments['boredom'].should == 'ennui'
        end
      end
    end
  end
end
