require 'spec_helper'
require 'apfel'

describe Apfel do
  describe '::parse_file' do
    context 'when given DotStrings file with escapes'do
      let(:parsed_file_hash) do
        Apfel.parse('./spec/files/escapes.strings').to_hash(:with_comments => false)
      end

      it 'should parse nl' do
        parsed_file_hash['multiline'].should eq "line 1\nline 2"
      end

      it 'should parse cr' do
        parsed_file_hash['mac'].should eq "before cr\rafter cr"
      end

      it 'should parse tabs' do
        parsed_file_hash['tabs'].should eq "two spaces \t equals tab"
      end

      it 'should parse double quotes' do
        parsed_file_hash['dq'].should eq "\"someone said this\""
      end

      it 'should parse backslashes' do
        parsed_file_hash['backslash'].should eq "\\not a forward slash"
      end
    end
  end
end
