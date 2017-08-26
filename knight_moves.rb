class Square
  attr_reader :coords, :previous_square
  def initialize(coords, previous=nil)
    @coords = coords
    @previous_square = previous
    @mods = [[1,2], [1,-2], [-1, 2], [-1,-2], [2,1], [2, -1], [-2, 1], [-2,-1]]
  end

  def populate_nearby(returner=[])
    @mods.each do |mod|
      holder = coords[0] + mod[0], coords[1] + mod[1]
      returner << Square.new(holder, self) unless holder.any? {|cell| cell < 0 || cell > 7}
    end
    return returner
  end
end

class Knight
  def initialize(name)
    @name = name
  end

  def sally_forth(start_point, end_point, current=nil, queue=[], first_node=nil)
    if first_node == nil
      queue << Square.new(start_point)
      current = queue.shift
      first_node = current
    end
      return retrace_steps(current, first_node) if current.coords == end_point
      current.populate_nearby.each {|child| queue << child}
      sally_forth(start_point, end_point, queue.shift, queue, first_node)
  end

  def retrace_steps(end_point, start_point, current_node = end_point, path=[])
    path << current_node.coords
    toast = "#{@name} found the path in #{path.length} turns!\n#{@name}'s path is as follows: #{path}."
    return toast if current_node == start_point
    retrace_steps(end_point, start_point, current_node.previous_square, path)
  end
end

turalyon = Knight.new("Turalyon")

puts turalyon.sally_forth([3,3],[0,0])
