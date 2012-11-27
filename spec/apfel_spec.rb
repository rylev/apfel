require 'spec_helper'
require 'apfel'
require 'tempfile'

module Apfel
  describe Reader do
    describe '.read' do
      it 'reads a file a returns an array of its output' do
        temp_file = Tempfile.new('temp')
        temp_file << <<-EOS
This is a file with some lines.
Roses are red, violets are blue.
This text is really boring,
and so are you!
        EOS
        temp_file.flush
        Reader.read(temp_file).should eq([
        "This is a file with some lines.\n",
        "Roses are red, violets are blue.\n",
        "This text is really boring,\n",
        "and so are you!\n"
        ])
      end
    end
  end

  describe DotStrings do
    let(:file) do
      content = <<-EOS
/* This is the first comment */
"key_number_one" = "value number one";

/* This is
a
multiline comment */
"key_number_two"   =   "value number two";
/* This is comment number 3 */
"key_number_3" = " value number three "
      EOS
      file = Tempfile.new('dotstrings')
      file << content
      file.flush
    end
    describe '#parse_file' do
      context 'when given a valid DotStrings file'do
        before(:all) do
          @parser = DotStrings.new(file)
        end
        it 'returns an array of KVPair objects' do
          @parser.parse_file.should respond_to(:each)
          @parser.parse_file.each{|s| puts s.inspect}
          @parser.parse_file.count.should eq(3)
        end
      end

      context 'when given an invalid strings file' do
      end
    end
  end
end
