require 'box'

describe Box do

	let(:box) {Box.new}
	let(:board) {Array.new(9) {Array.new(9) {Cell.new 0} } }

	it 'assigns index value 1 to cells beloning to box 1' do
    box.assign_box_indices board
    
    expect(board[0][0].box_index).to eq 1
    expect(board[2][2].box_index).to eq 1
  end

  it 'returns the correct range' do
    expect(box.row_range(1)).to eq 0..2
    expect(box.column_range(1)).to eq 0..2
  end
  
  it 'does not assign index values to those that have not been iterated over' do
    box.assign_box_indices board
    
    expect(board[8][8].box_index).to eq 9
  end

  it 'assigns all box index values' do
    box.assign_box_indices board

    expect(board[0][0].box_index).to eq 1
    expect(board[2][2].box_index).to eq 1
    expect(board[5][8].box_index).to eq 6
  end

end