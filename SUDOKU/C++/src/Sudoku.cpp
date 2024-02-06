//; Name: Aidan Wendorf
//; Email: aidan.j.wendorf@vnaderbilt.edu
//; Date: Sep 24 2023
//; Course: PL
//; Honor statement: I attest that I understand the honor code
//; for this class and have neither
//; given nor received any unauthorized aid on this assignment.
#include "Sudoku.h"
#include <fstream>

/**
 * Constructor for Sudoku class.
 */
Sudoku::Sudoku()
{
}
/**
 * Loads the puzzle object with data from file.
 * Assume input file has format of nine rows of nine digits seperated by a space.
 * @param filename the name of the file to load the puzzle from.
 */
void Sudoku::loadFromFile(std::string filename)
{
    // need to open file
    std::ifstream infile;
    infile.open(filename);
    char nextToken;
    // need to read file into puzzle
    for (int i = 0; i < 9; i++) {
        for (int j = 0; j < 9; j++) {

            infile >> nextToken;
            puzzle[i][j] = nextToken - '0';
        }
    }
}

/** our format is
  4 3 |   8   | 2 5
6     |       |
      |     1 |   9 4
------+-------+------
9     |     4 |   7
      | 6   8 |
  1   | 2     |     3
------+-------+------
8 2   | 5     |
      |       |     5
  3 4 |   9   | 7 1
 */
/**
 * Prints the puzzle to the output stream.
 * @param os the output stream to print to.
 * @param puzzle the puzzle to print.
 * @return the output stream.
 */
std::ostream& operator<<(std::ostream& os, const Sudoku& puzzle)
{
    for (int i = 0; i < 9; i++) {
        if (i % 3 == 0 && i != 0) {
            os << "------+-------+------" << std::endl;
        }
        for (int j = 0; j < 9; j++) {
            if (j % 3 == 0 && j != 0) {
                os << "| ";
            }

            if (puzzle.puzzle[i][j] == 0) {
                os << " "
                   << " ";
            } else {
                os << puzzle.puzzle[i][j] << " ";
            }
        }
        os << std::endl;
    }
    return os;
}
/**
 * Determines if two puzzles are equal.
 * @param other the puzzle to compare to.
 * @return true if the puzzles are equal, false otherwise.
 */
bool Sudoku::equals(const Sudoku& other) const
{
    for (int i = 0; i < 9; i++) {
        for (int j = 0; i < 9; i++) {
            if (puzzle[i][j] != other.puzzle[i][j]) {
                return false;
            }
        }
    }
    return true;
}
/**
 * Solves the puzzle.
 * @return true if the puzzle was solved, false otherwise.
 */
bool Sudoku::solve()
{
    return recursiveSolve(0, 0);
}
/**
 * Determines if a number is safe to place in the puzzle.
 * @param row the row to check.
 * @param col the column to check.
 * @param num the number to check.
 * @return true if the number is safe to place, false otherwise.
 * @note this is a private helper function for recursiveSolve().
 */
bool Sudoku::isSafe(int row, int col, int num)
{
    // check row
    for (int i = 0; i < 9; i++) {
        if (puzzle[row][i] == num) {
            return false;
        }
    }
    // check col
    for (int i = 0; i < 9; i++) {
        if (puzzle[i][col] == num) {
            return false;
        }
    }
    // check box -> (if the number is already in that 3x3 box)
    int boxRow = row - row % 3;
    int boxCol = col - col % 3;
    for (int i = boxRow; i < boxRow + 3; i++) {
        for (int j = boxCol; j < boxCol + 3; j++) {
            if (puzzle[i][j] == num) {
                return false;
            }
        }
    }
    // if we get here then the number is safe to place
    return true;
}
/**
 * Recursively solves the puzzle.
 * @param row the row to start at.
 * @param col the column to start at.
 * @return true if the puzzle was solved, false otherwise.
 * @note this is a private helper function for solve().
 */
bool Sudoku::recursiveSolve(int row, int col)
{
    // base case
    if (row == 9) {
        return true;
    }
    // if the current spot is not empty
    if (puzzle[row][col] != 0) {
        if (col == 8) {
            return recursiveSolve(row + 1, 0);
        } else {
            return recursiveSolve(row, col + 1);
        }
    }
    for (int i = 1; i <= 9; i++) {
        if (isSafe(row, col, i)) {
            puzzle[row][col] = i;
            if (col == 8) {
                //  if we are at the end of the col
                if (recursiveSolve(row + 1, 0)) {
                    return true;
                }
            } else {
                //  if we are not at the end of the col
                if (recursiveSolve(row, col + 1)) {
                    return true;
                }
            }
        }
    }
    // if we get here then we need to backtrack
    puzzle[row][col] = 0;
    return false;
}
