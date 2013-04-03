require 'tempfile'
require 'json'

# added encoding to see if could could reproduce the missing  first comment in
# utf8 strings files - did not reproduce the problem
# SOLVED: it was the BOM at char 0 in the strings file
def create_temp_file(encoding, string)
  temp_file = Tempfile.new([encoding, 'temp'])
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
