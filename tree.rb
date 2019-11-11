require_relative "node"

class Tree
    include Comparable

    def initialize(arr)
        if arr.kind_of?(Array)
            data = Node.new
            @root = data.build_tree(arr)
            @roots = []
        else
            p "Error: Expected array argument instead of #{arr}."
        end
    end

    private

    def branch_template(roots=@root)
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
            row << "" 
          end
        end
        @roots << row if row != []
        branch_template(next_roots)
    end

    public

    def print_tree(roots=@root)
        branch_template([roots])
        @roots.each do |arr|
            arr.each do |n|
              print n + " "
            end
            p ""
            print "/\\ " * arr.length
            p "" 
        end
    end

    def insert(data)
        return if data.kind_of?(Numeric) == false
        current = @root
        while current.nil? == false
            return if data == current.root
            if data < current.root
                if current.left.nil?
                    current.left = Node.new(data,nil,nil)
                    break
                else
                    left = current.left
                    if data < left.root
                        if left.left
                            current = left.left
                        else
                            left.left = Node.new(data,nil,nil)
                            break
                        end
                    elsif data > left.root
                        if left.right
                            current = left.right
                        else
                            left.right = Node.new(data,nil,nil)
                            break
                        end
                    else
                        p "Value #{data} already exist in tree."
                        break
                    end
                end 
            else
                if current.right.nil?
                    current.right = Node.new(data,nil,nil)
                else
                    right = current.right
                    if data < right.root
                        if right.left
                            current = right.left
                        else
                            right.left = Node.new(data,nil,nil)
                            break    
                        end
                    elsif data > right.root
                        if right.right
                            current = right.right
                        else
                            right.right = Node.new(data,nil,nil)
                            break  
                        end
                    else
                        p "Value #{data} already exist in tree."
                        break
                    end
                end
            end
        end
    end

    def delete(data)
    end

    def find(data)
        return if data.kind_of?(Numeric) == false
        current = @root
        while current.nil? == false 
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
end

a = Tree.new([4,2,5,6,334,53,7,447,86,24,64,6824,114,35,57,86,666,13,11,14])
found = a.find(114)
p found
a.print_tree
