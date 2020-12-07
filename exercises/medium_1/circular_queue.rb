class CircularQueue
  def initialize(size)
    @buffer = Array.new(size)
    @position = 0
    @oldest_position = 0
  end

  def enqueue(object)
    unless @buffer[@position].nil?
      @oldest_position = increment_position(@oldest_position)
    end
    
    @buffer[@position] = object
    @position = increment_position(@position)
  end

  def dequeue
    value = @buffer[@oldest_position]
    @buffer[@oldest_position] = nil
    @oldest_position = increment_position(@oldest_position) unless value.nil?
    value
  end
  
  def increment_position(position)
    (position + 1) % @buffer.size
  end
end

# queue = CircularQueue.new(3)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)

# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# queue = CircularQueue.new(4)
# puts queue.dequeue == nil

# queue.enqueue(1)
# queue.enqueue(2)
# puts queue.dequeue == 1

# queue.enqueue(3)
# queue.enqueue(4)
# puts queue.dequeue == 2

# queue.enqueue(5)
# queue.enqueue(6)
# queue.enqueue(7)
# puts queue.dequeue == 4
# puts queue.dequeue == 5
# puts queue.dequeue == 6
# puts queue.dequeue == 7
# puts queue.dequeue == nil

# Further Exploration
class CircularQueueTwo
  def initialize(size)
    @buffer = [nil] * size
    @size = size
  end
  
  def enqueue(object)
    dequeue if @buffer.size == @size
    @buffer.push(object)
  end
  
  def dequeue
    @buffer.shift
  end
end

queue = CircularQueueTwo.new(4)
puts queue.dequeue == nil
p queue
queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1
p queue
queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil