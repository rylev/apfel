require 'spec_helper'
require 'apfel'
require 'tempfile'

module Apfel
  describe Reader do
    describe '.read' do
      it 'reads a file a returns an array of its output' do
        temp_file = create_temp_file(<<-EOS
This is a file with some lines.
Roses are red, violets are blue.
This text is really boring,
and so are you!
        EOS
                        )
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
    describe '#parse_file' do
      context 'when given a valid DotStrings file'do
        let(:valid_file) do
         create_temp_file(<<-EOS
/* This is the first comment */
"key_number_one" = "value number one";

/* This is
a
multiline comment */
"key_number_two"   =   "value number two";
/* This is comment number 3 */
"key_number_3" = " value number three "
            EOS
          )
        end

        let(:parsed_file) do
          DotStrings.parse_file(valid_file)
        end

        it 'returns a ParsedDotStrings object' do
          parsed_file.should be_a(ParsedDotStrings)
        end

      end

      context 'when given an invalid strings file' do
        context 'missing a semicolon' do

          let(:invalid_file_semicolon) do
            create_temp_file(  <<-EOS
  /* This is the first comment */
  "key_number_one" = "value number one"
              EOS
            )
          end

          it 'returns an error' do
            expect {
              DotStrings.parse_file(invalid_file_semicolon)
            }.to raise_error
          end
        end

        context 'not closed comment' do
          let(:invalid_file_comment) do
            create_temp_file(<<-EOS
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
              DotStrings.parse_file(invalid_file_semicolon)
            }.to raise_error
          end
        end
      end
    end
  end

  describe ParsedDotStrings do

        it 'returns the right comments' do
          parsed_file.comments.should eq(
            ["This is the first comment",
             "This is a multiline comment",
             "This is comment number 3"]
          )
        end
  end
end
