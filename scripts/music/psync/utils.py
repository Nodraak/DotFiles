#!/usr/bin/env python3


def removeprefix(s, prefix):
    """str.removeprefix() requires Python 3.9"""
    if s.startswith(prefix):
        return s[len(prefix):]
    else:
        return s


def removesuffix(s, prefix):
    """str.removesuffix() requires Python 3.9"""
    if s.endswith(prefix):
        return s[:-len(prefix)]
    else:
        return s
