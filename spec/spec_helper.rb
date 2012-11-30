def create_temp_file(string)
  temp_file = Tempfile.new('temp')
  temp_file << string
  temp_file.flush
end
