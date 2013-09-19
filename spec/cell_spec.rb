require 'cell'

describe Cell do
	let(:cell) {Cell.new 0}

  it 'checks to see if cell is empty' do
    expect(cell.filled_out?).to be_false
  end

  it 'has a list of candidates' do
    expect(cell.candidates).to be_an_instance_of Array
  end

  it 'assigns box index value given to it by box' do
    cell.assign_box_index 1

    expect(cell.box_index).to eq 1
  end

  it 'assigns row index value given to it by grid' do
    cell.assign_row 2

    expect(cell.row_index).to eq 2
  end

  it 'assigns column index value given to it by grid' do
    cell.assign_column 3

    expect(cell.column_index).to eq 3
  end

  it 'assigns neighbours when an array of neighbours is given to the cell' do
    cell.assign([1,2,3,4,5])

    expect(cell.neighbours).to match_array [1,2,3,4,5]
  end
  
  it 'takes away list of neighbours from candidates when called to by grid' do
    neighbours = [1,2,6,7,8,9]
    cell.attempt_to_solve neighbours
    expect(cell.candidates ).to match_array [3,4,5]
  end

  it 'when there is only one possibility left in candidates, it is assigned to value' do
    neighbours = [1,2,3,5,6,7,8,9]
    cell.attempt_to_solve neighbours

    expect(cell.filled_out?).to be_true
  end

  it 'assumes the candidate given to it by the try_harder! method' do
    cell.assume 7
    expect(cell.filled_out?).to be_true
  end

end

