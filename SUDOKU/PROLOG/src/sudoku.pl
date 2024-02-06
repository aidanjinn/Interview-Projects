/*This line is supposed to be a comment. Is it?*/

/*Name: Aidan Wendorf
% Email: aidan.j.wendorf@vanderbilt.edu
% Date: Nov 24 2023
% Course: PL
% Honor statement: I attest that I understand the honor code
% for this class and have neither
% given nor received any unauthorized aid on this assignment.
*/


% Use routines from the Constraint Logic Programming over Finite Domains library.
:- use_module(library('clpfd')).


% The main entry point. Enter "go." at the Prolog prompt.
% 
go :-
    File = 'txt/sudoku-test1.txt',
    start(File).


% The absolute path of the root folder of the project.
% NOTE: MUST BE CHANGED TO THE ABSOLUTE PATH OF ROOT FOLDER OF YOUR PROJECT ON YOUR LOCAL COMPUTER.
%       MAC USERS: USE FORWARD SLASH '/'
%
project_root(Dir) :-
    Dir = '/Users/aidanwendorf/project3-aidanjinn/'.


% To test other than 'sudoku-test1.txt', pass the text file name preceded by 'txt/'.
% For example, enter "start('txt/sudoku-test2.txt')."
%
start(File) :-
    project_root(Dir),                       % Get absolute path to root folder of project.
    atom_concat(Dir, File, PuzzleFile),      % Concatenate path with text file relative location.
    see(PuzzleFile),                         % Open file.
    write(trying_file(PuzzleFile)), nl, nl,  % Display puzzle.
    read(Board),                             % Read board.
    seen,                                    % Close file.
    time(sudoku(Board)),                     % Call solver (with timer).
    pretty_sudo_print(Board), nl.            % Printed solution.


% Print the board to the screen, where each row printed using printsudorow.
%
pretty_sudo_print(Board) :-
    Board = [R1, R2, R3, R4, R5, R6, R7, R8, R9],
    nl, nl,
    printsudorow(R1),
    printsudorow(R2),
    printsudorow(R3),
    write('-------+-------+-------'), nl,
    printsudorow(R4),
    printsudorow(R5),
    printsudorow(R6),
    write('-------+-------+-------'), nl,
    printsudorow(R7),
    printsudorow(R8),
    printsudorow(R9).


% Print row by printing each column.
%
printsudorow(Row) :-
    Row = [C1,C2,C3,C4,C5,C6,C7,C8,C9],
    write(' '),
    write(C1), write(' '),
    write(C2), write(' '),
    write(C3), write(' '), write('|'), write(' '),
    write(C4), write(' '),
    write(C5), write(' '),
    write(C6), write(' '), write('|'), write(' '),
    write(C7), write(' '),
    write(C8), write(' '),
    write(C9), write(' '), nl.

% Base case for the create_blocks/4 predicate.
create_blocks([], [], [], []).

% Recursive case for the create_blocks/4 predicate.
create_blocks([A,B,C|RowTail1],[D,E,F|RowTail2],[G,H,I|RowTail3], [Block|BlocksTail]) :-
    % Create a block by combining the first three elements from each row.
    Block = [A,B,C,D,E,F,G,H,I],
    % Recursively process the remaining elements.
    create_blocks(RowTail1, RowTail2, RowTail3, BlocksTail).

% Helper predicate to divide a 9-element list into three blocks.
divide_into_blocks([A,B,C,D,E,F,G,H,I], Blocks) :-
    % Recursively apply create_blocks/4 to divide the list into three sub-blocks.
    create_blocks(A,B,C,Block1), create_blocks(D,E,F,Block2), create_blocks(G,H,I,Block3),
    % Combine the three sub-blocks into the final list of blocks.
    append([Block1, Block2, Block3], Blocks).

% Main solver containing the rules to solve Sudoku.
sudoku(Puzzle) :-
    % Flatten the Puzzle matrix and constrain each element to be in the range 1..9.
    flatten(Puzzle, FlattenedPuzzle), FlattenedPuzzle ins 1..9,
    % Alias for the Rows matrix.
    Rows = Puzzle,
    % Transpose the Rows matrix to obtain the Columns matrix.
    transpose(Rows, Columns),
    % Divide the Rows matrix into blocks (subgrids).
    divide_into_blocks(Rows, Blocks),
    % Originally used all_different but found using maplist was easier and looked better
    % Ensure that each row has distinct values.
    maplist(all_distinct, Rows),
    % Ensure that each column has distinct values.
    maplist(all_distinct, Columns),
    % Ensure that each block has distinct values.
    maplist(all_distinct, Blocks),
    % Use the label predicate to assign values to variables and find a solution.
    maplist(label, Rows).
