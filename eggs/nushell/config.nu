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
    mode: [emacs]
    event: [
      { 
        send: ExecuteHostCommand
        cmd: "
          zoxide query -s -l
            | fzf  --accept-nth=2 --height=45% --layout=reverse --preview='eza --all --icons --color=always {2..}' --preview-window=down,30% --input-label='Zoxide History'
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
    event: null
  },
  {
    name: command_history
    modifier: control
    keycode: char_r
    mode: [emacs]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          open $nu.history-path
            | lines
            | uniq
            | to text
            | fzf --height=45% --layout=reverse --wrap --input-label='Command History'
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
    mode: [emacs]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          fd --type directory --hidden 
            | fzf --height=45% --layout=reverse --preview='eza --icons --color=always {}' --preview-window=down,30% --input-label=Dirs
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
    mode: [emacs]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "
          fzf --height=45% --layout=reverse --preview='eza --icons --color=always {}' --preview-window=down,10% --input-label=Files --bind 'ctrl-o:execute:handlr open {}'
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

# alias core-ls = ls
#
# def ls [
#     --all (-a),         # Show hidden files
#     --long (-l),        # Get all available columns for each entry (slower; columns are platform-dependent)
#     --short-names (-s), # Only print the file names, and not the path
#     --full-paths (-f),  # display paths as absolute paths
#     --du (-d),          # Display the apparent directory size ("disk usage") in place of the directory metadata size
#     --directory (-D),   # List the specified directory itself instead of its contents
#     --mime-type (-m),   # Show mime-type in type column instead of 'file' (based on filenames only; files' contents are not examined)
#     --threads (-t),     # Use multiple threads to list contents. Output will be non-deterministic.
#     ...pattern: glob,   # The glob pattern to use.
# ]: [ nothing -> table ] {
#     let pattern = if ($pattern | is-empty) { [ '.' ] } else { $pattern }
#     match [$long] {
#       [true] => {
#         (core-ls
#           --all=$all
#           --long
#           --short-names=$short_names
#           --full-paths=$full_paths
#           --du=$du
#           --directory=$directory
#           --mime-type=$mime_type
#           --threads=$threads
#           ...$pattern
#         ) | sort-by -n name
#       }
#       [false] => {
#         (core-ls
#           --all=$all
#           --long
#           --short-names=$short_names
#           --full-paths=$full_paths
#           --du=$du
#           --directory=$directory
#           --mime-type=$mime_type
#           --threads=$threads
#           ...$pattern
#         ) | sort-by -n name | select name type user group mode size modified
#       } 
#     }
# }

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
  --last (-l),      # Last 50 package installed
  --first (-f),     # First 50 packges installed 
  --search (-s),    # packages version size time url
  --content (-c),   # which packages files include
  --rdp (-r),       # packages require_by, depends_on and provides
  --df (-d),        # packages directory and file
  --all (-a),       # packages installed all
  pattern?: string, # param
] {
    if $last {
      return (^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l=%u' | lines | parse '{name}={version}={size}={install_date}={url}' | sort-by install_date | last 50)
    }
    if $first {
      return (^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l=%u' | lines | parse '{name}={version}={size}={install_date}={url}' | sort-by install_date | first 50)
    }
    if $search {
      return (^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l=%u' | lines | parse '{name}={version}={size}={install_date}={url}' | sort-by install_date | where name like $pattern)
    }
    if $content {
      let style = { fg: red, attr: 'bold italic' }
      let table = ^expac '%n' | lines | pacman -Ql ...$in | rg $pattern | lines | parse '{name} {content}' | par-each { |x| {
        name: $x.name,
        content: (
          let name = $x.content | path basename | str replace $pattern $"(ansi $style)($pattern)(ansi reset)";
          $x.content | path dirname | path join $name
        ),
        type: ($x.content | path type),
        file: ($x.content | path basename)
      } } | where type != dir and file like $pattern | select name content
      let name = $table | select name | uniq
      return ($name | par-each { |x| { name:$x.name, content: ($table | where name == $x.name | get content) } })
    }
    if $rdp {
      let data = ^expac '%n|%N|%D|%P' | lines | parse "{name}|{require_by}|{depends_on}|{provides}"
      let table = $data | par-each { |x| {
        name: $x.name,
        require_by: (let a = if $x.require_by == "" { "None" } else { $x.require_by }; $a | split row -r '\s+'),
        depends_on: (let a = if $x.depends_on == "" { "None" } else { $x.depends_on }; $a | split row -r '\s+'), 
        provides: (let a = if $x.provides == "" { "None" } else { $x.provides }; $a | split row -r '\s+') 
      } }
      return ($table | where name like $pattern)
    }
    if $df {
      let table = ^expac '%n' | lines | parse '{name}' | where name like $pattern | get name | pacman -Ql ...$in | lines | parse '{name} {content}'
      let name = $table | select name | uniq
      return ($name | par-each { |x| { name:$x.name, content: ($table | where name == $x.name | get content) } })
    }
    if $all {
      return (^expac --timefmt='%Y-%m-%d %T' -H M '%n=%v=%m=%l=%u' | lines | parse '{name}={version}={size}={install_date}={url}' | sort-by install_date)
    } 
    let data = ^expac '%n|%N' | lines | parse "{name}|{require_by}"
    $data | par-each { |x| if $x.require_by == "" {
      return { name:$x.name, require_by: "None" }
    } } | sort-by name
}

def h [name] {
  nu -c $"($name) --help | bat -p -l help"
}

alias x = eza --icons=always --hyperlink
alias xl = eza --icons=always --hyperlink --long -b --time-style '+%Y-%m-%d %H:%M:%S'
def xt [num?: number path?: path] {
  let a = if $num == null { 1 } else { $num } 
  let b = if $path == null { "." } else { $path }
  x -T -L $a $b 
}

alias vi = neovide

alias slumber = ~/app/slumber/slumber -f ~/app/slumber

alias color = nu-highlight

def tldrf [] {
  tldr -l
    | fzf --preview "tldr --color always {1}" --preview-window "up,70%,+{2}+3/3,~3"
}

# def yazi [...args] {
# 	# let tmp = (mktemp -t "yazi-cwd.XXXXXX")
# 	# yazi ...$args --cwd-file $tmp
# 	# let cwd = (open $tmp)
# 	# if $cwd != "" and $cwd != $env.PWD {
# 	# 	cd $cwd
# 	# }
#   ^yazi ...$args
#   printf '\x1b[\x36 q'
# }
