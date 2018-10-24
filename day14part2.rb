class Array
  def reverse_circular_sublist!(start, count)
    self.rotate!(start)
    self[0, count] = self[0, count].reverse
    self.rotate!(-start)
  end
end

class KnotHash
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def output
    current = 0
    skip_size = 0
    list = (0..255).to_a
    lengths = @input.each_byte.map(&:to_s).map(&:to_i)+[17,31,73,47,23]

    64.times do
      lengths.each do |len|
        list.reverse_circular_sublist!(current, len)
        current = (current+len+skip_size)%list.length
        skip_size += 1
      end
    end

    s = ""
    16.times do |n|
      s+=("00"+(list[n*16, 16].inject {|s,n| s^n}).to_s(16))[-2,2]
    end

    return s.scan(/\w/).inject("") {|s,c| s+c.hex.to_s(2).rjust(c.size*4, '0')}
  end
end

class RegionMap
  attr_reader :map, :list
  def initialize(height, width)
    @height = height
    @width = width
    @map = Array.new
    (1..height).each do
      @map << Array.new(width, nil)
    end
    @list = Array.new

  end

  def use(lin, col)
    @map[lin][col] = true
  end

  def create_map
    (0..@height-1).each do |lin|
      (0..@width-1).each do |col|
        index = scan(lin, col)
      end
    end
  end

  def scan(lin, col)
    return unless @map[lin][col]
    links = Array.new
    links << "#{(lin-1)*128+col}" if lin > 0 && @map[lin-1][col]
    links << "#{lin*128+(col-1)}" if col > 0 && @map[lin][col-1]
    links << "#{(lin+1)*128+col}" if lin < @height-1 && @map[lin+1][col]
    links << "#{lin*128+(col+1)}" if col < @width-1 && @map[lin][col+1]
    links << "#{lin*128+col}" if links.length == 0 
    @list << "#{lin*128+col} <-> " + links.join(",")
  end

  def remap(g1, g2)

  end
end

class Programs
  attr_accessor :tracking
  def initialize
    @programs = Hash.new
  end

  def add(name, connections)
    @programs[name] = connections
  end

  def count(name, initial=true)
    @tracking = [] if initial
    @tracking += [name]
    @programs[name].each do |p|
      unless @tracking.include?(p) then
        count(p, false)
      end
    end
  end

  def exists?(name)
    puts "Exists " + name
    @programs[name] != nil
  end
end

rm = RegionMap.new(128, 128)
(0..127).each do |n|
  KnotHash.new("jxqlasbh-"+n.to_s).output.scan(/\w/).each_with_index do |v, i|
    rm.use(n, i) if v == "1"
  end
end

rm.create_map

programs = Programs.new
rm.list.each do |line|
  puts line
  name, *connections = line.split(/[\s|<|\-|>|,]/).reject(&:empty?)
  programs.add(name, connections)
end

tracked = Array.new
groups = 0
("0".."16381").each do |n|
  if programs.exists?(n) then
    unless tracked.include?(n) then
      programs.count(n) 
      tracked += programs.tracking
      groups += 1
    end
  end
end

puts "Groups: #{groups}"
