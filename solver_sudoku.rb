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
    fill_sudoku
    draw_sudoku(@matrix)
    @matrix
  end

  def fill_sudoku
    [*0..8].each do |col|
      [*1..9].each do |number|
        [*0..8].each do |row|
          if @matrix[row][col].zero?
            @matrix[row][col] = number
            if satisfy_rules?(row, col) and try_other_positions(row, col, number).zero?
              @matrix[row][col] = number
            else
              @matrix[row][col] = 0
            end
          end
          draw_sudoku(@matrix)
          puts "#" *20
        end
      end
    end
    sudoku_has_zeros? ? fill_sudoku : return
  end

  def sudoku_has_zeros?
    verify = [*0..8].flat_map do |row|
               [*0..8].map do |col|
                 @matrix[row][col]
               end
             end
    verify.include?(0)
  end

  # check number possibilities
  def try_other_positions(row, col, number)
    counter = 0
    @matrix[row][col] = 0

    square_rows = calculate_square(row)
    square_cols = calculate_square(col)
    square_rows.flat_map do |m|
      square_cols.map do |n|
        if @matrix[m][n].zero?
          @matrix[m][n] = number
          if satisfy_rules?(m, n) and ( ( m!= row) or ( m == row and n != col) )
            counter+=1
          end
          @matrix[m][n] = 0
        end
      end
    end
    counter
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
    square_rows = calculate_square(row)
    square_cols = calculate_square(col)

    verify = square_rows.flat_map do |m|
      square_cols.map do |n|
        @matrix[m][n].eql?(number)
      end
    end
    verify.count(true).eql?(1)
  end

  private
  def draw_sudoku(matrix)
    matrix.each {|row| puts row.inspect }
  end

  def satisfy_rules?(row, col)
    verify_column(row, col) && verify_row(row, col) && verify_grid(row, col)
  end

  def calculate_square(position)
     [[*0..2], [*3..5], [*6..8]][position/3]
  end

end
