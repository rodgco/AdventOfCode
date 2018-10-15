class Program
  attr_accessor :name, :weight, :children, :parent
  def initialize(name, weight=0, parent=nil, children=[])
    @name = name
    @weight = weight
    @parent = parent
    @children = children
  end

  def add_child(child)
    if child.class == "Program" then
      @child << p
    else
      @children << Program.new(child, nil, self, [])
    end 
  end

  def is_parent
    children.length > 0
  end
end


program_list = Hash.new
File.open('day07input.txt').each do |line|
  data = line.scan(/(\w+)/).join(",").split(",")
  p = Program.new(data[0], data[1].to_i, nil, data[2..-1])
  program_list[data[0]] = p
end

# find root
root = nil
program_list.each_pair do |k,p|
  if p.is_parent then
    root ||= k
    root = k if p.children.include?(root)
  end
end

puts root