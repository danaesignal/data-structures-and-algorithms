class Node
  attr_accessor :value, :left, :right, :parent, :count
  def initialize(value)
    @value = value
    @count = 0
  end
end

class BinaryTree
  attr_accessor :root
  def initialize
  end

  def build_pre_sorted(seed_array)
    if seed_array.length < 3
      seed_array.each {|seed| add_leaf(seed) unless seed.nil?}
    else
      mid = (seed_array.length / 2) + 1
      left = seed_array.slice(0..mid-1)
      right = seed_array.slice(mid+1..-1)
      add_leaf(seed_array.slice(mid))
      build_pre_sorted(left)
      build_pre_sorted(right)
    end
  end

  def build_randomized(seed_array)
    build_pre_sorted(seed_array.shuffle!)
  end

  def add_leaf(leaf, current_node=@root, last_route=nil)
    leaf = Node.new(leaf) unless leaf.is_a? Node

    if current_node == nil
      leaf.parent.send(last_route, leaf) unless leaf.parent.nil?
      current_node = leaf
      current_node.count += 1
      @root = current_node if @root == nil
    elsif current_node.value == leaf.value
      current_node.count += 1
    else
      leaf.parent = current_node
      leaf.value < current_node.value ? add_leaf(leaf, current_node.left, :left=) : add_leaf(leaf, current_node.right,:right=)
    end
  end

  def list(current_node=@root, queue=[])
    current_node.parent.nil? ? current_par = "Empty" : current_par = current_node.parent.value
    current_node.nil? ? current_val = "Empty" : current_val = current_node.value
    current_node.left.nil? ? left_val = "Empty" : left_val = current_node.left.value
    current_node.right.nil? ? right_val = "Empty" : right_val = current_node.right.value
    current_node.count.nil? ? current_cnt = "Empty" : current_cnt = current_node.count

    puts "Node: #{current_val}, Left: #{left_val}, Right: #{right_val}, Parent: #{current_par}, Count: #{current_cnt}"
    queue << current_node.left if current_node.left
    queue << current_node.right if current_node.right

    list(queue.shift, queue) unless queue == []
  end

  def bfs(query, current_node=@root, queue=[])
    if current_node.value == query
      return current_node
    else
      queue << current_node.left if current_node.left
      queue << current_node.right if current_node.right

      bfs(query, queue.shift, queue) unless queue == []
    end
  end

  def dfs(query, current_node=@root, stack=[current_node])
    until stack == []
      return current_node if current_node.value == query
      stack.unshift(current_node.right) if current_node.right
      stack.unshift(current_node.left) if current_node.left
      current_node = stack.shift
    end
  end

  def dfs_rec(query, current_node=@root, stack=[current_node])
    return current_node if current_node.value == query
    stack.unshift(current_node.right) if current_node.right
    stack.unshift(current_node.left) if current_node.left
    dfs_rec(query, stack.shift, stack)
  end
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

money_tree = BinaryTree.new
money_tree.build_randomized(array)

puts money_tree.list

puts money_tree.dfs_rec(4)
