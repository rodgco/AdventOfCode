class Program
  attr_accessor :name, :weight, :children, :parent
  def initialize(name, weight=0, parent=nil, children=[])
    @name = name
    @weight = weight
    @parent = parent
    @children = children
  end

  def is_parent?
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
  if p.is_parent? then
    root ||= k
    root = k if p.children.include?(root)
  end
end

puts root

def calc_weight(pl, name)
  unless pl[name].is_parent? then
    w = pl[name].weight
  else
    w = pl[name].children.inject(pl[name].weight) {|s,p| s+calc_weight(pl, p)}
  end
  return w
end

def check_balance(pl, name)
  unless pl[name].is_parent? then
    w = pl[name].weight
  else
    w = pl[name].children.inject(pl[name].weight) {|s,p| s+calc_weight(pl, p)}
    m1 = pl[name].children.map {|p| check_balance(pl, p)}
    m2 = pl[name].children.map {|p| pl[p].weight }
    if m1.uniq.length > 1 then
      puts "#{name} is unbalanced. Children #{pl[name].children} ==>\n#{m1}\n#{m2}"
    end
  end
  return w
  # puts "#{'='*l} #{name} = #{w}"
end

puts check_balance program_list, root
