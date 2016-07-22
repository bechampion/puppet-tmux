define tmux::confwriter
(
  String $path = "/tmp/tmux.conf",
  String $line = "",
  String $match = "" ,
  Boolean $matchabsence = false,
)

{
  if $match != ""  {
    file_line { "${name}":
      path => "/tmp/tmux.conf",
      line => "${line}",
      match => "${match}",
      match_for_absence=> $matchabsence
      } 
    }else {
      file_line { "${name}":
        path => "/tmp/tmux.conf",
        line => "${line}",
        } 
    }
}



