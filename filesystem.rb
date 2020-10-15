require 'pry'

path = ARGV[0]

p 'Error goes here' unless File.directory? path

class FileSystem
  attr_reader :output
  
  def initialize(starting_path)
    @starting_path = starting_path
    @output = []
  end

  def explore_path(path = @starting_path, output = [])
    directory = Dir.new(path)

    directory.each do |file_name| 
      working_path = "#{path}/#{file_name}"
    
      if file_name == '.' || file_name == '..'
        next
      elsif File.file?(working_path)
        output.push({ file_name: file_name, file_path: working_path, file_size: File.size(working_path) })
      else
        explore_path(working_path, output)
      end
    end

    return output
  end
end

y = FileSystem.new(path)
p y.explore_path
p y.explore_path.count

# p y.output