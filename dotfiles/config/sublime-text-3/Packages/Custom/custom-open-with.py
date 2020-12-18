#!/usr/bin/env python3

# pylint: disable=missing-docstring, no-self-use

import subprocess
import sublime
import sublime_plugin


def get_file_or_abort(files):
    if files == None:  # Context
        return sublime.active_window().active_view().file_name()
    elif len(files) == 0:  # Side Bar - Folder
        return None
    elif len(files) == 1:  # Side Bar - File
        return files[0]
    else:  # other
        sublime.error_message('Unexpected number of files (%d)' % len(files))
        return None


def open_terminal(working_directory):
    subprocess.Popen(['/usr/bin/terminator', '--working-directory=%s' % working_directory])


class OpenTerminalFileCommand(sublime_plugin.ApplicationCommand):
    def run(self, files):
        file = get_file_or_abort(files)
        folder_path = '/'.join(file.split('/')[:-1])
        open_terminal(folder_path)

    def is_visible(self, files):
        return get_file_or_abort(files) != None


class OpenTerminalFolderCommand(sublime_plugin.WindowCommand):
    def run(self, dirs):
        if len(dirs) != 1:
            sublime.error_message('Unexpected number of folders, %d instead of 1' % len(dirs))
            return
        open_terminal(dirs[0])

    def is_visible(self, dirs):
        return len(dirs) != 0


class OpenFileWithZathuraCommand(sublime_plugin.WindowCommand):
    def run(self, files):
        file = get_file_or_abort(files)
        subprocess.Popen(['zathura', file])

    def is_visible(self, files):
        file = get_file_or_abort(files)
        return (file != None) and (file.split('.')[-1] == 'pdf')


class OpenWithGitgCommand(sublime_plugin.WindowCommand):
    def run(self, files):
        cmd = ['gitg']
        file = get_file_or_abort(files)
        if file is not None:  # add arg
            folder_path = '/'.join(file.split('/')[:-1])
            cmd.append(folder_path)
        subprocess.Popen(cmd)

    def is_visible(self, files):
        return True
