class ArrayIterator
  attr_accessor :idx
  attr_reader   :array

  def initialize(array)
    @array = array
    @idx = 0
  end

  def has_next?
    idx < array.length  
  end

  def item
    array[idx]
  end

  def next_item
    value = array[idx]
    self.idx += 1
    value
  end
end


array = ['red', 'green', 'blue']

i = ArrayIterator.new(array)

while i.has_next?
  puts "item: #{i.next_item}"
end
