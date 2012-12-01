require 'spec_helper'
require 'reader'

module Apfel
  describe Reader do
    describe '.read' do
      let(:temp_file) do
        create_temp_file(<<-EOS
This is a file with some lines.
Roses are red, violets are blue.
This text is really boring,
and so are you!
        EOS
        )
      end

      it 'reads a file a returns an array of its output' do
        Reader.read(temp_file).should eq([
        "This is a file with some lines.",
        "Roses are red, violets are blue.",
        "This text is really boring,",
        "and so are you!"
        ])
      end
    end
  end
end
