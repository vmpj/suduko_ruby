
class SudukoSolver
  def self.solve(puzzle)
    backtracking_solver(puzzle)
  end

  def self.with_first_empty_cell(position)
    (0..8).each do |col|
      (0..8).each do |row|
        if position[row][col] == 0
          yield row, col
          return
        end
      end
    end
  end

  def self.done(position)
    position.detect { |row| row.include? 0 } ? false : true
  end

  def self.backtracking_solver(position)

    if done(position)
      return position if validate(position)
    end

    new_position = Marshal.load(Marshal.dump(position))
    with_first_empty_cell(position) do |row, col|
      (1..9).each do |value|
        new_position[row][col] = value
        if validate(new_position)
          solution = backtracking_solver(new_position)
          return solution if solution
        end
      end
    end

    false
  end

  def self.validate(position)
    return validate_column(position) && validate_row(position) && validate_groups(position)
  end

  def self.validate_column(position)
    (0..8).each do |col|
      (0..8).reduce({}) do |values, row|
        cell = position[row][col]
        return false if values[cell]
        values[cell] = true if cell != 0
        values
      end
    end
  end

  def self.validate_row(position)
    (0..8).each do |row|
      (0..8).reduce({}) do |values, col|
        cell = position[row][col]
        return false if values[cell]
        values[cell] = true if cell != 0
        values
      end
    end
  end

  def self.validate_groups(position)
    (0..6).step(3) do |group_row|
      (0..6).step(3) do |group_col|
        values = {}
        (0..2).each do |row_offset|
          row = group_row + row_offset
          (0..2).each do |col_offset|
            col = group_col + col_offset
            cell = position[row][col]
            return false if values[cell]
            values[cell] = true if cell != 0
          end
        end
      end
    end
    true
  end

end