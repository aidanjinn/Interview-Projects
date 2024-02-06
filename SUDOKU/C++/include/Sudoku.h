//; Name: Aidan Wendorf
//; Email: aidan.j.wendorf@vnaderbilt.edu
//; Date: Sep 24 2023
//; Course: PL
//; Honor statement: I attest that I understand the honor code
//; for this class and have neither
//; given nor received any unauthorized aid on this assignment.
#include <iostream>
#ifndef SUDOKU_H
#define SUDOKU_H
class Sudoku {

public:
    int puzzle[9][9];
    // Things We need:
    //  default ctor for sudoku size 9x9 = 81 slots starts with 81 zeros
    Sudoku();
    // loadfromfile(std::string filename) - loads the puzzle object with data from file
    // assume input file has format of nine rows of nine digits seperated by a space
    void loadFromFile(std::string filename);
    // bool solve returns if solution is found
    bool solve();
    // bool equals(const Sudoku& other) const determines if two puzzles are equal
    bool equals(const Sudoku& other) const;
    // std::ostream& operator<<(std::ostream& os, const Sudoku& puzzle) prints the puzzle to the
    //  output stream
    friend std::ostream& operator<<(std::ostream& os, const Sudoku& puzzle);

private:
    // private helper functions
    bool isSafe(int row, int col, int num);
    bool recursiveSolve(int row, int col);
};
#endif // SUDOKU_H