#!/usr/bin/env ruby

# AVLTree have a inner class Node wich in turn have a inner class EmptyNode.
class AVLTree
  # All method that modifies the tree go here.
  class Node
    attr_accessor :left, :right
    attr_accessor :key, :value, :height

    # A node is never of type nil, is a EmptyNode
    def initialize(key = nil, value = nil, height = nil)
      @key = key
      @value = value
      @height = height
      @left = @right = EmptyNode.new
    end

    # Insert a new key and balance the tree, returning it. If the key is duplicated, it goes to the right side.
    def insert(key, value)
      case key <=> @key
      when -1
        @left = @left.insert(key, value)
        @left.height = self.height + 1
      when 1, 0
        @right = @right.insert(key, value)
        @right.height = self.height + 1
      else
        raise TypeError, "Cannot compare #{key} (#{key.class}) with #{@key} (#{@key.class})."
      end
      balance
    end

    # Balance the tree, returning it. The balance factor determines if the subtree is or isn't balanced.
    def balance
      balanceFactor = balance_factor
      return self if balanceFactor >= -1 && balanceFactor <= 1
      if balanceFactor > 1
        if @right.balance_factor < 0
          @right = @right.rotate_right
          root = rotate_left
        else
          root = rotate_left
        end
      else
        if @left.balance_factor > 0
          @left = @left.rotate_left
          root = rotate_right
        else
          root = rotate_right
        end
      end
      root
    end

    # Return the balance factor of a node.
    def balance_factor
      leftSize =  deepest_node(@left).height
      rightSize = deepest_node(@right).height
      rightSize - leftSize
    end

    # Return the height of the deepest node in a tree.
    def deepest_node(node = self, deepest = self)
      return deepest if node.nil?
      if node.height > deepest.height then deepest = node else deepest end
      right = deepest_node(node.right, deepest)
      left = deepest_node(node.left, deepest)
      right.height > left.height ? right : left
    end

    # Return the tree after rotated the root to left.
    def rotate_left
      raise "The node have not right child to do a left rotation" if @right.nil?
      root = @right
      @right = root.left
      root.height = @height
      root.left = self
      root.left.update_height(1)
      root.right.update_height(-1)
      root.left.right.update_height(-1) # It's not fashionable, but solves the problem without calculate the hole tree height's again.
      root
    end

    # Return the tree after rotated the root to right.
    def rotate_right
      raise "The node have not left child to do a right rotation" if @left.nil?
      root = @left
      @left = root.right
      root.height = @height
      root.right = self
      root.left.update_height(-1)
      root.right.update_height(1)
      root.right.left.update_height(-1) # It's not fashionable, but solves the problem without calculate the hole tree height's again.
      root
    end

    # Update the tree height summing the informed value in all nodes (this value can be negative).
    def update_height(value)
      @height += value
      @left.update_height(value)
      @right.update_height(value)
    end

    class EmptyNode < Node
      def initialize
        @key = nil
        @height = 0
      end

      # Stop recursive call and insert the new key.
      def insert(key, value)
        Node.new(key, value, 0)
      end

      # Intentionally blank (stop recursive call).
      def update_height(value)
      end

      # Semantically, a EmptyNode is always nil.
      def nil?
        true
      end
    end
  end

  attr_accessor :root

  # Root start like a EmptyNode.
  def initialize
    @root = Node::EmptyNode.new
  end

  # Call insert method from the node class.
  def insert(key, value)
    @root = @root.insert(key, value)
  end
  alias :[]= :insert

  # For debbug.
  def print_tree(node = @root)
    return if node.nil?
    puts node.value
    puts "#{node.left.nil? || node.left.key.nil? ? 'null' : node.left.key} - #{node.nil? || node.key.nil? ? 'null' : node.key}(L#{node.height}) - #{node.right.nil? || node.right.key.nil? ? 'null' : node.right.key}"
    print_tree(node.left)
    print_tree(node.right)
  end

  # Sequence = left, root and right of each sub-tree
  def in_order(node = @root, sequence = [])
    return sequence if node.nil?
    in_order(node.left, sequence)
    sequence << [node.key, node.height]
    in_order(node.right, sequence)
  end
end
