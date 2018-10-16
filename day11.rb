class HexGrid
  def initialize
    @path = Hash.new(0)
  end

  MAP = {
    "s"=>{"n"=>nil, "ne"=>"se", "nw"=>"sw"},
    "n"=>{"s"=>nil, "se"=>"ne", "sw"=>"nw"},
    "nw"=>{"se"=>nil, "s"=>"sw", "ne"=>"n"},
    "ne"=>{"sw"=>nil, "s"=>"se", "nw"=>"n"},
    "sw"=>{"ne"=>nil, "n"=>"nw", "se"=>"s"},
    "se"=>{"nw"=>nil, "n"=>"ne", "sw"=>"s"}
  }

  def add(direction)
    MAP[direction].each_pair do |d, sc|
      if @path[d] > 0 then
        @path[d] -= 1
        direction = sc
        break
      end
    end
    @path[direction] += 1 if direction
  end

  def sum
    @path.values.inject(&:+)
  end
end

max = 0
File.open('day11input.txt').each do |line|
  p = HexGrid.new
  line.strip.split(",").each do |h| 
    p.add(h)
    max = [p.sum, max].max
  end
  puts "#{p} ==> #{p.sum} | Max: #{max}"
end

