reg = Hash.new(0)
maxv = 0

File.open('day08input.txt').each do |line|
  v1, oper, value, x,v2, logoper, comp = line.split
  reg[v1] = reg[v1].send(oper == "inc" ? :+ : :-, value.to_i) if reg[v2].send(logoper, comp.to_i)
  maxv = maxv >= reg[v1] ? maxv : reg[v1]
end

puts maxv