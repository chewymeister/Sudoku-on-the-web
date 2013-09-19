require_relative './cell'
require_relative './box'

class Grid
  
  SIZE = 81

  attr_reader :board
  def initialize puzzle
    @puzzle = puzzle.chars
    @box = Box.new
  end

  def assign_values_to_cells
    @board = @puzzle.map do |value|
      Cell.new value.to_i
    end.each_slice(9).to_a
  end

  def assign_box_index_values 
    @box.assign_box_indices @board
  end    

  def assign_row_column_index_values
    row_index = nil
    column_index = nil
    @board.each do |row|
      row_index = @board.index(row)
      row.each do |cell|
        column_index = row.index(cell)
        cell.assign_row(row_index)
        cell.assign_column(column_index)
      end
    end                 
  end 

  def fetch_row(row_index)
    @board[row_index].flatten
  end

  def fetch_column(column_index)
    @board.map do |row|
      row[column_index]
    end.flatten
  end

  def get_cell_values_from board
    board.flatten.map(&:value)
  end

  def fetch_box(box_index)
    @board.map do |row|
      row.select do |cell|
        cell.box_index == box_index
      end
    end.flatten
  end

  def set_board
    assign_values_to_cells
    assign_box_index_values
    assign_row_column_index_values
  end

  def assign_neighbours_to cell
      neighbours = []
      neighbours <<fetch_row(cell.row_index).map {|cell| cell.value}
      neighbours <<fetch_column(cell.column_index).map {|cell| cell.value}
      neighbours <<fetch_box(cell.box_index).map {|cell| cell.value}
      cell.assign neighbours
  end

  def solve
    @board.flatten.each do |cell|
      if cell.filled_out?
        cell
      else 
        assign_neighbours_to cell
        cell.attempt_to_solve cell.neighbours
      end
    end
  end

  def solved?
    @board.flatten.select do |cell|
      !cell.filled_out?
    end.count == 0
  end

  def solve_board!
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      solve
      outstanding = @board.flatten.count {|c| c.filled_out?}
      looping = outstanding_before == outstanding
      outstanding_before = outstanding
    end
      try_harder unless solved?
  end

  def create_blank_cell
    blank_cell = @board.flatten.select do |cell|
      !cell.filled_out?
    end.first
  end

  def try_harder
    blank_cell = create_blank_cell

    blank_cell.candidates.each do |candidate|
      blank_cell.assume candidate
      board_copy = replicate(@board)

      board_copy.solve_board!

      if board_copy.solved?
        steal_solution(board_copy)
        break
      end
    end
  end

  def steal_solution board
    @board = board.board
  end

  def replicate board
    board_replicate = Grid.new create_current_puzzle_string_of(board)
    board_replicate.set_board
    board_replicate
  end

  def create_current_puzzle_string_of board
    current_puzzle_string = board.flatten.map do |cell|
      cell.value
    end.join
  end

  def provide_puzzle
    puzzle = []
    for index in 1..9
      puzzle << (get_cell_values_from(fetch_box(index)))
    end
    puzzle.flatten!
    puzzle.map!(&:to_s)
  end



  def inspect_board
    puts "-------------------------------------"
    @board.each do |row|
      row.each do |cell|
        print "| #{cell.value} "
      end
    puts "|\n-------------------------------------"
    end
  end

end