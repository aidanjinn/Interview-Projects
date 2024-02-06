%% CS 3270 instructor
%% Vanderbilt University

:- ['sudoku.pl'].

:- begin_tests(sudoku).

test_puzzle(Name, Board, Expected) :-
    % Get absolute path to project on local computer.
    project_root(Dir),

    % Go to project folder.
    cd(Dir),

    % Read unsolved puzzle text file.
    atom_concat('txt/sudoku-', Name, Temp),
    atom_concat(Temp, '.txt', Unsolved),
    see(Unsolved),
    read(Board),
    seen,

    % Solve puzzle.
    sudoku(Board),

    % Read solved puzzle text file.
    atom_concat(Temp, '-solution.txt', Solved),
    see(Solved),
    read(Expected),
    seen,

    % If board not equal, print message.
    (
        % Equal, do nothing.
        Board == Expected;

        % Not equal, print board and expected board.
        Board \= Expected, nl,

        % Print given board.
        write('Board given by solver:'), pretty_sudo_print(Board), nl, nl,
        write('Expected board:'), pretty_sudo_print(Expected)
    ),
    !.

test(sudoku1, Board == Expected) :-
    test_puzzle('test1', Board, Expected).

test(sudoku2, Board == Expected) :-
    test_puzzle('test2', Board, Expected).

:- end_tests(sudoku).