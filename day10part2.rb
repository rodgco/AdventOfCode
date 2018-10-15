class Array
  def reverse_circular_sublist!(start, count)
    self.rotate!(start)
    self[0, count] = self[0, count].reverse
    self.rotate!(-start)
  end
end

input = "212,254,178,237,2,0,1,54,167,92,117,125,255,61,159,164"
length_suffix = [17,31,73,47,23]

current = 0
skip_size = 0
list = (0..255).to_a
#lengths = input.split(",").map(&:to_i)
lengths = input.each_byte.map(&:to_s).map(&:to_i) + length_suffix

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

puts s