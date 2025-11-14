$env.config.show_banner = false
$env.config.datetime_format.table = '%F %T'
$env.config.filesize.unit = 'binary'
$env.config.color_config.hints = 'white_dimmed'
$env.config.color_config.shape_garbage = { fg: 'red'}
$env.config.color_config.shape_external = 'blue'
$env.config.color_config.shape_internalcall = 'blue_bold'
$env.config.keybindings ++= [
  {
    name: zoxide_history
    modifier: control
    keycode: char_l
    mode: [emacs, vi_insert, vi_normal]
    event: [
      { 
        send: ExecuteHostCommand
        cmd: "
          zoxide query -s -l
            | fzf  --accept-nth=2 --height=45% --layout=reverse --preview='eza --all --icons --color=always {2..}' --preview-window=down,30%
            | cd $in
        "
      }
    ]
  },
  {
    name: nothing
    modifier: control
    keycode: char_q
    mode: [emacs, vi_insert, vi_normal]
    event: [
      { send: ExecuteHostCommand cmd: "" }
    ]
  },
  {
    name: fzf_history
    modifier: control
    keycode: char_r
    mode: [emacs, vi_insert, vi_normal]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          history
            | get command
            | group-by --to-table 
            | get group 
            | to text
            | fzf --height=45% --layout=reverse --wrap
            | commandline edit -r $in
            | commandline set-cursor --end
        "
      }
    ]
  },
  {
    name: fzf_directories
    modifier: control
    keycode: char_j
    mode: [emacs, vi_insert, vi_normal]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          fd --type directory --hidden 
            | fzf --height=45% --layout=reverse --preview='eza --icons --color=always {}' --preview-window=down,30%
            | commandline edit --append $in
            | commandline set-cursor --end
        "
      }
    ]
  },
  {
    name: fzf_files
    modifier: control
    keycode: char_k
    mode: [emacs, vi_insert, vi_normal]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          fd --type file --type symlink --type socket --hidden 
            | fzf --height=45% --layout=reverse --preview='eza --icons --color=always {}' --preview-window=down,10%
            | commandline edit --append $in
            | commandline set-cursor --end
        "
      }
    ]
  }
  # {
  #   name: fzf_files
  #   modifier: control
  #   keycode: char_k
  #   mode: [emacs, vi_insert, vi_normal]
  #   event: [
  #     {
  #       send: ExecuteHostCommand
  #       cmd: "
  #         let command = commandline | split row -r '\\s+'
  #         let length = $command | length
  #         let prefix = $command | get 0
  #         let suffix = if $length > 1 { commandline | str replace $prefix '' | str replace -r '\\s*' '' } else { '' } 
  #         fd --type file --type symlink --type socket --hidden 
  #           | fzf -q $suffix --cycle --height=45% --layout=reverse --preview='eza --icons --color=always {}' --preview-window=down,10%,rounded
  #           | commandline edit -A ($prefix +  ' ' + $in)
  #       "
  #     }
  #   ]
  # }
]

alias core-ls = ls

def ls [
    --all (-a),         # Show hidden files
    --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
    --short-names (-s), # Only print the file names, and not the path
    --full-paths (-f),  # display paths as absolute paths
    --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
    --directory (-D),   # List the specified directory itself instead of its contents
    --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
    --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
    ...pattern: glob,   # The glob pattern to use.
]: [ nothing -> table ] {
    let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
    match [$long] {
      [true] => {
        (core-ls
          --all=$all
          --long
          --short-names=$short_names
          --full-paths=$full_paths
          --du=$du
          --directory=$directory
          --mime-type=$mime_type
          --threads=$threads
          ...$pattern
        ) | sort-by -n name
      }
      [false] => {
        (core-ls
          --all=$all
          --long
          --short-names=$short_names
          --full-paths=$full_paths
          --du=$du
          --directory=$directory
          --mime-type=$mime_type
          --threads=$threads
          ...$pattern
        ) | sort-by -n name | select name type user group mode size modified
      } 
    }
}

def rgf [
  text,
  path?: path,
] {
  if $path == null {
    rg --column --hidden --line-number --color=always --smart-case $text
    | fzf --ansi --delimiter ":" --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,+{2}+3/3,~3"
  } else {
    rg --column --hidden --line-number --color=always --smart-case $text $path
    | fzf --ansi --delimiter ":" --preview "bat --color=always {1} --highlight-line {2}" --preview-window "up,60%,+{2}+3/3,~3"
  }
}

def expac [
  --last (-l),    # Last 50 package installed
  --first (-f),   # First 50 packges installed 
  --search (-s),      # Search packages
  --content (-c), # Search packages content
  pattern?: string, # Search text
] {
  match [$last $first $search $content] {
    [true false false false] => {
      ^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l' | parse '{name}={version}={size}={time}' | sort-by time | last 50
    }
    [false true false false] => {
      ^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l' | parse '{name}={version}={size}={time}' | sort-by time | first 50
    }
    [false false true false] => {
      ^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l' | parse '{name}={version}={size}={time}' | sort-by time | where name like $pattern
    }
    [false false false true] => {
      # rg original
      ^expac '%n' | parse '{name}' | get name | paru -Ql ...$in | rg $pattern
      # parse style 
      # let table = ^expac '%n' | parse '{name}' | get name | paru -Ql ...$in | rg $pattern | parse '{name} {content}'
      # let name = $table | select name | uniq
      # $name | each { |x| { name:$x.name, content: ($table | where name == $x.name | get content) } }
    }
    [false false false false] => {
      ^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l' | parse '{name}={version}={size}={time}' | sort-by time
    } 
  }
}

alias x = eza --icons --hyperlink
alias xl = eza --icons --hyperlink --long --time-style '+%Y-%m-%d %H:%M:%S'
alias xt = xl -T

alias vi = neovide

alias slumber = ~/app/slumber/slumber -f ~/app/slumber

alias color = nu-highlight

alias tldr = ~/app/tldr/tldr --config ~/app/tldr/config.toml
def tldrf [] {
  tldr -l
    | fzf --preview "~/app/tldr/tldr --config ~/app/tldr/config.toml --color always {1}" --preview-window "up,70%,+{2}+3/3,~3"
}

# alias core-yazi = yazi
#
# def yazi [...args] {
# 	# let tmp = (mktemp -t "yazi-cwd.XXXXXX")
# 	# yazi ...$args --cwd-file $tmp
# 	# let cwd = (open $tmp)
# 	# if $cwd != "" and $cwd != $env.PWD {
# 	# 	cd $cwd
# 	# }
#   core-yazi ...$args
#   printf '\x1b[\x36 q'
# }
