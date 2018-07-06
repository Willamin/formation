path = "#{__DIR__}/templates/**/*.ecr"
Dir.glob(path, match_hidden: true) do |child|
  puts child
end
