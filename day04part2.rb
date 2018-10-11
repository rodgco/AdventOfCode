sum=0
File.open('day04input.txt').each do |line|
  a = line.split("\s")
  a.map! {|x| x.scan(/\w/).sort.join}
  sum += 1 unless a.detect{ |e| a.count(e) > 1 }
end
puts sum