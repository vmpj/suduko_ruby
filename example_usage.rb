require './suduko_solver'

puzzle = Array[[0, 2, 0, 0, 0, 0, 0, 0, 0],
               [0, 0, 0, 6, 0, 0, 0, 0, 3],
               [0, 7, 4, 0, 8, 0, 0, 0, 0],
               [0, 0, 0, 0, 0, 3, 0, 0, 2],
               [0, 8, 0, 0, 4, 0, 0, 1, 0],
               [6, 0, 0, 5, 0, 0, 0, 0, 0],
               [0, 0, 0, 0, 1, 0, 7, 8, 0],
               [5, 0, 0, 0, 0, 9, 0, 0, 0],
               [0, 0, 0, 0, 0, 0, 0, 4, 0]]

puts "Puzzle:"
Suduko.print_board puzzle

puts "Solution:"
Suduko.print_board Suduko::SudukoSolver.solve(puzzle)

