class Cell

  attr_accessor :value
  attr_reader :box_index
  attr_reader :neighbours
  attr_reader :row_index
  attr_reader :column_index
  attr_reader :candidates

  def initialize value
    @value = value
    @candidates = [1,2,3,4,5,6,7,8,9]
    @neighbours = []
    @solvable = true
  end

  def assign_row index
    @row_index = index
  end

  def assign_column index
    @column_index = index
  end
  
  def assign_box_index value
    @box_index = value
  end

  def assign(neighbours)
    @neighbours += neighbours
    @neighbours.flatten!
  end

  def filled_out?
    @value != 0
  end

  def solvable?
    @solvable == true
  end

  def unsolvable!
    @solvable = false
  end

  def attempt_to_solve(neighbours)
      @candidates -= neighbours
      if @candidates.count == 1
        @value = @candidates.pop
        @neighbours.clear
      else
        @neighbours.clear
      end
  end

  def assume candidate
    @value = candidate
  end

end