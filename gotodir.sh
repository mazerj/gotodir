#!/bin/sh

# Kind of like the old Norton CD (ncd) utility for OSX or wcd.exe
# for linux -- used with alias below adds a pseudo-search path to
# cd:
#  - if exact match is found, just cd there
#  - otherwise generate a list of possible matches and use fzf
#    (https://github.com/junegunn/fzf) to let user pick one to
#    cd too.
#
# To use, stick this script on your search path and add the
# following to your .bashrc_profile:
#
#  function gotodir () { gotodir.sh "$@" 2>/tmp/g.$$ && \
#			builtin cd $(</tmp/g.$$) && \
#			rm /tmp/g.$$ && pwd ; }
#  alias cd=gotodir
#

if [ -d "$@" ]; then
  cd "$@"; pwd
else
  mdfind "(kMDItemFSName == \"*$@*\"c) && \
  	  (kMDItemKind == 'Folder')" -0 | \
    xargs -0 ls -t1d | grep "$HOME" >/tmp/$$.dirs
  n=`wc -l </tmp/$$.dirs`
  if [ $n == 0 ]; then
    echo \'$@\' doesn\'t exist. >/dev/tty
    exit 1
  elif [ $n == 1 ]; then
    # if there's only one dir, just go there
    cat /tmp/$$.dirs
  else
    cat /tmp/$$.dirs | fzf -i --reverse --height=75\% --prompt="select dir>"
  fi
fi
exit 0
