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

  def add_leaf(leaf, current_node=@root, last_route=nil)
    leaf = Node.new(leaf) unless leaf.is_a? Node

    if current_node == nil
      current_node = leaf
      @root = current_node if @root == nil
      case last_route
        when :left then current_node.parent.left = current_node
        when :right then current_node.parent.right = current_node
      end
    else
      leaf.parent = current_node
      if leaf.value < current_node.value
        add_leaf(leaf, current_node.left, :left)
      else
        add_leaf(leaf, current_node.right, :right)
      end
    end
  end
  
end


array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

money_tree = BinaryTree.new

array.each {|data| money_tree.add_leaf(data)}

puts money_tree.root.right.left
