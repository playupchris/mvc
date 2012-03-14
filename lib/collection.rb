class Collection
  include Enumerable

  def initialize(data)
    @items = data
  end

  def items
    @items ||= []
  end

  def each &block
    items.each { |item| block.call(item) }
  end

  def <<(item)
    items << item
  end
end
