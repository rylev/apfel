module Apfel
  # Class for reading in files and returning an array of its content
  class Reader
    # Reads in a file and returns an array consisting of each line of input
    # cleaned of new line characters
    def self.read(file)
      File.open(file, 'r') do |f|
        content_array=[]
        # http://stackoverflow.com/questions/5011504/is-there-a-way-to-remove-the-bom-from-a-utf-8-encoded-file
        # problem is the BOM that can be found at char 0 in strings files
        content = f.read.force_encoding('UTF-8')
        content.sub!("\xEF\xBB\xBF".force_encoding("UTF-8"), '')
        content.each_line do |line|
          line.gsub!("\n","")
          content_array.push(line)
        end
        content_array
      end
    end
  end
end
