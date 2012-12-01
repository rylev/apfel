require 'spec_helper'
require 'apfel'

describe Apfel do
  describe '::parse_file' do
    context 'when given a valid DotStrings file'do

      let(:parsed_file) do
        Apfel.parse(valid_file)
      end

      it 'returns a ParsedDotStrings object' do
        parsed_file.should be_a(Apfel::ParsedDotStrings)
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
            Apfel.parse(invalid_file_semicolon)
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
            Apfel.parse(invalid_file_semicolon)
          }.to raise_error
        end
      end
    end
  end
end
