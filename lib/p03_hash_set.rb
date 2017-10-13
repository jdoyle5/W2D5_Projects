require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @orig_num_buckets = num_buckets
  end

  def insert(key)
    if @count == @orig_num_buckets
      resize!
      @store[bucket_number(key.hash)] << key.hash
      @count += 1
    elsif !include?(key.hash)
      @store[bucket_number(key.hash)] << key.hash
      @count += 1
    end
  end

  def include?(key)
    @store[bucket_number(key.hash)].include?(key.hash)
  end

  def remove(key)
    if @store[bucket_number(key.hash)].include?(key.hash)
      @store[bucket_number(key.hash)].delete(key.hash)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end


  def bucket_number(key)
    # this one is from what we have before so it still has num
      key.hash % @orig_num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    iter = @store.flatten
    temp_arr = Array.new(@orig_num_buckets*2) { Array.new() }
    iter.each do |key|
      temp_arr[key.hash % (@orig_num_buckets*2)] << key.hash
    end

    @store = temp_arr
    @orig_num_buckets = @orig_num_buckets * 2
  end


end
