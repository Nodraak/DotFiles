if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

# MacPorts Installer addition on 2014-09-18_at_14:31:00: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

