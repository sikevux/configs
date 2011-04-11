;; -*- mode: emacs-lisp -*-
;; Sikevux's main emacs config
;; semi commented for lazines
(setq vc-initial-comment t)

;; Fuck xemacs!
(when (featurep 'xemacs)
  (error "This machine runs xemacs, install GNU Emacs first."))

;; My custom lisps
(add-to-list 'load-path "~/.emacs.d/moin/")

;; Undo redo it's nice
(require 'redo+)
(define-key global-map [f2] 'undo)
(define-key global-map [f3] 'redo)
(define-key global-map [f4] 'indent-region)

;; Seriously!
(set-terminal-coding-system 'utf-8)

;; Here be fishes
(eval-after-load "em-term"
  '(add-to-list 'eshell-visual-commands "fish"))

;; I die a bit every time someone uses space for indentation. 
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq default-tab-width 4)
(setq tab-width 4)
(setq c-basic-indent 4)

;; Org moooode
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; Muuu
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(global-hl-line-mode 1)
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
(set-cursor-color "red")
(set-mouse-color "blue")
(set-face-background 'region "green")
(set-background-color "black")

(setq inhibit-startup-message t)
(put 'scroll-left 'disabled nil)
(auto-compression-mode 1)

(custom-set-variables
 '(column-number-mode t)
 '(display-battery-mode t)
 '(display-time-24hr-format t)
 '(display-time-day-and-date nil)
 '(display-time-default-load-average t)
 '(display-time-mail-file (quote none)) 
 '(display-time-mode t)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

(setq frame-title-format '(buffer-file-name "%f" ("%b")))

(require 'linum)
(global-linum-mode t)
(menu-bar-mode 0)

(require 'identica-mode)
(setq identica-username "sikevux")
(setq identica-password "Aeo!ieuropmTIeot#43unecd")
(setq statusnet-server "status.telecomix.org")