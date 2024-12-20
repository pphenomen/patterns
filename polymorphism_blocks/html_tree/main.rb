require './html_tag.rb'
require './html_tree.rb'

html = "<div class='container'><p>Hello, world!</p><p>Another paragraph</p></div>"
html_tree = HtmlTree.new(html)

puts "HTML Tree:"
puts html_tree

puts "\nBFS:"
html_tree.bfs { |node| puts "Tag: #{node.tag_name}, Children: #{node.count_children}" }

puts "\nDFS:"
html_tree.dfs { |node| puts "Tag: #{node.tag_name}, Content: #{node.content}" }

puts "\nEach(DFS):"
html_tree.each { |node| puts "Tag: #{node.tag_name}" }

puts "\nSelect:"
selected_nodes = html_tree.select { |node| node.tag_name == 'p' }
selected_nodes.each { |node| puts "Tag: #{node.tag_name}, Content: #{node.content}" }

puts "\nAll tags are 'div'?:"
puts html_tree.all? { |node| node.tag_name == 'div' }