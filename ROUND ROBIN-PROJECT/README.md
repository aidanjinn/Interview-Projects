[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/cVDpfTWG)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=12341676&assignment_repo_type=AssignmentRepo)
# Assignment 5: Scheduling

In this assignment, you will develop a new scheduling algorithm in xv6. You will implement a simple, real-time scheduling algorithm known as fixed-priority scheduling.

The xv6 kernel comes with a simple, global, round robin scheduler. In this scheduling algorithm, each process is scheduled with equal priority. Each process runs until it yields, completes, or is interrupted, and the scheduler chooses the next process to continue execution. This repeats until all processes have been scheduled, and then the cycle starts over again.

In fixed-priority scheduling, each process is assigned a priority, and processes with higher priorities are scheduled before those with lower priorities. This is valuable in real-time systems where there may be some processes that are more time-critical than others. In this assignment, you will implement a fixed-priority scheduler in xv6 and explore the tradeoffs between fixed-priority and round-robin scheduling.


## Tasks

### 1. Create syscall to set priorities

In round-robin scheduling, every task has the same priority. To support alternative prioritizations, there must be a mechanism by which the priority of a process is communicated to the kernel.

Your first task is to modify xv6 to create a new system call that allows a process to set its scheduling priority.

Some hints:

* Recall how to setup a new system call from previous assignments.
* Carefully inspect the existing scheduler `void scheduler(void)` in `kernel/proc.c` to see how round-robin scheduling is implemented.
* Think about how and where to store the priority of each process.
* Only allow priority values between 1-10, inclusive, to be set. Return a value of `-1` from the syscall in case of an error.


### 2. Implement fixed-priority scheduling

Implement global fixed-priority scheduling. In other words, if there are *m* CPUs in the system, then the highest-priority *m* processes should be scheduled at any point in time. If two or more processes have the same priority, and that priority is the highest, then scheduling any one of them is valid.

Some hints:

* Your scheduling algorithm will need to use priorities to make scheduling decisions. You need to make sure that **all processes** get assigned a priority.
  * When a new process is created with `fork()` it should have the same scheduling priority as its parent. (This can be changed later using your new system call)
  * Any processes that do not have a parent (e.g., the `init` process) should be assigned a default priority of 5.
  * **Important Note:** Lower numbers indicate higher priority processes. In other words, assigning a priority of `1` will result in a process having the highest possible priority. Conversely, assigning a priority of `10` will result in a process having the lowest possible priority.
* You do not need to implement complex data structures to efficiently implement a priority queue. Your scheduling algorithm may have *O(n)* time complexity where *n* is `NPROC` defined in `kernel/params.h`.
* Keep the old scheduler around to be able to switch back to it for the purpose of comparing/contrasting it with your new scheduler, and for debugging the new scheduler on different userspace workloads.
* Carefully consider synchronization and race conditions. What happens if you have two or more processors trying to make scheduling decisions concurrently?
  * You should take care to never schedule the same process concurrently on two or more processors.
* You can modify the variable `CPUS` in the `Makefile` to change the number of CPUs the emulator provides to the operating system. Use this to test different numbers of CPUs. For example, test with 1 CPU to make sure the implementation works before introducing the possibility of additional race conditions with more processors.
* **DO NOT** check in any changes to `Makefile`...the grading script requires specific preconfigured settings, including for the `CPUS` variable. When running `make grade` for your own testing, make sure that you do so using the original, unaltered `Makefile`.


## Discussion

Create a file in the root of this directory called `discussion.txt` containing your responses to the following prompts:

Fixed-priority and round-robin scheduling have different properties at runtime. Describe some of these differences and how you tested your scheduler. How does the behavior change with a different numbers of CPUs? What must happen for low-priority processes to be scheduled? How did you test this?


## Disclosure of AI Usage

Create a file in the root of this directory called `ai-usage.txt` containing a disclosure of any Artificial Intelligence tools (e.g., ChatGPT) that you used in helping to complete this assignment. If you did not use any AI tools, simply include the sentence "I did not use AI in this assignment.".

Recall from the syllabus: "Any use of AI tools must be disclosed. This disclosure is a report that includes what AI tools you used, what it helped you with, and what it could not help you with. You will not be penalized for using AI tools, but **you may be penalized for inadequate or incomplete disclosure.**" This implies that you must describe **both** how it was effective AND how it was ineffective.


## Submission

This completes the assignment. Please run `make grade` (using the original unaltered `Makefile`) to ensure that your code passes all of the preconfigured tests. Note that the `make grade` tests do not constitute **all** of the tests that your code may be subjected to for final grading, so make sure that each piece of your submission fully meets the specifications and criteria set forth in the tasks above. When you are ready, commit your changes with the message "Final Submission", and push the contents to GitHub to submit your assignment:

    $ git add *
    $ git commit -am "Final Submission"
    $ git push
