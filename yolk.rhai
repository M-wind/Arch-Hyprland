import "themes" as themes;
import "theme" as color;

export let eggs = #{
    alacritty: #{
        targets: "~/.config/alacritty",
        templates: ["alacritty.toml"],
        enabled: true,
    },     
    mpd: #{
        targets: "~/.config/mpd",
        enabled: true,
    },     
    lianwall: #{
        targets: "~/.config/lianwall",
        enabled: true,
    },     
    rmpc: #{
        targets: "~/.config/rmpc",
        enabled: true,
    },     
    foot: #{
        targets: "~/.config/foot",
        templates: ["foot.ini"],
        enabled: true,
    },     
    nvim: #{
        targets: "~/.config/nvim",
        templates: ["init.lua"],
        enabled: true,
    },     
    eww: #{
      targets: "~/.config/eww",
      templates: ["modules/platte.yuck", "modules/_base.scss", "modules/colors.yuck", "icons/circle.svg"],
      enabled: true,
    },     
    hypr: #{
        targets: "~/.config/hypr",
        templates: ["hyprland.conf"],
        enabled: true,
    },     
    niri: #{
        targets: "~/.config/niri",
        templates: ["config.kdl"],
        enabled: true,
    },     
    wallust: #{
        targets: "~/.config/wallust",
        enabled: true,
    },     
    slumber: #{
        targets: "~/.config/slumber",
        enabled: true,
    },     
    fcitx5: #{
        targets: "~/.config/fcitx5",
        enabled: true,
    },    
    btop: #{
        targets: "~/.config/btop",
        templates: ["btop.conf"],
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
    dunst: #{
        targets: "~/.config/dunst",
        enabled: true,
    },     
    pnpm: #{
        targets: "~/.config/pnpm",
        enabled: true,
    },     
    veila: #{
        targets: "~/.config/veila",
        enabled: true,
    },     
    bat: #{
        targets: "~/.config/bat",
        templates: ["config"],
        enabled: true,
    },     
    tlrc: #{
        targets: "~/.config/tlrc",
        enabled: true,
    },     
};

export const theme = #{
    colors: themes::colors[color::name],
    color_name: color::name,
};

fn write_current_colorscheme(name) {
    let colors = themes::colors[name];
    let need = #{
      colors: #{
        color0: colors.black,
        color1: colors.red,
        color2: colors.green,
        color3: colors.yellow,
        color4: colors.blue,
        color5: colors.magenta,
        color6: colors.cyan,
        color7: colors.white,
        color8: colors.bright_black,
        color9: colors.bright_red,
        color10: colors.bright_green,
        color11: colors.bright_yellow,
        color12: colors.bright_blue,
        color13: colors.bright_magenta,
        color14: colors.bright_cyan,
        color15: colors.bright_white
      },
      special: #{
        background: colors.background,
        foreground: colors.foreground,
        cursor: "#cccccc"
      }
    };
    print(need.to_json());
}

fn replace_color_foot(s) {
    let original = get_yolk_text();
    original[-6..=-1] = s[1..=s.len()];
    original
};

fn hex_to_hext(s, t) {
    let hex = color_hex_to_rgba_str(s);
    hex[-4..=-2] = t;
    hex
};

fn replace_theme_name() {
  let theme_name = theme.color_name;
  if theme_name == "wallpaper" {
    theme_name = "solarized-osaka"
  }
  theme_name
}
