class Firewall
  attr_reader :severity, :caught
  def initialize
    @layers = Hash.new
    @severity = 0
    @caught = false
  end

  def add_layer(depth, range)
    @layers[depth] = Layer.new(depth, range)
  end

  def run(delay=0, verbose=false)
    reset
    @layers.each_value do |l|
      psicotime = delay+l.depth
      print "PS:#{psicotime} " if verbose
      print "Depth:#{l.depth} Range:#{l.range} " if verbose
      if l.caught_at?(delay) then
        print " ***Caught***" if verbose
        @severity += l.depth * l.range
        @caught = true
      end
      print "\n" if verbose
    end
  end

  def reset
    @severity = 0
    @caught = false
  end
end

class Layer
  attr_reader :depth, :range

  def initialize(depth, range)
    @depth = depth
    @range = range
  end

  def triangle_wave(n, x)
    ((x-n)%(n*2)-n).abs
    x.modulo(n*2)
  end
  
  def caught_at?(delay)
#    puts "==> R:#{@range} D:#{@depth} De:#{delay}"
    triangle_wave(@range-1, @depth+delay)==0
  end
end

firewall = Firewall.new
File.open('day13input.txt').each do |line|
  depth, range = line.split(":").map(&:to_i)
  firewall.add_layer depth, range
end

firewall.run(0, true)
puts "Delay:0 Severity: #{firewall.severity}"

delay = 0
begin
  delay += 1
  firewall.run(delay)  
end until not firewall.caught

puts "Delay:#{delay} Severity: #{firewall.severity}"