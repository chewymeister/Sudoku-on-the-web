class Box

  def row_range(index)
    case index
    when 1,2,3
      0..2
    when 4,5,6
      3..5
    when 7,8,9
      6..8
    end
  end

  def column_range(index)
    case index
    when 1,4,7
      0..2
    when 2,5,8
      3..5
    when 3,6,9
      6..8
    end
  end

  def iterate_to_assign(board, index)
    board[row_range(index)].map do |row|
      row[column_range(index)]
    end.flatten.each do |cell|
      cell.assign_box_index index
    end
  end

  def assign_box_indices board
    for index in 1..9
      iterate_to_assign(board,index)
    end
  end

end