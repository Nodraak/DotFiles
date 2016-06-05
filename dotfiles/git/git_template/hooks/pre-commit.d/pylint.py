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

from subprocess import Popen, PIPE, check_output


# Threshold for code to pass the Pylint test, from 0 to 10
PYLINT_PASS_THRESHOLD = 7


def is_py_script(filename):
    """Returns True if a file is a python executable."""
    if not os.path.exists(filename):
        return False
    # django's db migration or urls patterns file, skip it
    if ('migrations' in filename) or ('urls' in filename):
        return False
    if filename.endswith(".py"):
        return True

    mime_type = str(check_output(['file', '--mime-type', filename]))
    mime_type = mime_type.split(':')[1].strip().split('/')[0]
    if mime_type in ['image', 'application']:
        return False

    try:
        first_line = open(filename, "r").readline().strip()
    except UnicodeDecodeError:
        first_line = open(filename, "r", encoding='utf-8').readline().strip()
    return ("#!" in first_line) and ("python" in first_line)


def main():
    """Checks your git commit with Pylint !"""
    # Get the filenames of every file that has been modified
    sub = Popen("git diff --cached --name-only HEAD".split(), stdout=PIPE)
    sub.wait()

    # Filter out non-python or deleted files.
    files_changed = [f.strip().decode('utf-8') for f in sub.stdout.readlines()]
    py_files_changed = [f for f in files_changed if is_py_script(f)]

    # if nothing to do, return
    nb_files_to_check = len(py_files_changed)
    if nb_files_to_check == 0:
        return 0

    # Run Pylint on each file

    results = {}
    print('Pylint : %d files to check' % nb_files_to_check)
    print('------------ Pylint report ------------')
    for f in py_files_changed:
        pylint = Popen(("pylint3 -f text %s" % f).split(), stdout=PIPE, stderr=PIPE)
        pylint.wait()
        output = pylint.stdout.read().decode('utf-8')

        results_re = re.compile(r"Your code has been rated at (-?\d+\.\d+)/10")
        try:
            results[f] = float(results_re.findall(output)[0])
            print(output.split('\n\n\n')[0])
        except IndexError:
            print(output)
            print('-' * 50)
            print('Error : Pylint : score not found.')
            print('-' * 50)
            return 1

    print('------------ Pylint summary ------------')
    for f in results:
        result = results[f]
        grade = "FAIL" if result < PYLINT_PASS_THRESHOLD else "pass"
        print("[%s] %-30s : %.2f/10" % (grade, f, result))
    print('----------------------------------------')

    # If any of the files failed the Pylint test, exit nonzero
    if any([(result < PYLINT_PASS_THRESHOLD) for result in results.values()]):
        return 1
    return 0


if __name__ == "__main__":
    ret = main()
    sys.exit(ret)
