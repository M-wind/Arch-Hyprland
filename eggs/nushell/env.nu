$env.STARSHIP_CACHE = $env.HOME | path join app starship cache
$env.STARSHIP_CONFIG = $env.HOME | path join .config starship starship.toml
$env._ZO_DATA_DIR = $env.HOME | path join app zoxide

$env.EDITOR = "nvim"
# $env.config.edit_mode = 'vi'
$env.LANG = "en_US.UTF-8"

# $env.BAT_CONFIG_PATH = "~/app/bat/bat.conf"

$env.CARGO_HOME = $env.HOME | path join language/rust/cargo 
$env.RUSTUP_HOME = $env.HOME | path join language/rust/rustup
$env.RUSTUP_DIST_SERVER = "https://mirrors.aliyun.com/rustup"
$env.RUSTUP_UPDATE_ROOT = "https://mirrors.aliyun.com/rustup/rustup"

$env.LIBSEAT_BACKEND = "logind"
$env.WINEPREFIX = $env.HOME | path join game/.wine
$env.WINEDEBUG = "-all"

# $env.GOENV = $env.HOME | path join language go env

$env.FZF_DEFAULT_COMMAND = "fd --type file --type symlink --type socket --hidden"
$env.FZF_DEFAULT_OPTS = "
--color=dark
--color=hl+:green,hl:green
--color=pointer:magenta,info:green,spinner:blue,prompt:green,label:cyan
--prompt=' '
--style=full
--cycle
--list-border=rounded
--bind 'ctrl-p:preview-up,ctrl-n:preview-down'
"

$env.DOTNET_ROOT = $env.HOME | path join language/dotnet
# mpv vulkan Hardware video acceleration Support
$env.RADV_PERFTEST = "video_decode,video_encode"

#colorize man pages
# $env.MANPAGER = "bat -l man"

$env.PATH = (
  $env.PATH
    | split row (char esep)
    | prepend ($env.HOME | path join app tools)
    | prepend ($env.HOME | path join app 7z)
    | prepend ($env.HOME | path join app neovim bin)
    | prepend ($env.HOME | path join app hypr)
    | prepend ($env.HOME | path join app wallpaper)
    | prepend ($env._ZO_DATA_DIR)
    | prepend ($env.HOME | path join app formatters)
    | prepend ($env.HOME | path join app screenshots)
    | prepend ($env.HOME | path join app screenlock)
    | prepend ($env.HOME | path join app notify)
    | prepend ($env.HOME | path join app clipboard)
    | prepend ($env.HOME | path join app handlr)
    | prepend ($env.HOME | path join app tldr)
    | prepend ($env.HOME | path join app exiftool)
    | prepend ($env.CARGO_HOME | path join bin)
    | prepend ($env.HOME | path join game)
    | prepend ($env.HOME | path join game wine bin)
    | prepend ($env.HOME | path join language nodejs 22.22.2 bin)
    | prepend ($env.HOME | path join language nodejs npm-global bin)
    | prepend ($env.HOME | path join language nodejs pnpm-global bin)
    | prepend ($env.HOME | path join language nodejs pnpm bin)
    # | prepend ($env.HOME | path join language go 1.26.2 bin)
    | prepend ($env.DOTNET_ROOT)
    | prepend ($env.HOME | path join .config eww scripts)
    | uniq
)

source ~/app/starship/starship.nu
source ~/app/zoxide/zoxide.nu
