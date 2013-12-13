require 'spec_helper'

describe Sudoku do
  let(:puzzle) {"209703810410205607875196023306520100100004359047309068000400980924867001050000002"}
  let(:sudoku) { Sudoku.new(puzzle) }

  it 'should have an array of cells' do
    expect(sudoku.cells).to be_instance_of Array
  end

  it 'should have 81 cells' do
    expect(sudoku.cells.count).to eq 81
  end

  it ''
end