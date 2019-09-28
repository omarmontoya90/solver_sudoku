class SolverSudoku
=begin
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

  solver = [
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

=end

  def initialize(matrix)
    @matrix = matrix
  end

  def solver
  end

  def draw_sudoku(matrix)
    matrix.each {|row| puts row.inspect }
  end

  #verify than in the column of number provided do not repeat numbers
  def verify_column(row, col)
    number = @matrix[row][col]
    verify = [*0..8].map do |n|
      @matrix[n][col].eql?(number)
    end
    verify.count(true).eql?(1)
  end

  #verify than in the row of number provided do not repeat numbers
  def verify_row(row, col)
    number = @matrix[row][col]
    verify = [*0..8].map do |n|
      @matrix[row][n].eql?(number)
    end
    verify.count(true).eql?(1)
  end

  #verify than in the grid of number provided do not repeat numbers
  def verify_grid(row, col)
    number = @matrix[row][col]
    sel_rows = [[*0..2], [*3..5], [*6..8]][row/3]
    sel_cols = [[*0..2], [*3..5], [*6..8]][col/3]

    verify = sel_rows.flat_map do |m|
        sel_cols.map do |n|
          @matrix[m][n].eql?(number)
      end
    end
    verify.count(true).eql?(1)
  end
end
