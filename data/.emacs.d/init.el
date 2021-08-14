;; .emacs

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'powerline)
(powerline-default-theme)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#ff6188" "#fcfcfa"])
 '(ansi-term-color-vector
   [unspecified "#2d2a2e" "#ff6188" "#a9dc76" "#ffd866" "#78dce8" "#ab9df2" "#ff6188" "#fcfcfa"])
 '(custom-enabled-themes (quote (custom-dark)))
 '(custom-safe-themes
   (quote
    ("12fd668c90c4e32e07d24385b2b4cd7a81758bf5872ff17374e65857974e67a7" "36ca907d32cfd617319e5eb23f3aeb0fcc9acc0e9ffcaf1fcaab21e5a23d4ff6" "d99ba4ba502299f8cfd7750b78cc7e154eb25ac0b2223378c415b8a76551c3eb" "9a94d9cfd0b38389fba7d9645d283066197cbd2cfd1599b04993e88acdbcb925" "02afde53c32890d806114cf5fd5e3c737fb70027abfc45e10b9536a8425f9f44" "8069469aef3c8579fb5d21ad60251a200b65f5e4a0edba450eaff6dc3ebb907a" "ae14e91e93099e53e1e6955f977d34f7405bd26e07841d0c5c5b55634d76ffbe" "e6487d2f5e95f2d834566b8ca90d560210559ceb5152f99ca776333a029fc4f4" "9298b11f0ec88c826cd652303c183e314604d69176de5e545574545eee7d17c0" "eb6a808a744abcd292eb46ec795121bb6fc53100e970a5d0acc44ece2fa2bce2" "009d2d3f0f1926ff084b2ce3d681aeb5074fc244e80983ee540eb8d74c58c9e7" "930f7841c24772dda4f22291e510dac1d58813b59dcb9f54ad4f1943ea89cdcd" default)))
 '(diff-switches "-u")
 '(package-selected-packages (quote (powerline monokai-pro-theme))))

;; transparent background
(defun set-background-for-terminal (&optional frame)
  (or frame (setq frame (selected-frame)))
  "unsets the background color in terminal mode"
  (unless (display-graphic-p frame)
    (set-face-background 'default "unspecified-bg" frame)))
(add-hook 'after-make-frame-functions 'set-background-for-terminal)
(add-hook 'window-setup-hook 'set-background-for-terminal)

;;; uncomment for CJK utf-8 support for non-Asian users
;; (require 'un-define)
(defun set-newline-and-indent ()
    (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'c-mode 'set-newline-and-indent)

(defun infer-indentation-style ()
  ;; if our source file uses tabs, we use tabs, if spaces spaces, and if
  ;; neither, we use the current indent-tabs-mode
  (let ((space-count (how-many "^  " (point-min) (point-max)))
        (tab-count (how-many "^\t" (point-min) (point-max))))
    (if (> space-count tab-count) (setq indent-tabs-mode nil))
    (if (> tab-count space-count) (setq indent-tabs-mode t))))

(setq c-basic-offset 4)
(setq tab-width 4)
(setq-default indent-tabs-mode nil)
(infer-indentation-style)
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

(global-set-key (kbd "<M-up>") 'move-line-up)
(global-set-key (kbd "<M-down>")  'move-line-down)

(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

(global-linum-mode t)
(setq linum-format "%4d \u2502 ")

(electric-pair-mode)

(set-frame-font "Fira Code 12" nil t)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
