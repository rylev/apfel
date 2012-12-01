require 'spec_helper'
require 'apfel'

module Apfel
  describe ParsedDotStrings do
    let(:parsed_file) do
      Apfel.parse(valid_file)
    end

    describe '#keys' do
      it 'returns an array of all the keys'do
        parsed_file.keys.should eq(
        ["key_number_one",
         "key_number_two",
         "key_number_three"]
        )
      end
    end

    describe '#values' do
      it 'returns an array of all the values'do
        parsed_file.values.should eq(
        ["value number one",
         "value number two",
         "value number three"]
        )
      end
    end

    describe '#comments' do
      context 'when :with_keys is passed as true' do
        it 'returns a hash of the comments mapped to their correct keys' do
          parsed_file.comments(with_keys: true).should eq(
            {"key_number_one" => "This is the first comment",
             "key_number_two" => "This is a multiline comment",
             "key_number_three" => "This is comment number 3"}
          )
        end
      end

      context 'when with_keys is passed as false' do
        it 'returns an array of just the comments' do
          parsed_file.comments(with_keys: false).should eq(
          ["This is the first comment",
           "This is a multiline comment",
           "This is comment number 3"]
          )
        end
      end

      it 'defaults to returning a hash' do
          parsed_file.comments.should be_a(Hash)
      end
    end

    describe '#key_values' do
      it 'returns an array of hashes of key and values' do
          parsed_file.key_values.should eq(
          [
            {"key_number_one" => "value number one"},
            {"key_number_two" => "value number two"},
            {"key_number_three" => "value number three"}
          ]
          )
      end
    end

    describe '#to_hash' do
     it 'returns a hash with the key = key, value = { value => comments }' do
      parsed_file.to_hash.should eq(
        {
          "key_number_one" => { "value number one" => "This is the first comment" },
          "key_number_two" => { "value number two" => "This is a multiline comment" },
          "key_number_three" => { "value number three" => "This is comment number 3" }
        }
      )
      end

      context 'when :no_comments is passed as true' do
        it 'returns a hash of just keys and values' do
          parsed_file.to_hash(no_comments: true).should eq(
            {
              "key_number_one" => "value number one",
              "key_number_two" => "value number two",
              "key_number_three" => "value number three"
            }
          )
        end
      end
    end
  end
end
