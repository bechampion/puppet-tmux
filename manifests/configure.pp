class tmux::configure::defaults{
  include tmux::install                 
  include tmux::configure               
  include tmux::configure::prefix       
  include tmux::configure::select::panes
  include tmux::configure::mode
  include tmux::configure::terminal
  include tmux::configure::history
  include tmux::configure::mouse
}

class tmux::configure  {
  file { "/tmp/tmux.conf":
    ensure => present,
  }

}
##prefix
class tmux::configure::prefix (String $prefix = "b" )  {
  tmux::confwriter { "Appending Prefix":
    line => "set option -g prefix C-${prefix}",
    #match => '^set\ option \-g\ prefix',
    #matchabsence => false
    }
}

##pane selection
class tmux::configure::select::panes (
  String $right = "S-Right",
  String $left = "S-Left",
  String $up = "S-Up",
  String $down = "S-Down"
)
{
  tmux::confwriter { "Adding pane selection shortcuts left":
    line => "bind -n ${left} select-pane -L",
  }
  tmux::confwriter{ "Adding pane selection shortcuts right":
    line => "bind -n ${right} select-pane -R",
  }
  tmux::confwriter{ "Adding pane selection shortcuts down":
    line => "bind -n ${down} select-pane -D",
  }
  tmux::confwriter{ "Adding pane selection shortcuts up":
    line => "bind -n ${up} select-pane -U",
  }
}
##mode keys
class tmux::configure::mode (String $modekeys = "vi") { 
  tmux::confwriter { "Setting mode keys to ${modekeys}": 
    line => "set -g mode-keys ${modekeys}",
  }
}

##default terminal
class tmux::configure::terminal(String $terminal= "screen-256color") { 
 tmux::confwriter { "Setting terminal to ${terminal}": 
    line => "set -g default-terminal ${terminal}",
  }
}
##default history
class tmux::configure::history(Integer $history = 5000) { 
  tmux::confwriter { "Setting history to ${history}": 
    line => "set-option -g history-limit ${history}",
  }
}
#mouse mode enabled
class tmux::configure::mouse{ 
  tmux::confwriter { "Setting mouse on":
    line => "setw -g mode-mouse on"
  }
  tmux::confwriter { "Setting mouse select pane on":
    line => "set-option -g mouse-select-pane on"
  }
  tmux::confwriter { "Setting pane resize with mouse":
    line => "set -g mouse-resize-pane on"
  }
}

#user defined options
define tmux::configure::add( String $line ) {
  tmux::confwriter { "Adding user defined options":
    line => $line
  }
}

#basic chaining ...
Class["tmux::install"] -> 
Class["tmux::configure"] -> 
Class["tmux::configure::prefix"]->
Class["tmux::configure::select::panes"]
Class["tmux::configure::mode"] ->
Class["tmux::configure::terminal"] ->
Class["tmux::configure::history"] ->
Class["tmux::configure::mouse"]
