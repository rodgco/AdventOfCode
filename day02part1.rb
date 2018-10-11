sum=0
File.open('day02input.txt').each do |line|
  a = line.split("\t").map {|x| x.to_i }
  sum += a.max - a.min
end
puts sum