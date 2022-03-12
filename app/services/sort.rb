class Sort
  def initialize(list)
    @list = list
  end

  def sort(params)
    @list.order(params + ' asc')
  end

  def sort_contra(params)
    @list.order(params + ' desc')
  end
end
