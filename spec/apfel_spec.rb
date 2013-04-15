require 'spec_helper'
require 'apfel'
require 'apfel/parsed_dot_strings'

describe Apfel do
  describe '::parse_file' do
    context 'when given an ASCII DotStrings file'do

      let(:parsed_file) do
        Apfel.parse(valid_file)
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

    context 'when given an invalid strings file' do
      context 'missing a semicolon' do

        let(:invalid_file_semicolon) do
          create_temp_file('ascii',  <<-EOS
/* This is the first comment */
"key_number_one" = "value number one"
          EOS
          )
        end

        it 'returns an error' do
          expect {
            Apfel.parse(invalid_file_semicolon)
          }.to raise_error
        end
      end

      context 'not closed comment' do
        let(:invalid_file_comment) do
          create_temp_file('ascii', <<-EOS
/* This is the first comment
"key_number_one" = "value number one";

/* This is
a
multiline comment */
        end
          EOS
          )
        end

        it 'raises an error' do
          expect {
            Apfel.parse(invalid_file_semicolon)
          }.to raise_error
        end
      end
    end

    context 'when given a file in us-ascii encoding'do

      let(:ascii_file) do
        './spec/fixtures/ascii.strings'
      end
      it 'the file should be ascii' do

        # use unix file instead of File.open because
        # File.open(file, 'r') <==> File.open(file, 'r:UTF-8')
        file_info = `file  -I #{ascii_file}`
        file_info.should include('charset=us-ascii')
      end

      let(:parsed_file) do
        Apfel.parse(ascii_file)
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
