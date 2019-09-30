;; .emacs

(custom-set-variables
 ;; uncomment to always end a file with a newline
 ;'(require-final-newline t)
 ;; uncomment to disable loading of "default.el" at startup
 ;'(inhibit-default-init t)
 ;; default to unified diffs
 '(diff-switches "-u"))

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(defun set-newline-and-indent ()
    (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'c-mode 'set-newline-and-indent)

(setq c-basic-offset 4)
(setq tab-width 4)
(setq indent-tabs-mode nil)
(setq global-linum-mode t)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key [(meta <up>)]  'move-line-up)
(global-set-key [(meta <down>)]  'move-line-down)

(setq backup-directory-alist `(("." . "~/.saves")))
(setq backup-by-copying t)

(global-linum-mode t)
(setq linum-format "%4d \u2502 ")
