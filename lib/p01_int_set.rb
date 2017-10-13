class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
    @max = @store.length
  end

  def insert(num)
    is_valid?(num)
    @store[num] = true if !include?(num)
  end

  def remove(num)
    is_valid?(num)
    @store[num] = false if include?(num)
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" if num > @max || num < 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    if !@store.include?(num)
      @store[bucket_number(num)] << num
    end
  end

  def remove(num)
    @store[bucket_number(num)].delete(num) if @store[bucket_number(num)].include?(num)
  end

  def include?(num)
    if @store[bucket_number(num)].include?(num)
      return true
    else
      return false
    end
  end

  def bucket_number(num)
    num % num_buckets
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @orig_num_buckets = num_buckets
  end

  def insert(num)
    if @count == @orig_num_buckets
      resize!
      @store[bucket_number(num)] << num
      @count += 1
    elsif !include?(num)
      @store[bucket_number(num)] << num
      @count += 1
    end

  end

  def remove(num)
    if @store[bucket_number(num)].include?(num)
      @store[bucket_number(num)].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[bucket_number(num)].include?(num)
  end

  # private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end


  def bucket_number(num)
    num % @orig_num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    iter = @store.flatten
    temp_arr = Array.new(@orig_num_buckets*2) { Array.new() }
    iter.each do |num|
      temp_arr[num % (@orig_num_buckets*2)] << num
    end

    @store = temp_arr
    @orig_num_buckets = @orig_num_buckets * 2
  end

end
