// R. Tairas - CS 3270 - Vanderbilt University

#ifndef TESTHELPER_H
#define TESTHELPER_H

#include "Sudoku.h"
#include <gtest/gtest.h>

/**
 * Returns the string that is printed to an output stream.
 *
 * @param  puzzle The Sudoku puzzle.
 * @return A string representation of the puzzle.
 */
inline std::string getString(const Sudoku& puzzle)
{
    std::ostringstream stream;
    stream << puzzle;
    return stream.str();
}

/**
 *  Pretty print message on puzzle that was not solved correctly.
 *
 * @param  name     The name of the puzzle.
 * @param  puzzle   The state of the puzzle that was incorrect.
 * @param  solution The expected state of the puzzle.
 */
inline void printExpected(std::string name, const Sudoku& puzzle, const Sudoku& solution)
{
    std::cout << std::endl << "Attempt to solve \"" << name << "\" failed." << std::endl;
    std::cout << "Actual:" << std::endl;
    std::cout << puzzle;
    std::cout << "Expected:" << std::endl;
    std::cout << solution;
}

/**
 * Pretty print the timing of a task.
 *
 * @param  startTime The start time of the task.
 * @param  endTime   The end time of the completion of the task.
 */
inline void printTiming(int startTime, int endTime)
{
    std::cout << "[xxxxxxxxxx] Manual timing: " << (endTime - startTime) / (double)CLOCKS_PER_SEC;
    std::cout << " seconds." << std::endl;
}

#endif // TESTHELPER_H