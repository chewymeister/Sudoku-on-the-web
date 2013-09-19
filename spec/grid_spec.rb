require 'grid'

describe Grid do
  let(:puzzle) {"209703810410205607875196023306520100100004359047309068000400980924867001050000002"}
  let(:hard_puzzle) {"800000000003600000070090200050007000000045700000100030001000068008500010090000400"}
  let(:grid) {Grid.new puzzle}
  let(:hard_grid) {Grid.new hard_puzzle}
  let(:board) {grid.board}
  let(:hard_board) {hard_grid.board}
  before {grid.set_board}
  before {hard_grid.set_board}

  it 'fills a board with 81 instances of the cell class' do
    expect(grid.board.flatten.all? {|cell| cell.is_a?(Cell)} ).to be_true
  end
  it 'checks that the board is an array' do
    expect(grid.board).to be_an_instance_of Array
  end

  it 'find the value at each cell' do
    expect(board[0][0].value).to eq 2
    expect(hard_board[0][0].value).to eq 8
  end
  
  it 'returns 9 cells when row is called' do
    expect(grid.fetch_row(2).count).to eq 9
    expect(grid.fetch_row(1).all? { |row| row.is_a?(Cell)}).to be_true
  end

  it 'returns 9 cells when column is called' do
    expect(grid.fetch_column(3).count).to eq 9
    expect(grid.fetch_column(2).all? {|column| column.is_a?(Cell)}).to be_true
  end

  it 'returns the contents of a specific box' do
    expect(grid.board[0][2].box_index).to eq 1
    expect(grid.board[5][8].box_index).to eq 6
  end

  it 'returns the cells box index value' do
    expect(grid.board[3][8].box_index).to eq 6
  end
  
  it 'returns an array of cells located in the appropriate box' do
    box_2 = grid.fetch_box 2
    expect(box_2).to be_an_instance_of Array
  end

  it 'verifies there are only 9 elements after fetching a box' do
    box_3 = grid.fetch_box 3
    expect(box_3.flatten.count).to eq 9
  end

  it 'matches the correct neighbours for box index' do
    grid.solve_board!
    box_1 = grid.fetch_box 1
    expect(grid.get_cell_values_from box_1 ).to eq [2,6,9,4,1,3,8,7,5]
  end

  it 'verfies the box index after retrieving the box' do
    box_4 = grid.fetch_box 4
    expect(box_4.flatten.each {|cell| cell.box_index == 4}).to be_true
  end

  it 'assigns row indexes to each cell' do

    expect(grid.board[4][6].row_index).to eq 4
    expect(grid.board[6][2].row_index).to eq 6
  end

  it 'assigns column indexes to each cell' do

    expect(grid.board[3][2].column_index).to eq 2
  end

  it 'sets the board ready for adding neighbours and solving' do

    expect(grid.board[4][6].column_index).to eq 6
    expect(grid.board[7][2].row_index).to eq 7
    expect(grid.board[3][4].box_index).to eq 5
  end

  it 'assigns neighbours to the cell' do
    grid.assign_neighbours_to board[0][0]
    hard_grid.assign_neighbours_to hard_board[7][2]


    expect(board[0][0].neighbours).to match_array [2,0,9,7,0,3,8,1,0,2,4,8,3,1,0,0,9,0,2,0,9,4,1,0,8,7,5]
    expect(hard_board[7][2].neighbours).to match_array [0,0,8,5,0,0,0,1,0,0,3,0,0,0,0,1,8,0,0,0,1,0,0,8,0,9,0]
  end

  it 'iterates once through and attempts to solve the board' do
    first_iteration = grid.get_cell_values_from board
    grid.solve
    second_iteration = grid.get_cell_values_from board
  
    expect(first_iteration).not_to eq second_iteration
  end

  it 'checks to see if the entire grid has been solved' do
    grid.solve
   
    expect(grid.solved?).to be_false
  end

  it 'displays the whole grid' do
    grid.inspect_board
  end

  it 'it solves the entire grid' do
    grid.solve_board!
    grid.inspect_board
  
    expect(grid.solved?).to be_true
  end

  it 'creates board string' do
    expect(grid.create_current_puzzle_string_of board).to be_an_instance_of String
  end

  it 'creates a new copy of a board' do
    expect(grid.replicate(board)).to be_an_instance_of Grid
  end

  it 'solves a hard board' do
    hard_grid.inspect_board
    hard_grid.solve_board!
    hard_grid.inspect_board

    expect(hard_grid.solved?).to be_true
  end

  it 'provides a puzzle' do
    grid.solve_board!

    expect(grid.provide_puzzle.count).to eq 81
  end

  it 'provides the correct values of puzzle in an array' do
    grid.solve_board!

    expect(grid.provide_puzzle).to eq [2,6,9,4,1,3,8,7,5,7,4,3,2,8,5,1,9,6,8,1,5,6,9,7,4,2,3,3,9,6,1,8,2,5,4,7,5,2,8,6,7,4,3,1,9,1,7,4,3,5,9,2,6,8,7,3,1,9,2,4,6,5,8,4,5,2,8,6,7,9,3,1,9,8,6,5,3,1,7,4,2]
  end
end


