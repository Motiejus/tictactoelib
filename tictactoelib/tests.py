import unittest
import doctest

from . import noninteractive, compete, get_source

from .examples import dumb_player, err_divzero, err_syntax, err_badfun, err_oom


def load_tests(loader, tests, ignore):
    tests.addTests(doctest.DocTestSuite(noninteractive))
    return tests


class NonInteractive(unittest.TestCase):
    def test_ok(self):
        self.ok(dumb_player, dumb_player)

    def _assert_error_x(self, error, guilty, reason, gameplay):
        self.assertEqual('error', error)
        self.assertEqual('x', guilty)
        self.assertEqual([0], gameplay)
        return reason

    def _assert_error_o(self, error, guilty, reason, gameplay):
        self.assertEqual('error', error)
        self.assertEqual('o', guilty)
        self.assertEqual([1, 0], gameplay)
        return reason

    def test_error_x(self):
        self._assert_error_x(*compete(err_divzero, dumb_player))

    def test_error_o(self):
        self._assert_error_o(*compete(dumb_player, err_divzero))

    def test_error_x_syntax(self):
        self._assert_error_x(*compete(err_syntax, dumb_player))

    def test_error_o_syntax(self):
        self._assert_error_o(*compete(dumb_player, err_syntax))

    def test_error_x_badfun(self):
        self._assert_error_x(*compete(err_badfun, dumb_player))

    def test_error_o_badfun(self):
        self._assert_error_o(*compete(dumb_player, err_badfun))

    def test_error_oom(self):
        onek = 1 << 20  # 1M
        compete_res = compete(dumb_player, err_oom, memlimit=onek)
        r = self._assert_error_o(*compete_res)
        self.assertIn("probably OOM", r)

    def test_mem_x_ok(self):
        twomegs = 1 << 21  # 2M
        self.ok(dumb_player, dumb_player, memlimit=twomegs)

    def ok(self, *args, **kwargs):
        ok, state, gameplay = compete(*args, **kwargs)
        self.assertEqual('ok', ok)
        self.assertEqual('o', state)
        self.assertEqual([1, 2, 4, 3], gameplay[:4])
        self.assertNotEqual(0, gameplay[-1])
