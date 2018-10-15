class Array
  def reverse_circular_sublist!(start, count)
    self.rotate!(start)
    self[0, count] = self[0, count].reverse
    self.rotate!(-start)
  end
end

current = 0
skip_size = 0
list = (0..255).to_a
lengths = [212,254,178,237,2,0,1,54,167,92,117,125,255,61,159,164]

lengths.each do |len|
  list.reverse_circular_sublist!(current, len)
  current = (current+len+skip_size)%list.length
  skip_size += 1
end

puts "#{list[0]} * #{list[1]} = #{list[0]*list[1]}"