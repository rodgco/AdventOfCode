tape = Hash.new(0)
current_state = :a
current_position = 0

logic = Hash.new
logic[[:a, 0]] = [1, 1, :b]
logic[[:a, 1]] = [1, -1, :e]
logic[[:b, 0]] = [1, 1, :c]
logic[[:b, 1]] = [1, 1, :f]
logic[[:c, 0]] = [1, -1, :d]
logic[[:c, 1]] = [0, 1, :b]
logic[[:d, 0]] = [1, 1, :e]
logic[[:d, 1]] = [0, -1, :c]
logic[[:e, 0]] = [1, -1, :a]
logic[[:e, 1]] = [0, 1, :d]
logic[[:f, 0]] = [1, 1, :a]
logic[[:f, 1]] = [1, 1, :c]

(1..12459852).each { |x|
  values = logic[[current_state, tape[current_position]]]
  tape[current_position] =values[0]
  current_position += values[1]
  current_state = values[2]
}

puts tape.values.inject(0) {|sum,value| sum+value }