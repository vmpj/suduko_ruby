require 'rspec'
require './suduko_solver'

describe Suduko::SudukoSolver do

  let(:puzzle) do
    Array[[3, 0, 6, 5, 0, 8, 4, 0, 0],
          [5, 2, 0, 0, 0, 0, 0, 0, 0],
          [0, 8, 7, 0, 0, 0, 0, 3, 1],
          [0, 0, 3, 0, 1, 0, 0, 8, 0],
          [9, 0, 0, 8, 6, 3, 0, 0, 5],
          [0, 5, 0, 0, 9, 0, 6, 0, 0],
          [1, 3, 0, 0, 0, 0, 2, 5, 0],
          [0, 0, 0, 0, 0, 0, 0, 7, 4],
          [0, 0, 5, 2, 0, 6, 3, 0, 0]]
  end

  let(:solution) do
    Array[[3, 1, 6, 5, 7, 8, 4, 9, 2],
          [5, 2, 9, 1, 3, 4, 7, 6, 8],
          [4, 8, 7, 6, 2, 9, 5, 3, 1],
          [2, 6, 3, 4, 1, 5, 9, 8, 7],
          [9, 7, 4, 8, 6, 3, 1, 2, 5],
          [8, 5, 1, 7, 9, 2, 6, 4, 3],
          [1, 3, 8, 9, 4, 7, 2, 5, 6],
          [6, 9, 2, 3, 5, 1, 8, 7, 4],
          [7, 4, 5, 2, 8, 6, 3, 1, 9]]
  end

  let(:puzzle_no_fun) do
    Array[[0, 2, 0, 0, 0, 0, 0, 0, 0],
          [0, 0, 0, 6, 0, 0, 0, 0, 3],
          [0, 7, 4, 0, 8, 0, 0, 0, 0],
          [0, 0, 0, 0, 0, 3, 0, 0, 2],
          [0, 8, 0, 0, 4, 0, 0, 1, 0],
          [6, 0, 0, 5, 0, 0, 0, 0, 0],
          [0, 0, 0, 0, 1, 0, 7, 8, 0],
          [5, 0, 0, 0, 0, 9, 0, 0, 0],
          [0, 0, 0, 0, 0, 0, 0, 4, 0]]
  end

  let(:no_fun_solution) do
    Array[[1, 2, 6, 4, 3, 7, 9, 5, 8],
          [8, 9, 5, 6, 2, 1, 4, 7, 3],
          [3, 7, 4, 9, 8, 5, 1, 2, 6],
          [4, 5, 7, 1, 9, 3, 8, 6, 2],
          [9, 8, 3, 2, 4, 6, 5, 1, 7],
          [6, 1, 2, 5, 7, 8, 3, 9, 4],
          [2, 6, 9, 3, 1, 4, 7, 8, 5],
          [5, 4, 8, 7, 6, 9, 2, 3, 1],
          [7, 3, 1, 8, 5, 2, 6, 4, 9]]
  end


  let(:one_empty_cell) do
    m = Array.new(9) { Array.new(9, 1) }
    m[4][5] = 0
    m
  end

  describe "#solve" do
    it 'solves suduko puzzles' do
      expect(described_class().solve(puzzle)).to eq(solution)
      expect(described_class().solve(puzzle_no_fun)).to eq(no_fun_solution)
    end
  end

  describe "#backtracking_solver" do
    context 'when given a completed puzzle' do
      subject { Suduko::SudukoSolver.backtracking_solver(solution) }
      it { is_expected.to eq(solution) }
    end

    context 'when given a puzzle with one blank box' do
      let(:oneblank) do
        m = Marshal.load(Marshal.dump(solution))
        m[0][0] = 0
        m
      end
      subject { Suduko::SudukoSolver.backtracking_solver(oneblank) }
      it { is_expected.to eq(solution) }
    end

    context 'when given a puzzle with two blank boxes' do
      let(:twoblank) do
        m = Marshal.load(Marshal.dump(solution))
        m[0][0] = 0
        m[0][1] = 0
        m
      end
      subject { Suduko::SudukoSolver.backtracking_solver(twoblank) }
      it { is_expected.to eq(solution) }
    end

    context 'when given an unsolvable puzzle' do
      let(:unsolvable) do
        m = Array.new(9) { Array.new(9, 1) }
        m[4][5] = 0
        m
      end
      subject { Suduko::SudukoSolver.backtracking_solver(unsolvable) }
      it { is_expected.to eq(false) }
    end
  end

  describe "#validate" do
    context 'when given a validate position' do
      subject { Suduko::SudukoSolver.validate(puzzle) }
      it { is_expected.to be_truthy }
    end

    context 'when given an invalidate column position' do

      let(:invalid_column) do
        m = Array.new(9) { Array.new(9, 0) }
        m[0][0] = 1
        m[1][0] = 1
        m
      end

      subject { Suduko::SudukoSolver.validate(invalid_column) }
      it { is_expected.to be_falsey }
    end

    context 'when given an invalidate row position' do

      let(:invalid_row) do
        m = Array.new(9) { Array.new(9, 0) }
        m[0][0] = 1
        m[0][1] = 1
        m
      end

      subject { Suduko::SudukoSolver.validate(invalid_row) }
      it { is_expected.to be_falsey }
    end

    context 'when given an invalidate group position' do
      context 'in group 0' do
        let(:invalid_group0) do
          m = Array.new(9) { Array.new(9, 0) }
          m[0][0] = 1
          m[1][1] = 1
          m
        end

        subject { Suduko::SudukoSolver.validate(invalid_group0) }
        it { is_expected.to be_falsey }
      end

      context 'in group 8' do
        let(:invalid_group8) do
          m = Array.new(9) { Array.new(9, 0) }
          m[6][6] = 1
          m[8][8] = 1
          m
        end

        subject { Suduko::SudukoSolver.validate(invalid_group8) }
        it { is_expected.to be_falsey }
      end
    end
  end

  describe "#done" do

    context 'when given a position with one empty cell' do
      subject { Suduko::SudukoSolver.done(one_empty_cell) }
      it { is_expected.to be_falsey }
    end

    context 'when given a position with no empty cells' do
      subject { Suduko::SudukoSolver.done(solution) }
      it { is_expected.to be_truthy }
    end
  end


  describe "#with_empty_cell" do
    context 'when given a position with one empty cell' do
      specify { expect { |b| Suduko::SudukoSolver.with_first_empty_cell(one_empty_cell, &b) }.to yield_with_args(4, 5) }
    end
    context 'when given a position with no empty cells' do
      let(:no_empty_cells) do
        Array.new(9) { Array.new(9, 1) }
      end
      subject { Suduko::SudukoSolver.with_first_empty_cell(no_empty_cells) }
      it { is_expected.to be_truthy }
    end
  end
end