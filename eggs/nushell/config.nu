$env.config.show_banner = false
$env.config.color_config.hints = 'white_dimmed'
$env.config.color_config.shape_garbage = { fg: 'red'}
$env.config.color_config.shape_external = 'blue'
$env.config.color_config.shape_internalcall = 'blue_bold'
$env.config.datetime_format.table = '%F %T'
$env.config.filesize.unit = 'binary'
$env.config.keybindings ++= [{
  name: zoxide_menu
  modifier: control
  keycode: char_o
  mode: emacs 
  event: [
    { send: ExecuteHostCommand cmd: "zoxide query -i | cd $in" }
  ]
}]

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
        ) | sort-by name
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
        ) | sort-by name | select name type user group mode size modified
      } 
    }
}

alias vi = neovide

alias color = nu-highlight

alias tldr = /home/zwind/app/tldr/tldr --config /home/zwind/app/tldr/config.toml

# def --env y [...args] {
# 	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
# 	yazi ...$args --cwd-file $tmp
# 	let cwd = (open $tmp)
# 	if $cwd != "" and $cwd != $env.PWD {
# 		cd $cwd
# 	}
# 	rm -fp $tmp
#   printf '\x1b[\x36 q'
# }
#
