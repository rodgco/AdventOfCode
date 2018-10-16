class Programs
  attr_accessor :tracking
  def initialize
    @programs = Hash.new
  end

  def add(name, connections)
    @programs[name] = connections
  end

  def count(name, initial=true)
    @tracking = [] if initial
    @tracking += [name]
    @programs[name].each do |p|
      unless @tracking.include?(p) then
        count(p, false)
      end
    end
  end
end

programs = Programs.new
File.open('day12input.txt').each do |line|
  name, *connections = line.split(/[\s|<|\-|>|,]/).reject(&:empty?)
  programs.add(name, connections)
end

programs.count("0")
puts "#{programs.tracking} => #{programs.tracking.length}"
