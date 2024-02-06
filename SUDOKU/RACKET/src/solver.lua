--[[ 
Name: Aidan Wendorf
Email: aidan.j.wendorf@vanderbilt.edu
Date: Dec 5 2023
Course: PL
Honor statement: I attest that I understand the honor code
for this class and have neither
given nor received any unauthorized aid on this assignment.
--]]

-- Function to read a Sudoku board from a file and store it in a matrix
--[[
@param filename string The name of the file containing the Sudoku board
@return table A 2D matrix representing the Sudoku board
--]]
local function readSudokuBoard(filename)
    local matrix = {}

    local folder = "txt"  -- Adjust the folder name as needed
    local filepath = folder .. "/" .. filename
    local matrix = {}

    local file = io.open(filepath, "r")

    -- Check if the file was opened successfully
    if file then
        -- Read each line from the file
        for line in file:lines() do
            local row = {}
            
            -- Split the line into numbers
            for num in line:gmatch("%S+") do
                table.insert(row, tonumber(num))
            end

            -- Add the row to the matrix
            table.insert(matrix, row)
        end

        -- Close the file
        file:close()
    else
        -- Print an error message if the file couldn't be opened
        print("Error opening the file.")
    end

    return matrix
end

-- Check Row
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@param row number The row to check
@param num number The number to check for in the row
@return boolean true if the number is not present in the row, false otherwise
--]]
local function rowHasNotNum(sudoku, row, num)
    for column = 1, 9 do
        if sudoku[row][column] == num then
            return false
        end
    end
    return true
end

-- Check Column
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@param column number The column to check
@param num number The number to check for in the column
@return boolean true if the number is not present in the column, false otherwise
--]]
local function columnHasNotNum(sudoku, column, num)
    for row = 1, 9 do
        if sudoku[row][column] == num then
            return false
        end
    end
    return true
end

-- Check Box
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@param row number The row of the cell to check
@param column number The column of the cell to check
@param num number The number to check for in the box
@return boolean true if the number is not present in the box, false otherwise
--]]
local function boxHasNotNum(sudoku, row, column, num)
    local startRow = math.floor((row - 1) / 3) * 3 + 1
    local startColumn = math.floor((column - 1) / 3) * 3 + 1
    for i = 0, 2 do
        for j = 0, 2 do
            if sudoku[startRow + i][startColumn + j] == num then
                return false
            end
        end
    end
    return true
end

-- All three checks combined into one 
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@param row number The row of the cell to check
@param column number The column of the cell to check
@param num number The number to check for in the row, column, and box
@return boolean true if the number is not present in the row, column, and box, false otherwise
--]]
local function fullCheck(sudoku, row, column, num)
    return rowHasNotNum(sudoku, row, num)
        and columnHasNotNum(sudoku, column, num)
        and boxHasNotNum(sudoku, row, column, num)
end

-- Checks if the actual problem is solved.
-- If not, returns false, plus the location of the
-- first unassigned cell found.
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@return boolean true if the Sudoku puzzle is solved, false otherwise
@return number The row of the first unassigned cell (if not solved)
@return number The column of the first unassigned cell (if not solved)
--]]
local function isSolved(sudoku)
    for row = 1, 9 do
        for column = 1, 9 do
            if sudoku[row][column] == 0 then
                return false, row, column
            end
        end
    end
    return true
end

-- Sudoku solving via backtracking and recursion
-- sudoku  : a 2-dimensional grid of numbers (0-9)
--           0 matches unknown values to be found.
-- returns : true, if a solution was found,
--           false otherwise.
--[[
@param sudoku table 2D array representing the Sudoku puzzle
@return boolean true if a solution was found, false otherwise
--]]
local function solve(sudoku)
    local solved, row, column = isSolved(sudoku)
    if solved then
        return true
    end

    for num = 1, 9 do
        if fullCheck(sudoku, row, column, num) then
            sudoku[row][column] = num
            if solve(sudoku) then
                return true
            end
            sudoku[row][column] = 0
        end
    end

    return false
end

-- Export the functions you want to use in other files
return {
    readSudokuBoard = readSudokuBoard,
    solve = solve,
    isSolved = isSolved
    -- Add other functions if needed
}
