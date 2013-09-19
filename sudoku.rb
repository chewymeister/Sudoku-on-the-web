require 'sinatra'
require_relative './lib/cell'
require_relative './lib/grid'
require_relative './lib/box'

enable :sessions

get '/' do
  @current_solution = random_sudoku
  erb :index
end

def random_sudoku
  seed = (1..9).to_a.shuffle + Array.new(81-9,0)
  sudoku = Grid.new(seed.join)
  sudoku.set_board
  sudoku.solve_board!
  sudoku.provide_puzzle
end

def puzzle sudoku
  random_index = (0..80).sample(40)
  random_index.map! do |index|
    sudoku[index] = '0'
  end
end

  sudoku
end