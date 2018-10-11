# 17  16  15  14  13
# 18   5   4   3  12
# 19   6   1   2  11
# 20   7   8   9  10
# 21  22  23---> ...

#325489

hor_count, hor_pos = 0, 0
ver_count, ver_pos = 0, 0

next_direction = :l #:l :u :r :d
left, up, right, down = 0, 0, 0, 0

(2..325489).each {|n|
  case next_direction
  when :l
    hor_pos += 1
    if hor_pos > left then
      left = hor_pos
      next_direction = :u
    end
  when :u
    ver_pos -= 1
    if ver_pos < up then
      up = ver_pos
      next_direction = :r
    end
  when :r
    hor_pos -= 1
    if hor_pos < right then
      right = hor_pos
      next_direction = :d
    end
  when :d
    ver_pos += 1
    if ver_pos > down then
      down = ver_pos
      next_direction = :l
    end
  end
}

puts "#{hor_pos.abs + ver_pos.abs}"