module Apfel
  # Class for reading in files and returning an array of its content
  class Reader
    # Reads in a file and returns an array consisting of each line of input
    # cleaned of new line characters
    def self.read(file)
      File.open(file, "r") do |f|
      content_array=[]
      content = f.read
        content.each_line do |line|
          line.gsub!("\n","")
          content_array.push(line)
        end
        content_array
      end
    end
  end
end
