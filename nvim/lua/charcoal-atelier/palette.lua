-- sRGB colors from charcoal-atelier.json.
local ansi = {
  "#222222", "#d96a4d", "#9aab84", "#cfae7a",
  "#8aa0b4", "#b193a8", "#8fafa8", "#b5b1ab",
  "#5f5c58", "#e8886e", "#b3c39d", "#e0c493",
  "#a4b9cc", "#c8adc0", "#a8c7c0", "#efece7",
}

return {
  ansi = ansi,
  background = "#161616",
  foreground = "#d6d2cc",
  surface = "#1d1d1d",
  overlay = "#262626",
  border = "#4b4a48",
  muted = "#716f6c",
  subtle = "#8f8c88",
  selection = "#3a3835",
  white = ansi[16],
  red = ansi[2],
  sage = ansi[3],
  sand = ansi[4],
  blue = ansi[5],
  mauve = ansi[6],
  teal = ansi[7],
  coral = ansi[10],
  diff_add = "#282a26",
  diff_change = "#26292c",
  diff_delete = "#32231f",
  diff_text = "#2f2b25",
}
