class Search
  def initialize(list)
    @list = list
  end

  def search(params)
    columns = @list.column_names
    query = ""
    columns.each do |col|
      if col != 'phone'
        query += col + " LIKE :search or "
      end
    end
    query = query[0..query.length-4]
    @list.where(query, {:search => "%#{params}%"}).order(id: :asc)
  end
end
