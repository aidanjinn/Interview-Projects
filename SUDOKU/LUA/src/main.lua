--[[ 
Name: Aidan Wendorf
Email: aidan.j.wendorf@vanderbilt.edu
Date: Dec 5 2023
Course: PL
Honor statement: I attest that I understand the honor code
for this class and have neither
given nor received any unauthorized aid on this assignment.
--]]

-- Import all functions from sudoku_functions.lua
local sudokuFunctions = require("src.solver")

-- Get the filename from the user
print("Enter the Sudoku file name:")
local filename = io.read()
local sudoku = sudokuFunctions.readSudokuBoard(filename)

--[[ 
Function to print the Sudoku board in the specified format

@param sudoku table 2D array representing the Sudoku puzzle
@return none
--]]
local function printSudokuBoard(sudoku)
    print("Original Sudoku:")
    for i, row in ipairs(sudoku) do
        for j, num in ipairs(row) do
            io.write(num, " ")
            if j % 3 == 0 and j < 9 then
                io.write("| ")
            end
        end
        io.write("\n")
        if i % 3 == 0 and i < 9 then
            print("------+-------+------")
        end
    end
end

-- Assuming 'sudoku' is a 9x9 matrix representing the Sudoku puzzle

-- Call the printSudokuBoard function
printSudokuBoard(sudoku)

-- Solve the Sudoku using the imported function
if sudokuFunctions.solve(sudoku) then
    print("\nSolved Sudoku:")
    -- Print the solved Sudoku matrix using the same function
    printSudokuBoard(sudoku)
else
    print("\nNo solution found.")
end
