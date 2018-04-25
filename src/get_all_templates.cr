path = "#{__DIR__}/templates/**/*.ecr"
Dir.glob(path) do |child|
  puts child
end
