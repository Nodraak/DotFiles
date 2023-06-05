#!/usr/bin/env python3

import sublime, sublime_plugin

class RunMultipleCommandsCommand(sublime_plugin.TextCommand):
    """
    Takes an array of commands (same as those you'd provide to a key binding) with
    an optional context (defaults to view commands) & runs each command in order.
    Valid contexts are 'text', 'window', and 'app' for running a TextCommand,
    WindowCommands, or ApplicationCommand respectively.
    """
    def exec_command(self, command):
        assert "command" in command

        args = command.get('args', None)

        context_name = command.get('context', None)
        if (context_name is None) or (context_name == 'text'):
            context = self.view
        elif context_name == 'window':
            context = self.view.window()
        elif context_name == 'app':
            context = sublime
        else:
            raise Exception('Invalid command context "%s".' % context_name)

        if args is None:
            context.run_command(command['command'])
        else:
            context.run_command(command['command'], args)

    def run(self, edit, commands=None):
        if not commands:
            commands = []

        for command in commands:
            self.exec_command(command)
