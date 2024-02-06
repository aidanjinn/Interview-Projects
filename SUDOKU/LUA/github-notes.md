# CS 3270: Programming Languages

## GitHub Notes

Information on how to use Git/GitHub on the command line

## Access the command line

*Windows users*: using File Explorer, navigate to the folder where you want to perform the `git` commands and then right click and select **Git Bash Here**.

*Mac users*: navigate to the folder where you want to perform the `git` commands and then open a terminal.

For cloning, you'll want to navigate to the folder where you want the cloned folder from GitHub to reside in. For all other commands, navigate into the folder containing your local Git repository.

## Clone (or download) repository from GitHub

Run the following command:

```
git clone <remote_repo>
```

Replace `<remote_repo>` with the URL of your assigned repository on GitHub. The URL can be copied by clicking on the **Code | Clone with HTTPS** button in the repository on GitHub.

For example, the command to clone the repository for Homework 3 (Part I) that is assigned to a student with GitHub username `vandercc` in the Fall 2023 edition of CS 3270 would look like this:

```
git clone https://github.com/vu-cs3270-f23/hw03-i-vandercc.git
```

If the command is successful, you now have a local copy of your GitHub repository for Homework 3 (Part I).

If you are asked to login, you will need to create a *personal access token* on the [GitHub website](https://github.com/settings/tokens) (if you saved your token from Homework 0, you can use that instead). Select **Generate new token**. On the next page, enter a name for the token. The default expiration is set for 30 days. You should set this to a minimum of 90 days so you can use the same token for the entire semester (if you forget to increase the expiration, then you can just regenerate a token when this token expires). Under **Select scopes**, check **repo**. Then scroll all the way to the bottom of the page and click **Generate token**. A personal token will be generated. Click on the clipboard icon to the right of the token text to copy the token to your computer's clipboard. This token is like a password. If you want to save it, make sure to save it in a secure place. Back to the command line, after entering your GitHub username, paste the token when you are asked for a password.

## Commit

Once you are ready to commit some code, open a Bash command prompt or terminal.

You must first *stage* the files that you want to commit. Note that this step needs to be done before actually committing the file(s). This step was not needed in CLion, because it is done automatically for you.

The following command will add (or stage) all files that can be committed in the local repository:

```
git add .
```

If you want to just add (or stage) one particular file, e.g., you only want to commit `hw03-i.rkt`, in the prompt/terminal, go into (i.e., `cd`) the repository's `src` folder and then run the following command:

```
git add hw03-i.rkt
```

If you receive a warning "warning: LF will be replaced by CRLF ...", you can ignore the warning.

Now that you have added (or staged) the files to be committed, you can perform commit step. Run the following command:

```
git commit -m "<message>"
```

You should replace `<message>` with a brief description of what was committed. For example:

```
git commit -m "Completed first two problems."
```

## Push commits to GitHub

Once you've committed, you can push the commits to GitHub. Run the following command:

```
git push
```

You may want to go to your repository on GitHub to confirm that the push completed successfully.