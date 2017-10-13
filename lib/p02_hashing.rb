class Fixnum
  # Fixnum#hash already implemented for you
end

# create hashes, with # of index as keys, and items as values such as "hello", 5, :blah
# {0=> "hello", 1> 5, 2=> :blah}


class Array
  def hash
    result = 0
    self.each_with_index do |el, i|
      result += (el.hash * i.hash)
    end
    result.hash
  end
end

class String
  def hash
    result = 0
    self.chars.each_with_index do |char, i|
      result += (char.ord.hash * i.hash)
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.flatten.hash
    # 0
  end
end
