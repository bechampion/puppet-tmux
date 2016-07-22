class tmux::install {
  include stdlib
  package { "tmux":
    ensure => present
  }
}




