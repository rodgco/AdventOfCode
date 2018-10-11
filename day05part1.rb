a = Array.new
File.open('day05input.txt').each do |line|
  a << line.to_i
end

n = 0
c = 0

puts a.length

begin
  c += 1
  a[n] += 1
  n += a[n]-1
rescue
  puts n
end while n >= 0 and n <= a.length-1

puts c