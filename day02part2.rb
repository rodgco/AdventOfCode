sum=0
File.open('day02input.txt').each do |line|
  a = line.split("\t").map {|x| x.to_i }
  a.sort!.reverse!
  a.each_index {|n| 
    a[n+1..-1].each_index {|m| 
      r = a[n].to_f / a[m+n+1]
      if r == r.round then
        puts "#{a[n]} - #{a[m+n+1]}" 
        sum += r
      end
    }
  }
end
puts sum