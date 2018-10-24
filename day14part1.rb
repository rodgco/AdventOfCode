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

sum = 0
("0".."127").each do |n|
  kh = KnotHash.new("jxqlasbh-"+n)
  puts "#{kh.input} #{kh.output[0,8]} #{kh.output.length} - #{sum += kh.output.count('1')}"
end

puts "Total used: #{sum}"