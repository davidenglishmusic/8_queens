class Solver
  def initialize(board_dimension)
    @size = board_dimension
  end

  Spot = Struct.new(:x, :y)

  def solution_count
    solutions.count
  end

  def print_solutions
    solutions.each do |s|
      @board = {}
      (0..@size - 1).each do |y|
        (0..@size - 1).each do |x|
          @board["#{y}#{x}"] = s.include?(Spot.new(x, y)) ? 'Q' : '-'
          print @board["#{y}#{x}"]
        end
        puts
      end
      puts '--------------'
    end
  end

  private

  def solutions
    board_template = create_grid
    solutions = []

    board_template.first(@size).each do |top_row_spot|
      board = Marshal.load(Marshal.dump(board_template))
      check_next_spot(top_row_spot, board, @size, [top_row_spot], solutions)
    end

    solutions
  end

  def create_grid
    board = []
    (0..@size - 1).each do |y|
      (0..@size - 1).each do |x|
        board.push(Spot.new(x, y))
      end
    end
    board
  end

  def check_next_spot(spot, board, size, current_solution, solutions)
    size -= 1
    return solutions.push(current_solution.first(@size)) if current_solution.size == @size
    board = Marshal.load(Marshal.dump(board))
    remove_attackable_spots(spot, board)

    board.select { |other_spot| other_spot.y == spot.y + 1 }.each do |next_spot|
      next_solution = Marshal.load(Marshal.dump(current_solution)).push(next_spot)
      check_next_spot(next_spot, board, size, next_solution, solutions)
    end
  end

  def remove_current_row_spots(spot, board)
    board.reject! { |other_spot| other_spot.x == spot.x }
  end

  def remove_current_column_spots(spot, board)
    board.reject! { |other_spot| other_spot.y == spot.y }
  end

  def remove_diagonal_down_right_spots(spot, board)
    new_x = spot.x + 1
    new_y = spot.y + 1
    diagonal_spots = []
    while new_x < @size && new_y < @size
      diagonal_spots.push(Spot.new(new_x, new_y))
      new_x += 1
      new_y += 1
    end

    board.reject! { |other_spot| diagonal_spots.include? other_spot }
  end

  def remove_diagonal_down_left_spots(spot, board)
    new_x = spot.x - 1
    new_y = spot.y + 1
    diagonal_spots = []
    while new_x > - 1 && new_y < @size
      diagonal_spots.push(Spot.new(new_x, new_y))
      new_x -= 1
      new_y += 1
    end

    board.reject! { |other_spot| diagonal_spots.include? other_spot }
  end

  def remove_attackable_spots(spot, board)
    remove_current_row_spots(spot, board)
    remove_current_column_spots(spot, board)
    remove_diagonal_down_right_spots(spot, board)
    remove_diagonal_down_left_spots(spot, board)
  end
end
