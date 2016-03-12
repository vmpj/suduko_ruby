# Introduction

A simple implementation of ruby suduko solver using the [backtracking algorithm](https://en.wikipedia.org/wiki/Sudoku_solving_algorithms#Backtracking).

The algoritm is implemented as a class in `suduko_solver.rb`. It was tested with the *No Fun* example from [this site](http://dingo.sbs.arizona.edu/~Sandiway/sudoku/examples.html)

# Example Usage

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

Output:

    Puzzle:
    -------------------------
    |   2   |       |       |
    |       | 6     |     3 |
    |   7 4 |   8   |       |
    -------------------------
    |       |     3 |     2 |
    |   8   |   4   |   1   |
    | 6     | 5     |       |
    -------------------------
    |       |   1   | 7 8   |
    | 5     |     9 |       |
    |       |       |   4   |
    -------------------------
    Solution:
    -------------------------
    | 1 2 6 | 4 3 7 | 9 5 8 |
    | 8 9 5 | 6 2 1 | 4 7 3 |
    | 3 7 4 | 9 8 5 | 1 2 6 |
    -------------------------
    | 4 5 7 | 1 9 3 | 8 6 2 |
    | 9 8 3 | 2 4 6 | 5 1 7 |
    | 6 1 2 | 5 7 8 | 3 9 4 |
    -------------------------
    | 2 6 9 | 3 1 4 | 7 8 5 |
    | 5 4 8 | 7 6 9 | 2 3 1 |
    | 7 3 1 | 8 5 2 | 6 4 9 |
    -------------------------

# Run the tests

    bundle install
    rspec
  

