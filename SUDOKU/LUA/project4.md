# Project 4

## Name(s)

[Aidan Jinn Wendorf]

## Instructions on how to install compiler/interpreter

[Installing lua is split into 2 steps building lua and then installing it.

For Downloads and guides head to official lua site https://www.lua.org/download.html

Building Lua
In most common Unix-like platforms, simply do "make". Here are the details.

Open a terminal window and move to the top-level directory, which is named lua-5.4.6. The Makefile there controls both the build process and the installation process.
Do "make". The Makefile will guess your platform and build Lua for it.
If the guess failed, do "make help" and see if your platform is listed. The platforms currently supported are:
guess aix bsd c89 freebsd generic ios linux linux-readline macosx mingw posix solaris

If your platform is listed, just do "make xxx", where xxx is your platform name.

If your platform is not listed, try the closest one or posix, generic, c89, in this order.

The compilation takes only a few moments and produces three files in the src directory: lua (the interpreter), luac (the compiler), and liblua.a (the library).
To check that Lua has been built correctly, do "make test" after building Lua. This will run the interpreter and print its version.

Installing Lua
Once you have built Lua, you may want to install it in an official place in your system. In this case, do "make install". The official place and the way to install files are defined in the Makefile. You'll probably need the right permissions to install files, and so may need to do "sudo make install".

To build and install Lua in one step, do "make all install", or "make xxx install", where xxx is your platform name.

To install Lua locally after building it, do "make local". This will create a directory install with subdirectories bin, include, lib, man, share, and install Lua as listed below. To install Lua locally, but in some other directory, do "make install INSTALL_TOP=xxx", where xxx is your chosen directory. The installation starts in the src and doc directories, so take care if INSTALL_TOP is not an absolute path.
]

## Instructions on how to run (and test) program

[This Sudoku solver file directory is setup as the following

Root
    src
        main.lua
        solver.lua
    test
        test.lua
    txt
        sudoku-impossible.txt
        sudoku-test1.txt
        sudoku-test2.txt
        (and the solutions to these txt)

To run the program normally cd into either the root or the src file

    1) if you cd into the root all you need to do is run: lua src/main.lua and the program will begin to run

    2) if you cd into the src folder you all you need to do is run: lua main.lua

To Run the tests you following the same process except you run the files using

    1) lua src/test.lua

    2) lua test.lua

If you wish to add more tests then all you have to do is add your sudoku test files into the txt folder, then within the test file at the very bottom you can just add your additional tests in the same format of:

    totalTests = totalTests + 1
    if testImpossible("filename","solutionfilename") then
        passedTests = passedTests + 1
    end
]

## Questions

### 1. Did you use an LLM (e.g., ChatGPT) to assist you with the completion of this project?

[I used ChatGpt to help assist me in the process of this project]

### If yes, was it helpful or not? Provide a brief description of whether it was helpful or not. Also, provide a percentage of how much it helped you in each of the four main tasks (i.e., loading from a file, solving Sudoku, configuring the testing, configuring the GitHub Actions workflow).

[It was very helpful for the smaller sections of implemtation, my use cases were the following:

    1) helping in setting upn github actions (20%)
        * I had it proof read my github actions yml file and correct it where it found error
    2) resolving any question regarding lua syntax/file structure (40%)
        * For reading in a file I used it to help understand lua's version of include which is called required and the general format used to include functions from other files
    3) the creation of testing code for my program (50%)
        * For the creation of my testing code I gave ChatGpt an outline of my program and had it create a format for testing; I then used that format for my testing file code
    4) Solving Sudoku (10%)
        * I didn't really have to use ChatGpt for this section since my project 1 C++ was pretty easy to translate over into lua. The only help I got here were any lingering syntax questions
]

### If no, did you search the Internet for solutions? If so, provide the website(s) where you copied a considerable amount of code. For example, the website that you copied the core Sudoku solver.

[I most consulted the lua documenation and ebook which can be found here https://www.lua.org/pil/contents.html]

### 2. Provide a description of two constructs/features of the language that you found interesting (or was new to you) that you liked. Do not just list the constructs/features, but provide a description and why you liked them.

[Its closure system of end & it use of the then keyword (it gave a good sense of claity to the code), it lack of a ; or similar ending punctuation (since we have the end word the removal of ; just made coding feel more natural),and its for loop structure (I liked the ranging format instead of having to declare individual elements)]

### 3. Provide a description of two constructs/features of the language that you disliked or was hard to understand. Do not just list the constructs/features, but provide a description and why you disliked them.

[Did not enjoy how you shared functions within seperate files, I understand why you return but it just felt unintutitive to understand. Second while building lua on a unix/linux OS is very easy attemping to build lua on windows is probably one of the worst experiences I've had with product of this caliber. The documentation on how to install on windows is severaly out of date and information on the subject is clouded by either wrong or not useful websites/videos]