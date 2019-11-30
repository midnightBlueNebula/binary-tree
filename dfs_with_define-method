require_relative "node"

class Tree
    include Comparable

    def initialize(arr)
        if arr.kind_of?(Array)
            data = Node.new
            @root = data.build_tree(arr)
            $roots = {}
            @roots = []
        else
            p "Error: Expected array argument instead of #{arr}."
        end
    end

    private

    def branch_template(roots=[@root],first_call=true)
        @roots = [] if first_call
        return if roots == []
        row = []
        next_roots=[]
        roots.each do |r|
          if r.kind_of?(Numeric)
             row << r.to_s
          elsif r
            row << r.root.to_s
            next_roots << r.left
            next_roots << r.right
          elsif r.nil?
            row << "x" 
          end
        end
        @roots << row if row != []
        branch_template(next_roots,false)
    end

    public

    def print_tree(roots=@root)
        branch_template([roots]) 
        i = 0
        @roots.each do |arr|
            j = 0
            arr.each do |n|
                if j == 0
                    print " " * (@roots.length-i) + n + " "
                else
                    print n == "" ? "x " : n + " "
                end
                j += 1
            end
            j = 0
            print "\n"
            print " " * (@roots.length-i) + "/\\ " * arr.length 
            print "\n"
            i += 1
        end
    end

    def insert(data)
        return if data.kind_of?(Numeric) == false
        current = @root
        while current.nil? == false
            return if data == current.root
            if current.root == nil 
              current.root = data
              return
            end
            if data < current.root
                if current.left.nil?
                    current.left = Node.new(data,nil,nil)
                    return
                else
                    left = current.left
                    if data < left.root
                        if left.left
                            current = left.left
                        else
                            left.left = Node.new(data,nil,nil)
                            return
                        end
                    elsif data > left.root
                        if left.right
                            current = left.right
                        else
                            left.right = Node.new(data,nil,nil)
                            return
                        end
                    else
                        p "Value #{data} already exist in tree."
                        return
                    end
                end 
            else
                if current.right.nil?
                    current.right = Node.new(data,nil,nil)
                    return
                else
                    right = current.right
                    if data < right.root
                        if right.left
                            current = right.left
                        else
                            right.left = Node.new(data,nil,nil)
                            return    
                        end
                    elsif data > right.root
                        if right.right
                            current = right.right
                        else
                            right.right = Node.new(data,nil,nil)
                            return  
                        end
                    else
                        p "Value #{data} already exist in tree."
                        return
                    end
                end
            end
        end
    end

    def delete(data,first_call=true,i=0)
      return if data.kind_of?(Numeric) == false
      current = @root
      while current.nil? == false && current.root != nil
        if data == current.root
          if first_call == false && i == 0
            current = current.left
            i += 1
            next
          end
          if current.right == nil && current.left == nil
            current.root = nil   
          elsif current.left == nil
            right = current.right 
            current.root = right.root 
            current.right = right.right 
            current.left = right.left
          elsif current.right == nil
            left = current.left
            current.root = left.root
            current.left = left.left 
            current.right = left.right
          else 
            replace_with = current.left
            left =  current.left
            min_diff = current.root-replace_with.root
            while left != nil 
              left = left.right
              break if left.nil? || left.root == nil 
              if current.root - left.root < min_diff
                replace_with = left 
                min_diff = current.root - left.root
              end
            end
            current.root = replace_with.root
            if replace_with.left == nil &&                replace_with.right == nil
              replace_with.root = nil 
              return  
            elsif replace_with.left == nil
	            replaced = replace_with.right
              replace_with.root = replaced.root
	            replace_with.left = replaced.left
	            replace_with.right = replaced.right
              return 
            elsif replace_with.right == nil
              replaced = replace_with.left
              replace_with.root = replaced.root
	            replace_with.left = replaced.left
	            replace_with.right = replaced.right
              return 
            else 
              delete(replace_with.root,false)
            end 
          end
        elsif data < current.root
          if current.left
            current = current.left 
          else
            return 
          end 
        elsif data > current.root
          if current.right
            current = current.right
          else
            return
          end
        end 
      end
      return  
    end

    def find(data)
        return if data.kind_of?(Numeric) == false
        current = @root
        while current.nil? == false && current.root != nil
            return current if data == current.root
            if data < current.root
                current = current.left 
            else
                current = current.right
            end
        end
        p "Value #{data} doesn't exist in binary tree."
        return nil
    end

    def level_order
      branch_template([@root])
      if block_given?
        @roots.each do |arr|
          arr.each do |data|
            yield(data.to_i) if data != nil && data != "" && data != "x"
          end
        end
      else
        res = []
        @roots.each do |arr|
          arr.each do |data|
            res << data.to_i if data != nil && data != "" && data != "x"
          end
        end
        return res 
      end
    end

    def depth(node=@root)
      @roots = []
      node = find(node) if node != @root
      branch_template([node])
      while @roots[-1].all? {|i| i == "x"}
        @roots.pop
      end
      return @roots.length - 1
    end

    def balanced?
      left = @root.left
      right = @root.right
      left_depth = depth(left.root)
      right_depth = depth(right.root)
      diff = left_depth > right_depth ? left_depth - right_depth : right_depth - left_depth
      return diff > 1 ? false : true
    end

    def rebalance!
      if balanced?
        p "Binary tree already balanced"
      else
        p "Rebalancing binary tree..."
        arr = []
        level_order { |e| arr << e }
        data = Node.new
        @root = data.build_tree(arr)
        p "Binary tree rebalanced"
        print_tree
      end
    end

    ["inorder","preorder","postorder"].each do |action|
      define_method(action) do |node=@root,first_call=true,&block|
        return if node.nil? || node.root == nil
        @roots = [] if first_call
        left = node.left
        right = node.right
        if action == "inorder"
          inorder(left,false) if left && left.root
          @roots << node 
          inorder(right,false) if right && right.root
        elsif action == "preorder"
          @roots << node
          preorder(left,false) if left && left.root
          preorder(right,false) if right && right.root
        elsif action == "postorder"
          postorder(left,false) if left && left.root
          postorder(right,false) if right && right.root
          @roots << node
        end
        return node if first_call == false  
        if block
          @roots.each {|i| block.call(i.root) if i }  
        else
          return @roots.map { |i| i.root if i }
        end
      end
    end
end


#arr = Array.new(100) { |i| i }

arr = Array.new(26) { |i| i*10 }

#arr = Array.new(1000000) { rand(1000000) }

a = Tree.new(arr)


found = a.find(80)
p found
a.print_tree 

#a.delete(60)
#a.print_tree

#a.delete(50)
#a.print_tree

#a.delete(40)
#a.print_tree

a.insert(65)
a.insert(67)
a.insert(64)
a.insert(32)
a.insert(15)
a.insert(11)
a.print_tree

p "---------------------------"
p "        level_order        "
a.level_order { |e| print "#{e} " } 
p "\n"
p "---------------------------"
p "          inorder          "
a.inorder { |e| print "#{e} " } 
p "\n"
p "---------------------------"
p "          preorder         "
a.preorder { |e| print "#{e} " }
p "\n"
p "---------------------------"
p "          postorder        "
a.postorder { |e| print "#{e} " }
p "\n"
p "---------------------------"
p a.depth(10)
p a.balanced?
a.rebalance!
p a.depth(10)
p a.balanced?
