nest = 0
total = 0 
totalg = 0
neg = false
garb = false
File.open('day09input.txt').each do |line|
  line.each_char do |c|
    print "#{c} ==> "
    unless neg then
      if garb then 
        case c
        when "!"
          puts "neg on"
          neg = true
        when ">"
          puts "garb off"
          garb = false
        else
          puts "Garbage"
          totalg += 1
        end
      else
        case c
        when "{"
          nest += 1
          puts "group on #{nest}"
        when "}"
          total += nest
          nest -= 1
          puts "group off"
        when "<"
          puts "garb on"
          garb = true
        when "!"
          puts "neg on"
          neg = true
        end
      end
    else
      puts "negated"
      neg = false
    end
  end
end
puts "Part1 ==> Total Group Score: #{total}"
puts "Part2 ==> Total Garbage Charactarers: #{totalg}"