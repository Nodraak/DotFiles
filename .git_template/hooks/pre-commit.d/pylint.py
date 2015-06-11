#!/usr/bin/env python3

"""
A pre-commit hook for git that uses Pylint for automated code review.

If any python file's rating falls below the ``PYLINT_PASS_THRESHOLD``, this
script will return nonzero and the commit will be rejected.

This script must be located at ``$REPO/.git/hooks/pre-commit`` and be
executable.

Copyright 2009 Nick Fitzgerald - MIT Licensed.
"""

import os
import re
import sys

from subprocess import Popen, PIPE


# Threshold for code to pass the Pylint test, from 0 to 10
PYLINT_PASS_THRESHOLD = 9


def is_py_script(filename):
    """Returns True if a file is a python executable."""
    if not os.path.exists(filename):
        return False
    if filename.endswith(".py"):
        return True
    try:
        first_line = open(filename, "r").next().strip()
        return ("#!" in first_line) and ("python" in first_line)
    except StopIteration:
        return False


def main():
    """Checks your git commit with Pylint !"""
    # Get the filenames of every file that has been modified
    sub = Popen("git diff --cached --name-only HEAD".split(), stdout=PIPE)
    sub.wait()

    # Filter out non-python or deleted files.
    files_changed = [f.strip().decode('utf-8') for f in sub.stdout.readlines()]
    py_files_changed = [f for f in files_changed if is_py_script(f)]

    # Run Pylint on each file
    results = {}
    for f in py_files_changed:
        pylint = Popen(("pylint -f text %s" % f).split(), stdout=PIPE, stderr=PIPE)
        pylint.wait()
        output = pylint.stdout.read().decode('utf-8')

        results_re = re.compile(r"Your code has been rated at ([\d\.]+)/10")
        results[f] = float(results_re.findall(output)[0])

    # Display a summary of the results (if any files were checked).
    if len(results.values()) > 0:
        print('------------ Pylint report ------------')
        for f in results:
            result = results[f]
            grade = "FAIL" if result < PYLINT_PASS_THRESHOLD else "pass"
            print("    [%s] %s : %.2f/10" % (grade, f, result))
        print('----------------------------------------')

    # If any of the files failed the Pylint test, exit nonzero and stop the
    # commit from continuing.
    if any([(result < PYLINT_PASS_THRESHOLD) for result in results.values()]):
        return 1
    return 0


if __name__ == "__main__":
    ret = main()
    sys.exit(ret)
