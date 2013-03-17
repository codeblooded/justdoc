require '../output'

OutputSpecification.new do |osp|
  ops.name          = "markdown"
  ops.author        = ["Benjamin Reed", "benvreed@gmail.com"]
  ops.files         = ["markdown/*.md"]
  
  ops.add_dependency 'github-markdown', '>= 1.0'
end
3