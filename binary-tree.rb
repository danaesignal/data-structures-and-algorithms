class Node
  attr_accessor :value, :left, :right, :parent

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @parent = nil
  end
end

class BinaryTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def build_tree(seed_array)
    seed_array.each {|data| add_leaf(Node.new(data))}
  end

  def shuffle_then_build(seed_array)
    shuffled_seeds = seed_array.shuffle
    build_tree(shuffled_seeds)
  end

  def add_leaf(leaf, current_node=@root, last_route=nil)
    if current_node.nil?
      current_node = leaf
      current_node.parent.send(last_route, current_node) unless current_node.parent.nil?
      @root = current_node if @root == nil
    else
      leaf.parent = current_node
      if leaf.value < current_node.value
        add_leaf(leaf, current_node.left, :left=)
      else
        add_leaf(leaf, current_node.right, :right=)
      end
    end
  end
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

money_tree = BinaryTree.new
money_tree.shuffle_then_build(array)

puts money_tree.root.value
