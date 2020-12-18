#!/usr/bin/env python3

import os
import sublime
import sublime_plugin


class GitBlameCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        if not self.is_activated():
            sublime.status_message('Error: no files selected')
            return

        folder_name, file_name = os.path.split(self.view.file_name())
        begin_line, _ = self.view.rowcol(self.view.sel()[0].begin())
        end_line, _ = self.view.rowcol(self.view.sel()[0].end())
        lines = str(begin_line+1) + ',' + str(end_line)
        dic = {
            'cmd': ['git', 'blame', '-L', lines, file_name],
            'working_dir': folder_name
        }
        self.view.window().run_command('exec', dic)

    def is_activated(self):
        return self.view.file_name() and len(self.view.file_name()) > 0


class GitDiffCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        if not self.is_activated():
            sublime.status_message('Error: no files selected')
            return

        folder_name, file_name = os.path.split(self.view.file_name())
        dic = {
            'cmd': ['git', 'diff', file_name],
            'working_dir': folder_name
        }
        self.view.window().run_command('exec', dic)

    def is_activated(self):
        return self.view.file_name() and len(self.view.file_name()) > 0
