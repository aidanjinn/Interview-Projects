--[[ 
Name: Aidan Wendorf
Email: aidan.j.wendorf@vanderbilt.edu
Date: Dec 5 2023
Course: PL
Honor statement: I attest that I understand the honor code
for this class and have neither
given nor received any unauthorized aid on this assignment.
--]]

-- Import the Sudoku functions
local sudokuFunctions = require("src.solver")

-- Compare two tables element-wise
--[[
@param table1 table First table to compare
@param table2 table Second table to compare
@return boolean true if the tables are equal element-wise, false otherwise
--]]
local function tablesEqual(table1, table2)
    if #table1 ~= #table2 then
        return false
    end

    for i, row in ipairs(table1) do
        for j, value in ipairs(row) do
            if value ~= table2[i][j] then
                return false
            end
        end
    end

    return true
end

-- Function to test if solving the Sudoku is impossible
--[[
@param filename string The name of the file containing the Sudoku board
@return boolean true if the Sudoku is correctly identified as impossible, false otherwise
--]]
local function testImpossible(filename)
    local isSolvable = sudokuFunctions.solve(sudokuFunctions.readSudokuBoard(filename))
    
    if not isSolvable then
        print("\nTest Passed! Solving is correctly identified as impossible.")
        return true
    else
        print("\nTest Failed! Solving is incorrectly identified as possible.")
        return false
    end
end

-- Function to compare the solved Sudoku with the expected solution
--[[
@param filename string The name of the file containing the Sudoku board
@param expectedFilename string The name of the file containing the expected solution
@return boolean true if the Sudoku solutions match, false otherwise
--]]
local function testSudoku(filename, expectedFilename)
    local sudokuBoard = sudokuFunctions.readSudokuBoard(filename)

    if sudokuFunctions.solve(sudokuBoard) then
        local expectedSolution = sudokuFunctions.readSudokuBoard(expectedFilename)

        -- Compare the solved Sudoku with the expected solution
        if tablesEqual(sudokuBoard, expectedSolution) then
            print("\nTest Passed! Solutions match.")
            return true
        else
            print("\nTest Failed! Solutions do not match.")
            return false
        end
    else if testImpossible(filename) then
        -- Test impossible cases
        print("\nTest Passed! Solving is correctly identified as impossible.")
        return true
    end
    return false
    end
end

-- Function to run tests and calculate the score
local function runTests()
    local totalTests = 0
    local passedTests = 0

    -- Run tests for each Sudoku file
    totalTests = totalTests + 1
    if testSudoku("sudoku-test1.txt", "sudoku-test1-solution.txt") then
        passedTests = passedTests + 1
    end

    totalTests = totalTests + 1
    if testSudoku("sudoku-test2.txt", "sudoku-test2-solution.txt") then
        passedTests = passedTests + 1
    end

    totalTests = totalTests + 1
    if testImpossible("sudoku-impossible.txt") then
        passedTests = passedTests + 1
    end

    -- Calculate the score
    local score = (passedTests / totalTests) * 100
    print("\nTest Score: " .. score .. "% (" .. passedTests .. " out of " .. totalTests .. " tests passed)")
end

-- Run the tests and calculate the score
runTests()
