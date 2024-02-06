# CS 3270: Programming Languages

## GitHub Actions

A description of GitHub Actions setup in the previous projects

## Introduction

As stated on the GitHub website, GitHub Actions is a "continuous integration and continuous delivery (CI/CD) platform that allows you to automate your build, test, and deployment pipeline." In CS 3270, a GitHub Actions workflow was mainly used to confirm testing results.

To invoke a GitHub Actions workflow, a text-based YAML file – that contains the necessary configuration for a program to be tested on GitHub.com – should be included in the repository. This YAML file should be placed in the **.github/workflows** folder of the repository.

## Contents of YAML file

You will need to investigate what will be needed in your YAML file for your Project 4 language, but the following is a brief explanation of the contents of the YAML files that were used in the previous projects.

### Name of workflow

Each YAML file starts with a value for `name`. For example, the first project's name was set to "Project 1".

```yaml
name: Project 1
```

### Event to invoke the workflow

Setting the `on` value to `push` will invoke the workflow each time a push event occurs.

```yaml
on: [push]
```

### Running a job

This is the main part of the configuration that is used to run the test cases. Under `jobs` then `build`, some additional configuration values are set. This includes the name of the job and what operating system the job will run on.

For example, in Project 2, the name of the job is `Racket` and the job runs on `ubuntu-latest`, which is the common OS that is used. A setting is included to stop the job in the unlikely event of an infinite loop or infinite recursion.

```yaml
jobs:

  build:

    name: Racket
    runs-on: ubuntu-latest
    timeout-minutes: 20
```

The remaining configuration settings are the *steps* that will be executed for the job. In the previous projects, the steps consist of three main tasks:

* Cloning the repository
* Including the necessary compiler/interpreter
* Running the test cases

Note that a job *runs* on a virtual machine (e.g., a Linux machine when `ubuntu-latest` is specified). Hence, the repository will need to be cloned in that virtual machine and the necessary compiler/interpreter installed. Then the test cases can be run.

The standard step to clone the repository in the virtual machine can be seen in all three previous projects.

```yaml
steps:
- name: Checkout repository
  uses: actions/checkout@v3  # or "uses: actions/checkout@master"
```

The remaining steps of installing a compiler/interpreter and running the test cases will be different based on your language selection.
