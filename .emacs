(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(safe-local-variable-values (quote ((rpm-change-log-uses-utc . t)))))

(set-terminal-coding-system 'utf-8)
(setq indent-tabs-mode t)
(setq-default indent-tabs-mode t)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq default-tab-width 4)
(setq tab-width 4)
(setq c-basic-indent 4)
(setq c-backspace-function 'backward-delete-char)
(global-set-key (kbd "DEL") 'backward-delete-char)

;; Org mode
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
;(set-face-background 'region "green")
(set-background-color "black")
(set-foreground-color "gray")

(setq inhibit-startup-message t)
(put 'scroll-left 'disabled nil)
(auto-compression-mode 1)

(autoload 'markdown-mode "markdown-mode"
	"Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-to-list 'load-path "~/.emacs.d/")
(require 'iso-transl)

(defun terminal-init-screen ()
	"Terminal initialization function for screen."
	;; Use the xterm color initialization code.
	;;(load "term/xterm")
	(load "term/rxvt-256color")
	;;(xterm-register-default-colors)
	(tty-set-up-initial-frame-faces))

;; will add a new line at the end of the file.
(setq require-final-newline t)
(setq mode-require-final-newline t)


(setq default-tab-width 4)

;;(add-hook 'sh-mode-hook '(lambda () (setq tab-width 4)))

;; Fix the worse part about emacs: indentation craziness
;;	 1. When I hit the TAB key, I always want a TAB character inserted
;;	 2. Don't automatically indent the line I am editing.
;;	 3. When I hit C-j, I always want a newline, plus enough tabs to put me on
;;		the same column I was at before.
;;	 4. When I hit the BACKSPACE key to the right of a TAB character, I want the
;;		TAB character deleted-- not replaced with tabwidth-1 spaces.
(defun newline-and-indent-relative ()
	"Insert a newline, then indent relative to the previous line."
	(interactive "*") (newline) (indent-relative))
(defun indent-according-to-mode () ())
(defalias 'newline-and-indent 'newline-and-indent-relative)
(defun my-c-hook ()
(defalias 'c-electric-backspace 'delete-backward-char)
(defun c-indent-command () (interactive "*") (self-insert-command 1)))
(add-hook 'c-mode-common-hook 'my-c-hook)
(defun indent-region-with-tab ()
	(interactive)
	(save-excursion
		(if (< (point) (mark)) (exchange-point-and-mark))
		(let ((save-mark (mark)))
			(if (= (point) (line-beginning-position)) (previous-line 1))
				(goto-char (line-beginning-position))
			(while (>= (point) save-mark)
				(goto-char (line-beginning-position))
				(insert "\t")
				(previous-line 1)))))
;;(global-set-key [?\C-x tab] 'indent-region-with-tab)
(global-set-key [f4] 'indent-region-with-tab)
(defun unindent-region-with-tab ()
	(interactive)
	(save-excursion
	(if (< (point) (mark)) (exchange-point-and-mark))
		(let ((save-mark (mark)))
			(if (= (point) (line-beginning-position)) (previous-line 1))
				(goto-char (line-beginning-position))
		(while (>= (point) save-mark)
			(goto-char (line-beginning-position))
			(if (= (string-to-char "\t") (char-after (point))) (delete-char 1))
				(previous-line 1)))))

(setq-default show-trailing-whitespace t)

(setq inhibit-startup-message t)
(c-set-offset 'innamespace '0)

; status bar
(set-face-foreground 'modeline "orange") ; status bar
(set-face-background 'modeline "grey10")

;; shows line AND column in mode line as (LINE,COL)
(column-number-mode 1)

; anti long lines
(custom-set-faces
	'(my-tab-face ((((class color)) (:background "grey12"))) t)
; '(my-trailing-space-face ((((class color)) (:background "grey"))) t)
	'(my-long-line-face ((((class color)) (:background "gray12"))) t))

(add-hook 'font-lock-mode-hook
	(function
		(lambda ()
			(setq font-lock-keywords
				(append font-lock-keywords
					'(("\t+" (0 'my-tab-face t))
					("^.\\{120,\\}$" (0 'my-long-line-face t))
					("[ \t]+$" (0 'my-trailing-space-face t))))))))

(global-set-key (kbd "M-n") 'enlarge-window)
(global-set-key (kbd "M-N") 'shrink-window)
(global-set-key (kbd "M-j") 'enlarge-window-horizontally)
(global-set-key (kbd "M-J") 'shrink-window-horizontally)


(defun set-frame-size-according-to-resolution ()
	(interactive)
	(if window-system
		(progn
			;; use 100 char wide window for largeish displays
			;; and smaller 80 column windows for smaller displays
			(if (> (x-display-pixel-width) 1280)
				(add-to-list 'default-frame-alist (cons 'width 100))
				(add-to-list 'default-frame-alist (cons 'width 80)))
				;; for the height, subtract a couple hundred pixels
				;; from the screen height (for panels, menubars and
				;; whatnot), then divide by the height of a char to
				;; get the height we want
				(add-to-list 'default-frame-alist
				(cons 'height (/ (- (x-display-pixel-height) 200)
				(frame-char-height)))))))

(set-frame-size-according-to-resolution)
