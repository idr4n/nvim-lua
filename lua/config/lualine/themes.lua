local M = {}

local c_dracula = {
  gray = "#2C2E3A",
  lightgray = "#373946",
  orange = "#ffb86c",
  purple = "#bd93f9",
  pink = "#FF86D3",
  red = "#ff5555",
  yellow = "#f1fa8c",
  green = "#50fa7b",
  white = "#92939B",
  black = "#282a36",
  stealth = "#787982",
}

local dracula_custom = {
  normal = {
    a = { bg = c_dracula.purple, fg = c_dracula.black, gui = "bold" },
    b = { bg = c_dracula.lightgray, fg = c_dracula.white },
    c = { bg = c_dracula.gray, fg = c_dracula.stealth },
  },
  insert = {
    a = { bg = c_dracula.green, fg = c_dracula.black, gui = "bold" },
  },
  visual = {
    a = { bg = c_dracula.pink, fg = c_dracula.black, gui = "bold" },
  },
  replace = {
    a = { bg = c_dracula.red, fg = c_dracula.black, gui = "bold" },
  },
  command = {
    a = { bg = c_dracula.orange, fg = c_dracula.black, gui = "bold" },
  },
  inactive = {
    a = { bg = c_dracula.gray, fg = c_dracula.white, gui = "bold" },
    b = { bg = c_dracula.lightgray, fg = c_dracula.white },
    c = { bg = c_dracula.gray, fg = c_dracula.stealth },
  },
}

local c_nord = {
  nord1 = "#434C5E",
  -- nord3 = "#4C566A",
  nord3 = "#363E4C",
  nord4 = "#96A6C4",
  nord5 = "#B1BDD2",
  nord6 = "#ECEFF4",
  nord7 = "#8FBCBB",
  nord8 = "#88C0D0",
  nord9 = "#81A1C1",
  nord11 = "#BF616A",
  nord13 = "#EBCB8B",
  nord15 = "#B48EAD",
}

local nord_custom = {
  normal = {
    a = { fg = c_nord.nord1, bg = c_nord.nord8, gui = "bold" },
    b = { fg = c_nord.nord5, bg = c_nord.nord1 },
    c = { fg = c_nord.nord4, bg = c_nord.nord3 },
  },
  insert = { a = { fg = c_nord.nord1, bg = c_nord.nord6, gui = "bold" } },
  visual = { a = { fg = c_nord.nord1, bg = c_nord.nord15, gui = "bold" } },
  command = { a = { fg = c_nord.nord1, bg = c_nord.nord13, gui = "bold" } },
  replace = { a = { fg = c_nord.nord5, bg = c_nord.nord11, gui = "bold" } },
  inactive = {
    a = { fg = c_nord.nord1, bg = c_nord.nord8, gui = "bold" },
    b = { fg = c_nord.nord5, bg = c_nord.nord1 },
    c = { fg = c_nord.nord4, bg = c_nord.nord3 },
  },
}

local c_rose_pine = {
  _nc = "#16141f",
  base = "#191724",
  surface = "#1f1d2e",
  overlay = "#26233a",
  muted = "#6e6a86",
  subtle = "#908caa",
  text = "#e0def4",
  love = "#eb6f92",
  gold = "#f6c177",
  rose = "#ebbcba",
  pine = "#31748f",
  foam = "#9ccfd8",
  iris = "#c4a7e7",
  leaf = "#95b1ac",
  highlight_low = "#21202e",
  highlight_med = "#403d52",
  highlight_high = "#524f67",
  none = "NONE",
}

local rose_pine_custom = {
  normal = {
    a = { bg = c_rose_pine.rose, fg = c_rose_pine.base, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.rose },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.subtle },
  },
  insert = {
    a = { bg = c_rose_pine.foam, fg = c_rose_pine.base, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.foam },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.subtle },
  },
  visual = {
    a = { bg = c_rose_pine.iris, fg = c_rose_pine.base, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.iris },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.subtle },
  },
  replace = {
    a = { bg = c_rose_pine.pine, fg = c_rose_pine.base, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.pine },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.subtle },
  },
  command = {
    a = { bg = c_rose_pine.love, fg = c_rose_pine.base, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.love },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.subtle },
  },
  inactive = {
    a = { bg = c_rose_pine.surface, fg = c_rose_pine.muted, gui = "bold" },
    b = { bg = c_rose_pine.highlight_med, fg = c_rose_pine.muted },
    c = { bg = c_rose_pine.surface, fg = c_rose_pine.muted },
  },
}

local c_github_light = {
  -- blue = "#0A69DA",
  blue = "#0859B8",
  blue_light = "#CFE1F8",
  blue_fg = "#6BA5E9",
  blue_fg1 = "#3A87E1",
  green = "#106329",
  green_light = "#CFE0D4",
  green_fg = "#70A17F",
  green_fg1 = "#418254",
  purple = "#A475F9",
  purple_light = "#EDE3FE",
  purple_fg = "#C8ACFB",
  purple_fg1 = "#B691FA",
  yellow = "#9B6700",
  yellow_light = "#DBD5CC",
  yellow_fg = "#948166",
  yellow_fg1 = "#715733",
  red = "#CF212E",
  red_light = "#F5D3D6",
  red_fg = "#E27A82",
  red_fg1 = "#D94E58",
  white = "#F4F4F4",
  bg = "#EFEFEF",
}

local github_light_custom = {
  normal = {
    a = { bg = c_github_light.blue, fg = c_github_light.white },
    b = { bg = c_github_light.blue_light, fg = c_github_light.blue_fg1 },
    c = { bg = c_github_light.bg, fg = c_github_light.blue_fg },
  },
  insert = {
    a = { bg = c_github_light.purple, fg = c_github_light.white },
    b = { bg = c_github_light.purple_light, fg = c_github_light.purple_fg1 },
    c = { bg = c_github_light.bg, fg = c_github_light.purple_fg },
  },
  visual = {
    a = { bg = c_github_light.yellow, fg = c_github_light.white },
    b = { bg = c_github_light.yellow_light, fg = c_github_light.yellow_fg1 },
    c = { bg = c_github_light.bg, fg = c_github_light.yellow_fg },
  },
  replace = {
    a = { bg = c_github_light.red, fg = c_github_light.white },
    b = { bg = c_github_light.red_light, fg = c_github_light.red_fg1 },
    c = { bg = c_github_light.bg, fg = c_github_light.red_fg },
  },
  command = {
    a = { bg = c_github_light.green, fg = c_github_light.white },
    b = { bg = c_github_light.green_light, fg = c_github_light.green_fg1 },
    c = { bg = c_github_light.bg, fg = c_github_light.green_fg },
  },
}

M.theme = {
  ["nord"] = nord_custom,
  ["dracula"] = dracula_custom,
  ["rose-pine"] = rose_pine_custom,
  ["github_light"] = github_light_custom,
  -- ["rose-pine"] = "rose-pine-alt",
}

return M
