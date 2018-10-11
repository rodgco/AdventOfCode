puzzle = [4, 10, 4, 1, 8, 4, 9, 14, 5, 1, 14, 15, 0, 15, 3, 5]
history = Array.new
c = 0

begin
  history << puzzle.clone
  n = puzzle.index(puzzle.max)
  v = puzzle[n]
  puzzle[n] = 0
  (1..v).each do |x| 
    puzzle[(n+x)%puzzle.length] = puzzle[(n+x)%puzzle.length] + 1
  end
  c += 1
end until history.find {|p| p == puzzle }

puts c