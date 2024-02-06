![The Academic Honesty Policy posted on Brightspace is applicable to all work you do in CS 3270/5270](https://my.vanderbilt.edu/tairas/files/2023/08/academic-honor-policy-fall-2023.png)

# CS 3270: Programming Languages
## Project 3

## Goal

Gain experience in Prolog and logic programming.

## GitHub notes

Please see [GitHub notes](github-notes.md) for more information on cloning, committing, and pushing repositories.

## Style guidelines

* **Names:** Use proper style for names. The naming convention in Prolog is to separate multi-word names with underscores. For example, a predicate that determines if an element is a member of a list could be called `my_member`, a variable that represents a last name could be called `Last_Name`, and an atom that represents a particular book title could be called `tree_of_hands`. Also, use meaningful names. For example, a name representing speed should be called `speed` instead of just `s`.

* **Line lengths:** No lines should exceed 100 columns.

* **Indentation:** Use proper and consistent indentation. When separating out sub-goals of a single rule into multiple lines, use consistent indenting for all sub-goals after the first line of the rule.

* **Whitespace:** In this project, since you are only going to write one long rule, please include whitespace between groups of sub-goals (i.e., the terms in the body of the rule). That is, place an empty line after a group of sub-goals that performs a collective task.

* **Comments:** Since you are only going to write one long rule, provide a short descriptive comment before each unique group of sub-goals that that perform a collective task. The comments do not have to be in Java-doc style.

## Assignment

Create a **Sudoku** solver (same as earlier projects, only in Prolog this time).

Sudoku is a popular puzzle where you fill in numbers on a grid, trying to keep certain conditions true. To learn more about how Sudoku works, check out <http://en.wikipedia.org/wiki/Sudoku>. You'll find a sample puzzle and an explanation of the rules.

Write a Prolog program that reads a file containing an unfinished Sudoku puzzle, then solves the puzzle using a recursive backtracking algorithm. Similar to Project 2, you are being provided with the code to initialize a Sudoku board from a text file, to print the board, and to run the program. ***Hence, you are only tasked with writing the solver***.

The puzzle would be represented in your input as (this input file is in the form of a list of lists, with each row of data in a separate list – and note the final period):

```
[[_,4,3,_,8,_,2,5,_],
[6,_,_,_,_,_,_,_,_],
[_,_,_,_,_,1,_,9,4],
[9,_,_,_,_,4,_,7,_],
[_,_,_,6,_,8,_,_,_],
[_,1,_,2,_,_,_,_,3],
[8,2,_,5,_,_,_,_,_],
[_,_,_,_,_,_,_,_,5],
[_,3,4,_,9,_,7,1,_]].
```

When your program works out the solution, it should print it out to the screen in a slightly prettier fashion, such as:

```
 1 4 3 | 9 8 6 | 2 5 7
 6 7 9 | 4 2 5 | 3 8 1
 2 8 5 | 7 3 1 | 6 9 4
-------+-------+-------
 9 6 2 | 3 5 4 | 1 7 8
 3 5 7 | 6 1 8 | 9 4 2
 4 1 8 | 2 7 9 | 5 6 3
-------+-------+-------
 8 2 1 | 5 6 7 | 4 3 9
 7 9 6 | 1 4 3 | 8 2 5
 5 3 4 | 8 9 2 | 7 1 6
```

To run your solver, type `go.` at the Prolog prompt. **Note:** you must first update the `project_root` predicate with the absolute path of your project on your local computer. The current path setting is for a Windows computer. For Windows users, simply update the path with the appropriate folder names. For Mac users, use forward slashes. For example, suppose the project is located at /users/vandercc/cs3270/project3-vandercc/, then `Dir` should be unified to `/users/vandercc/cs3270/project3-vandercc/`.

If you want to run your solver on a different file, you can use the `start` predicate; e.g., type `start('txt/sudoku-test2.txt').` at the prompt. If a puzzle is not solvable, the solver should report `false.`.

The `sudoku.plt` file will test the two puzzles that were provided (`sudoku-test1.txt`, and `sudoku-test2.txt`). Run `consult` on `sudoku.plt` and then type `run_tests.` in the Prolog prompt. Note that we may test your submission on several more puzzles in addition to the two puzzles provided for you.

**Note:** everytime you make any changes to `sudoku.pl`, make sure to re-consult the file before running it again. You may also just type `make.` to update any consulted files that have changed.

## Solving Sudoku in Prolog

There are several different ways to solve this problem with Prolog. The easiest and most efficient way is to use an optimized library of predefined predicates meant for solving integer constraint problems. SWI-Prolog contains such a set of predicates in its Constraint Logic Programming over Finite Domains or CLP(FD) library. Follow the steps below to complete the `sudoku` rule at the bottom of `sudoku.pl`.

Let's start by specifying variables for every position in the Sudoku puzzle. The variables associated with known values (from the file) will be instantiated to those values. The other variables are unknown and will be determined by Prolog.

### Step 1

As the first term in the `sudoku` predicate, represent the Sudoku board with 81 unique variables. Note that we are representing a Sudoku puzzle by a list containing nine sub-lists, where each sub-list contains nine elements. Hence, the variables must be listed the same way in a list of lists. This list of lists should be unified with the `Board` variable (replace `...` with a list of lists of variables). Remember that variables must start with an uppercase letter.

```
    Board = ...,
```

### Step 2

The next term in the `sudoku` predicate will be some additional variables, where each of these variables represent a unique row of the puzzle. Since there are nine rows, include nine unique variables in a list. These should have different names from each other and from the 81 variables above. Just as the previous term, this list should also be unified with `Board`.

You should now have two terms both of which unify `Board` to lists of variables. Since both unify to `Board`, the first variable of the list generated in this step is automatically unified with the first sub-list of the list generated in Step 1. This is great, because the variables in the first sub-list represents the first row!

### Step 3

Now let's tell Prolog that the variables in each row must be all unique values. We'll use the `all_different` predicate from the CLP(FD) library. `all_different` accepts one argument, which should be a list. It returns true if the list contains no duplicate values. We will use the predicate to enforce that the values of the variables passed to it (as a list) are all different. Add a term that uses `all_different`.

```
    all_different(...),
```

What should we replace the `...` with to ensure that the first row in the puzzle has all different values? What variable did you specify in Step 2 that represents the first row? You simply pass that variable to `all_different`. But shouldn't the variable represent a list? It does! See the last paragraph of Step 2.

Since there are eight other rows, include eight more calls to `all_different` passing the different variables representing the remaining eight rows in the puzzle.

### Step 4

Now let's tell Prolog that the variables in each column must also be all unique values. We will use `all_different` again here. In the previous usage of `all_different`, we could pass `all_different` one variable, because we were able to specify each row with one variable. For columns, we'll manually write each variable for a column. Which variables that you specified in Step 1 are associated with the first column? There should be nine of them. Put these variables in a list and pass this list to `all_different`. The list should be a normal list containing nine elements. Do the same thing (with a different `all_different`) for the other columns.

### Step 5

By now, you should have used `all_different` 18 times. We'll use it nine more times for the submatrices. Similar to the columns, for each submatrix, pass a list of nine variables representing the submatrix to one call of `all_different`. Don't place the variables in sub-lists, just list them in a normal list.

### Step 6

The terms above gives Prolog the rules needed to solve Sudoku, namely unique values in each row, column, and submatrix. Now let's tell Prolog what to instantiate each variable with. We need to first create a list of all the 81 variables (from Step 1) into a list that is not nested. Use the `flatten` predicate to do this. The predicate accepts two arguments: a list that may be nested (i.e., that may contain sub-lists) and a flattened list containing all the elements of the first list. The first argument should be `Board`. For the second argument, specify a new variable for the flattened version of `Board`.

### Step 7

Next we need to specify the range of values for all the variables in the flattened list. Use the `ins` predicate to specify this. This predicate is written in infix notation, where the left operand is the (flattened) variable list and the right operand is the range of values that the variables must be instantiated to. Since we want values from 1 to 9, use `1..9` for the right operand. Remember that you can get the flattened list from the Step 6.

### Step 8

We (well, you) have now told Prolog which elements of the puzzle must have unique values ***and*** what the range of values can be. We just need to add one more term to tell Prolog to find the values for each unknown variable and hence produce a solved Sudoku puzzle. For this last term, use the `label` predicate. This predicate accepts one argument, which should be the flattened list (of variables) from Step 6..

### Step 9

Don't forget to include a period at the end to close the `sudoku` predicate.

Use the `go` predicate to check your work. You can also run the tests in `sudoku.plt` as specified above.

## Final notes

* Ensure that your name, VUnetID, email address, and the honor code statement appear in the header comments of files you altered.

* You must only update `sudoku.pl`. Do not alter any other files!

* All files necessary to run your program must reside in the GitHub.com repository.

* For full credit, your program must pass the build on GitHub. You will have to push to GitHub in order to trigger a build.
