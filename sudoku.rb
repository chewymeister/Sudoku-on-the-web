require 'sinatra'
require_relative './lib/cell'
require_relative './lib/grid'
require_relative './lib/box'
get '/' do
	erb :index
end

# def random_sudoku
#   seed = (1..9).to_a.shuffled + Array.new(81-9, 0)
#   sudoku = Grid.new(seed.join)
#   sudoku.set_board
#   sudoku.solve_board
# end
