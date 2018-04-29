# gotodir
add smart searching to `cd` - osx only

Like the old Norton CD (ncd) utility for OSX or wcd.exe for linux --
used with alias below adds a pseudo-search path to cd:
- if exact match is found, just cd there
- otherwise generate a list of possible matches and use fzf
  (https://github.com/junegunn/fzf) to let user pick one to
   cd too.

<script src="https://asciinema.org/a/zmKrOO0crC3xDQL0c0btFor3U"
  id="asciicast-14" async data-autoplay="true"></script>

To use, install `gotodir.sh` somewhere on your search path and add the
following to your .bashrc_profile:

    function gotodir () { gotodir.sh "$@" 2>/tmp/g.$$ && \
			builtin cd $(</tmp/g.$$) && \
			rm /tmp/g.$$ && pwd ; }
    alias cd=gotodir



