require "rspec"
require "./solver_sudoku.rb"

describe "solver_sudoku" do
  context "#verify_column" do
    context "the column has same number" do
      it "should return false" do
        matrix = [
          [8],
          [8],
          [5],
          [4],
          [9],
          [0],
          [7],
          [0],
          [0]
        ]

        result = SolverSudoku.new(matrix).verify_column(0 , 0)

        expect(result).to eq(false)
      end
    end
    context "the column has not same number" do
      it "should return true" do
        matrix = [
          [8],
          [7],
          [6],
          [3],
          [9],
          [4],
          [2],
          [1],
          [5]
        ]

        result = SolverSudoku.new(matrix).verify_column(0 , 0)

        expect(result).to eq(true)
      end
    end
  end

  context "#verify_row" do
    context "the row has same number" do
      it "should return false" do
        matrix = [
          [8, 0, 9, 7, 8, 6, 4, 2, 5],
        ]

        result = SolverSudoku.new(matrix).verify_row(0 , 4)

        expect(result).to eq(false)
      end
    end
    context "the row has not same number" do
      it "should return false" do
        matrix = [
          [0, 0, 9, 7, 8, 6, 4, 2, 5],
        ]

        result = SolverSudoku.new(matrix).verify_row(0 , 4)

        expect(result).to eq(true)
      end
    end
  end

  context "#verify_grid" do
    context "the grid has same number" do
      it "return false" do
        matrix = [
          [8, 1, 6 ],
          [3, 4, 9 ],
          [1, 5, 2 ]
        ]

        result = SolverSudoku.new(matrix).verify_grid(0 , 1)

        expect(result).to eq(false)
      end
    end
    context "the grid has not same number" do
      it "return true" do
        matrix = [
          [8, 1, 6 ],
          [3, 4, 9 ],
          [7, 5, 2 ],
        ]

        result = SolverSudoku.new(matrix).verify_grid(0 , 2)

        expect(result).to eq(true)
      end
    end
  end

  context "#sudoku_has_zeros" do
    context "sudoku has zeros" do
      it "should return true" do
        matrix = [
          [8, 0, 0, 0, 5, 0, 0, 0, 0],
          [0, 0, 9, 0, 0, 6, 4, 0, 0],
          [0, 6, 2, 1, 0, 0, 0, 9, 0],
          [0, 0, 6, 8, 0, 0, 0, 4, 0],
          [9, 0, 0, 0, 7, 0, 0, 0, 6],
          [0, 1, 0, 0, 0, 9, 7, 0, 0],
          [0, 7, 0, 0, 0, 4, 3, 5, 0],
          [0, 0, 8, 3, 0, 0, 9, 0, 0],
          [0, 0, 0, 0, 6, 0, 0, 0, 2]
        ]

        result = SolverSudoku.new(matrix).sudoku_has_zeros?

        expect(result).to eq(true)

      end
    end
    context "sudoku has not zeros" do
      it "should return false" do
        matrix = [
          [8, 4, 7, 9, 5, 2, 6, 3, 1],
          [1, 3, 9, 7, 8, 6, 4, 2, 5],
          [5, 6, 2, 1, 4, 3, 8, 9, 7],
          [7, 2, 6, 8, 3, 1, 5, 4, 9],
          [9, 8, 3, 4, 7, 5, 2, 1, 6],
          [4, 1, 5, 6, 2, 9, 7, 8, 3],
          [6, 7, 1, 2, 9, 4, 3, 5, 8],
          [2, 5, 8, 3, 1, 7, 9, 6, 4],
          [3, 9, 4, 5, 6, 8, 1, 7, 2]
        ]

        result = SolverSudoku.new(matrix).sudoku_has_zeros?

        expect(result).to eq(false)
      end
    end
  end

  context "try_other_positions" do
    context "the number has only one possibility" do
      it "should return cero" do
        matrix = [
          [8, 0, 0, 0, 5, 0, 0, 0, 0],
          [0, 0, 9, 0, 0, 6, 4, 0, 0],
          [0, 6, 2, 1, 0, 0, 0, 9, 0],
          [0, 0, 6, 8, 0, 0, 0, 4, 0],
          [9, 0, 0, 0, 7, 0, 0, 0, 6],
          [0, 1, 0, 0, 0, 9, 7, 0, 0],
          [0, 7, 0, 0, 0, 4, 3, 5, 0],
          [0, 0, 8, 3, 0, 0, 9, 0, 0],
          [0, 0, 0, 0, 6, 0, 0, 0, 2]
        ]

        result = SolverSudoku.new(matrix).try_other_positions(3, 0, 7)

        expect(result).to eq(0)
      end
    end
    context "the number has many possibility" do
      it "should return a nonzero number" do
        matrix = [
          [8, 0, 0, 0, 5, 0, 0, 0, 0],
          [0, 0, 9, 0, 0, 6, 4, 0, 0],
          [0, 6, 2, 1, 0, 0, 0, 9, 0],
          [0, 0, 6, 8, 0, 0, 0, 4, 0],
          [9, 0, 0, 0, 7, 0, 0, 0, 6],
          [0, 1, 0, 0, 0, 9, 7, 0, 0],
          [0, 7, 0, 0, 0, 4, 3, 5, 0],
          [0, 0, 8, 3, 0, 0, 9, 0, 0],
          [0, 0, 0, 0, 6, 0, 0, 0, 2]
        ]

        result = SolverSudoku.new(matrix).try_other_positions(0, 1, 1)

        expect(result).to eq(2)
      end
    end
  end

  context "#solver" do
    it "should return solution of the sudoku provider" do
      matrix = [
        [8, 0, 0, 0, 5, 0, 0, 0, 0],
        [0, 0, 9, 0, 0, 6, 4, 0, 0],
        [0, 6, 2, 1, 0, 0, 0, 9, 0],
        [0, 0, 6, 8, 0, 0, 0, 4, 0],
        [9, 0, 0, 0, 7, 0, 0, 0, 6],
        [0, 1, 0, 0, 0, 9, 7, 0, 0],
        [0, 7, 0, 0, 0, 4, 3, 5, 0],
        [0, 0, 8, 3, 0, 0, 9, 0, 0],
        [0, 0, 0, 0, 6, 0, 0, 0, 2]
      ]

      solution = [
        [8, 4, 7, 9, 5, 2, 6, 3, 1],
        [1, 3, 9, 7, 8, 6, 4, 2, 5],
        [5, 6, 2, 1, 4, 3, 8, 9, 7],
        [7, 2, 6, 8, 3, 1, 5, 4, 9],
        [9, 8, 3, 4, 7, 5, 2, 1, 6],
        [4, 1, 5, 6, 2, 9, 7, 8, 3],
        [6, 7, 1, 2, 9, 4, 3, 5, 8],
        [2, 5, 8, 3, 1, 7, 9, 6, 4],
        [3, 9, 4, 5, 6, 8, 1, 7, 2]
      ]

      result = SolverSudoku.new(matrix).solver

      expect(result).to eq(solution)
    end
  end
end
