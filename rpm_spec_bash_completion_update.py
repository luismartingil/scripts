#!/usr/bin/python

#
# This script updates the bash completion configuration
# in the terminal that runs a 'rpm' or 'yum' command. Used in RPM spec files
# within a post section, after our bash completion file has been installed.
#
#
# Some ideas taken from: stackoverflow.com @esoriano user!
#      questions/10376251/linux-write-commands-from-one-terminal-to-another
# Thanks!
#
# Author: luismartingil - 2017
#

def bash_reload_completion():
   """ Detects which BASH tty is installing the RPM and executes
   the BASH completion command silently
   """

   import sys
   import os
   import fcntl
   import termios
   import subprocess

   def _get_terminal():
      """ Detects the tty being used for the RPM installation
      """
      rpm_tools = ['yum', 'rpm']
      terminal = None
      for rpm_tool in rpm_tools:
         cmd = 'ps -C {0} -o user=,tty=,command='.format(rpm_tool)
         process = subprocess.Popen(cmd.split(), stdout=subprocess.PIPE)
         output, _ = process.communicate()
         try:
            output_arr = output.split()
            user, tty = output_arr[0:2]
            command = " ".join(output_arr[2:])
            if 'root' == user and any([x in command] for x in ['install', 'rpm']):
               terminal = tty
         except:
            pass
         finally:
            if terminal:
               break

      ret = '/dev/{0}'.format(terminal) if terminal else None
      return ret

   def _execute_source_cmd(terminal):
      """ Executes the BASH completion cmd in the given terminal
      """

      cmd_bash_completion = 'source /etc/bash_completion'
      try:
         fd = os.open(terminal, os.O_RDWR)
         for i in range(len(cmd_bash_completion)):
            fcntl.ioctl(fd, termios.TIOCSTI, cmd_bash_completion[i])
         fcntl.ioctl(fd, termios.TIOCSTI, '\n')
         os.close(fd)
      except Exception, err:
         pass

   if sys.platform.startswith('linux'):
      terminal = _get_terminal()
      _execute_source_cmd(terminal)

try:
   bash_reload_completion()
except Exception, err:
   pass
