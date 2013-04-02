require 'tempfile'
require 'json'

def create_temp_file(encoding, string)
  temp_file = Tempfile.new('temp', encoding => encoding)
  temp_file << string
  temp_file.flush
end

def valid_file(encoding='ascii')
  create_temp_file(encoding, <<-EOS
/* This is the first comment */
"key_number_one" = "value number one";

/* This is
a

multiline comment */
"key_number_two"   =   "value number two";
/* This is comment number 3 */
"key_number_three" = " value number three ";
  EOS
  )
end
