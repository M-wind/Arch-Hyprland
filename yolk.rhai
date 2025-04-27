export let eggs = #{
  alacritty: #{
    targets: "~/.config/alacritty",
    templates: ["alacritty.toml"],
    enabled: true,
  },     
  foot: #{
    targets: "~/.config/foot",
    templates: ["foot.ini"],
    enabled: true,
  },     
  hypr: #{
    targets: "~/.config/hypr",
    enabled: true,
  },     
  fcitx5: #{
    targets: "~/.config/fcitx5",
    enabled: true,
  },    
  btop: #{
    targets: "~/.config/btop",
    enabled: true,
  },     
  fastfetch: #{
    targets: "~/.config/fastfetch",
    enabled: true,
  },     
  mpv: #{
    targets: "~/.config/mpv",
    enabled: true,
  },     
  nvim: #{
    targets: "~/.config/nvim",
    enabled: true,
  },     
  nushell: #{
    targets: "~/.config/nushell",
    enabled: true,
  },     
  gtk: #{
    targets: "~/.config/gtk-3.0",
    enabled: true,
  },     
  starship: #{
    targets: "~/.config/starship",
    enabled: true,
  },     
  neovide: #{
    targets: "~/.config/neovide",
    enabled: true,
  },     
  yazi: #{
    targets: "~/.config/yazi",
    enabled: true,
  },     
  wpaperd: #{
    targets: "~/.config/wpaperd",
    enabled: true,
  },     
  clipse: #{
    targets: "~/.config/clipse",
    enabled: true,
  },     
  eww: #{
    targets: "~/.config/eww",
    enabled: true,
  },     
  dunst: #{
    targets: "~/.config/dunst",
    enabled: true,
  },     
};

const themes = #{
  onedarkpro: #{
    // background: "#282c34",
    background: "#181818",
    foreground: "#dcdfe4",
    black: "#282c34",
    red: "#e06c75",
    green: "#98c379",
    yellow: "#e5c07b",
    blue: "#61afef",
    magenta: "#c678dd",
    cyan: "#56b6c2",
    white: "#dcdfe4",
    bright_black: "#282c34",
    bright_red: "#e06c75",
    bright_green: "#98c379",
    bright_yellow: "#e5c07b",
    bright_blue: "#61afef",
    bright_magenta: "#c678dd",
    bright_cyan: "#56b6c2",
    bright_white: "#dcdfe4",
  },
  tokyonight_night: #{
    background: "#1a1b26",
    foreground: "#c0caf5",
    black: "#15161E",
    red: "#f7768e",
    green: "#9ece6a",
    yellow: "#e0af68",
    blue: "#7aa2f7",
    magenta: "#bb9af7",
    cyan: "#7dcfff",
    white: "#a9b1d6",
    bright_black: "#414868",
    bright_red: "#f7768e",
    bright_green: "#9ece6a",
    bright_yellow: "#e0af68",
    bright_blue: "#7aa2f7",
    bright_magenta: "#bb9af7",
    bright_cyan: "#7dcfff",
    bright_white: "#c0caf5",
  },
  everforest_dark_soft: #{
    background: "#323d43",
    foreground: "#d3c6aa",
    black: "#4b565c",
    red: "#e67e80",
    green: "#a7c080",
    yellow: "#dbbc7f",
    blue: "#7fbbb3",
    magenta: "#d699b6",
    cyan: "#83c092",
    white: "#d3c6aa",
    bright_black: "#4b565c",
    bright_red: "#e67e80",
    bright_green: "#a7c080",
    bright_yellow: "#dbbc7f",
    bright_blue: "#7fbbb3",
    bright_magenta: "#d699b6",
    bright_cyan: "#83c092",
    bright_white: "#d3c6aa",
  },
  solarized_osaka: #{
    background: "#001419",
    foreground: "#839395",
    black: "#001419",
    red: "#db302d",
    green: "#849900",
    yellow: "#b28500",
    blue: "#268bd3",
    magenta: "#d23681",
    cyan: "#29a298",
    white: "#9eabac",
    bright_black: "#001419",
    bright_red: "#db302d",
    bright_green: "#849900",
    bright_yellow: "#b28500",
    bright_blue: "#268bd3",
    bright_magenta: "#d23681",
    bright_cyan: "#29a298",
    bright_white: "#839395",
  },
  bamboo: #{
    background: "#252623",
    foreground: "#f1e9d2",
    black: "#1c1e1b",
    red: "#e75a7c",
    green: "#8fb573",
    yellow: "#dbb651",
    blue: "#57a5e5",
    magenta: "#aaaaff",
    cyan: "#70c2be",
    white: "#f1e9d2",
    bright_black: "#5b5e5a",
    bright_red: "#e75a7c",
    bright_green: "#8fb573",
    bright_yellow: "#dbb651",
    bright_blue: "#57a5e5",
    bright_magenta: "#aaaaff",
    bright_cyan: "#70c2be",
    bright_white: "#fff8f0",
  },
};

export const theme = #{
  colors: themes.bamboo
};

fn replace_color_foot(s) {
  let original = get_yolk_text();
  original[-6..=-1] = s[1..=s.len()];
  original
};
