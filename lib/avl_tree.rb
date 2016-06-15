valid_files = Dir["#{File.dirname(__FILE__)}/**/*"].reject {|f| File.directory?(f) }
valid_files.each { |f| require f }

module AvlTree
  # Your code goes here...
end
