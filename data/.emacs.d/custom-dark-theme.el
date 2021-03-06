(deftheme custom-dark
  "Created 2019-10-10.")

(custom-theme-set-faces
 'custom-dark
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "#fcfcfa" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 1 :width normal :foundry "default" :family "default"))))
 '(cursor ((t (:background "#fcfcfa"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((t (:foreground "#fcfcfa"))))
 '(highlight ((t (:foreground "#727072" :background "#353236"))))
 '(region ((t (:background "#403e41"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:background "#403e41"))))
 '(trailing-whitespace ((t (:foreground "#fcfcfa" :background "#ff6188"))))
 '(font-lock-builtin-face ((t (:foreground "#ab9df2"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#727072"))))
 '(font-lock-comment-face ((t (:slant italic :foreground "#727072"))))
 '(font-lock-constant-face ((t (:foreground "#ab9df2"))))
 '(font-lock-doc-face ((t (:foreground "#727072"))))
 '(font-lock-function-name-face ((t (:foreground "#a9dc76"))))
 '(font-lock-keyword-face ((t (:foreground "#ff6188"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "#ffd866"))))
 '(font-lock-type-face ((t (:foreground "#78dce8"))))
 '(font-lock-variable-name-face ((t (:foreground "#fcfcfa"))))
 '(font-lock-warning-face ((t (:foreground "#fc9867"))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "#78dce8"))))
 '(link-visited ((t (:underline (:color foreground-color :style line) :foreground "#ab9df2"))))
 '(fringe ((t (:background "#403e41"))))
 '(header-line ((t (:inherit (mode-line)))))
 '(tooltip ((((class color)) (:inherit (variable-pitch) :foreground "black" :background "lightyellow")) (t (:inherit (variable-pitch)))))
 '(mode-line ((t (:foreground "#939293" :background "#353236"))))
 '(mode-line-buffer-id ((t (:foreground "#ffd866"))))
 '(mode-line-emphasis ((t (:slant italic :foreground "#c1c0c0"))))
 '(mode-line-highlight ((t (:weight bold :box nil :foreground "#fcfcfa"))))
 '(mode-line-inactive ((t (:foreground "#939293" :background "#403e41"))))
 '(isearch ((t (:weight bold :foreground "#2d2a2e" :background "#ffd866"))))
 '(isearch-fail ((t (:foreground "#ff6188" :background "#fcfcfa"))))
 '(lazy-highlight ((t (:inverse-video t :foreground "#c1c0c0"))))
 '(match ((t (:inverse-video t :foreground "#ffd866" :background "#2d2a2e"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'custom-dark)
