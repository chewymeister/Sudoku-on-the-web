require_relative './cell'
require_relative './box'

class Grid
  SIZE = 81

  attr_reader :board
  def initialize puzzle
    @puzzle = puzzle.chars
    @box = Box.new
  end

  def array_of_cells_with_values
    @puzzle.map { |value| Cell.new value.to_i }
  end

  def create_board_from array
    @board = array.each_slice(9).to_a
  end

  def assign_box_index_values 
    @box.assign_box_indices @board
  end

  def assign_row_column_index_values
    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, column_index|
        cell.assign_indices(row_index, column_index)
      end
    end
  end

  def row_neighbours_for(current_cell)
    @board[current_cell.row_index].map(&:value)
  end

  def column_neighbours_for(current_cell)
    @board.map { |row| row[current_cell.column_index].value }
  end

  def box_neighbours_for(current_cell)
    @board.flatten.select { |cell| cell.box_index == current_cell.box_index }.map(&:value)
  end

  def get_cell_values_from board
    board.flatten.map(&:value)
  end

  def set_board
    create_board_from(array_of_cells_with_values)
    assign_box_index_values
    assign_row_column_index_values
  end

  def assign_neighbours_to cell
    neighbours = [row_neighbours_for(cell), column_neighbours_for(cell), box_neighbours_for(cell)]
    cell.assign neighbours
  end

  def solve
    @board.flatten.each do |cell|
      if cell.filled_out?
        cell
      else
        assign_neighbours_to cell
        cell.attempt_to_solve
      end
    end
  end

  def solved?
    list_of_outstanding_cells.count == 0
  end

  def list_of_completed_cells
    @board.flatten.select { |cell| cell.filled_out? }
  end

  def list_of_outstanding_cells
    @board.flatten.select(&:empty?)
  end

  def solve_board!
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      solve
      looping = outstanding_before == list_of_completed_cells.count
      outstanding_before = list_of_completed_cells.count
    end
    try_harder unless solved?
  end

  def first_blank_cell
    list_of_outstanding_cells.first
  end

  def try_harder
    blank_cell = first_blank_cell

    blank_cell.candidates.each do |candidate|
      blank_cell.assume(candidate)
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
    board_replicate = Grid.new create_puzzle_string_of_current(board)
    board_replicate.set_board
    board_replicate
  end

  def create_puzzle_string_of_current board
    board.flatten.map(&:value).join
  end

  def provide_puzzle
    puzzle = []
    for index in 1..9
      puzzle << (get_cell_values_from(fetch_box(index)))
    end
    puzzle.flatten!
    puzzle.map!(&:to_s)
  end

  def fetch_box(index)
    @board.flatten.select { |cell| cell.box_index == index }
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