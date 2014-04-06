import unittest
import doctest

from . import noninteractive

def load_tests(loader, tests, ignore):
    tests.addTests(doctest.DocTestSuite(noninteractive))
    return tests
