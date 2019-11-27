class Node
  attr_accessor :root, :left, :right

  def initialize(root=nil,left=nil,right=nil)
    @root = root
    @left = left
    @right = right
  end

  private
  def complete_roots(num,arr)
    min_root = num
    while num.nil? == false
      num = $roots[num] if num != nil
      num = num[0] if num != nil
      min_root = num if num != nil
    end
    if min_root != arr[0]
      $roots[min_root] = [arr[0],nil] 
      min_root = $roots[min_root]
      min_root = min_root[0]
    end
  end

  def find_roots(arr,clear=true)
    $roots = {} if clear
    return arr[0] if arr.length == 1
    return arr[1] if arr.length == 2
    mid = arr[arr.length/2]
    arr[arr.length/2] = nil
    $roots[mid] = []
    $roots[mid] << find_roots(arr.slice(0,arr.length/2),false)
    $roots[mid] << find_roots(arr.slice(arr.length/2,arr.length),false)
    return mid
  end

  public
  def build_tree(arr=nil,first_call=true,root=nil)
    if first_call && arr.kind_of?(Array)
      arr.uniq!
      arr.sort!
      root = arr[arr.length/2]
      find_roots(arr)
      complete_roots(root,arr)
    elsif arr.kind_of?(Array) == false && first_call
      p "Error: Argument should be an Array"
      return
    end
    if root.nil? == false && $roots[root] != nil 
      root = Node.new(root,$roots[root][0],$roots[root][1])
      root.left = build_tree(nil,false,root.left)
      root.right = build_tree(nil,false,root.right)
      return root
    elsif root.nil? == false && $roots[root] == nil 
      return Node.new(root,nil,nil)
    end
  end
end
