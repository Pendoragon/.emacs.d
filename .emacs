;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; defines ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar system-type-as-string (prin1-to-string system-type))
(defvar on_windows_nt (string-match "windows-nt" system-type-as-string))
(defvar on_darwin     (string-match "darwin" system-type-as-string))
(defvar on_gnu_linux  (string-match "gnu/linux" system-type-as-string))
(defvar on_cygwin     (string-match "cygwin" system-type-as-string))
(defvar on_solaris    (string-match "usg-unix-v" system-type-as-string))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; package ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list  'package-archives	
	      '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  misc.  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set theme and font
(load-theme 'zenburn t)
(set-default-font "-apple-Monaco-medium-normal-normal-*-14-*-*-*-m-0-iso10646-1")
(set-face-attribute 'default nil :height 100) ;; set default font size

;; enable auto-complete
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;; configure yasnippet (To add a new snippet, use M-x yas/new-snippet)
(require 'yasnippet)
(yas/global-mode 1)
(setq yas/root-directory "~/.emacs.d/elpa/yasnippet-20120923.1126/snippets/")
(yas/load-directory yas/root-directory)

;; enable multi-web-mode
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
		  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
		  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5" "jsp"))
(multi-web-global-mode 1)

;; cedet
;; (load-file "~/.emacs.d/cedet-1.1/common/cedet.el")
;; (global-ede-mode 1)		; Enable the Project management system
;(semantic-load-enable-code-helpers) ; Enable prototype help and smart completion 
;; (global-srecode-minor-mode 1)	    ; Enable template insertion menu
;; (setq x-max-tooltip-size '(80 . 40))

;; ctags (etags)
(ctags-auto-update-mode 1)

;; enable flymake
(autoload 'flymake-find-file-hook "flymake" "" t)
(add-hook 'find-file-hook 'flymake-find-file-hook)
(setq flymake-gui-warnings-enabled nil)
(setq flymake-log-level -1)

;; keyboard for emacs running in OS X
(cond (on_darwin
       (setq mac-command-modifier 'meta) ; sets the Command key as Meta
       (setq mac-option-modifier 'super) ; sets the left Option key as Super
       (setq mac-right-option-modifier 'hyper) ; sets the Option key as Hyper
       (setq mac-control-modifier 'ctrl) ; sets the Control key as Control
       ))

;; key bindings
(global-set-key [f1] 'find-file)	; M-x open file (C-x-f)
(global-set-key [f2] 'save-buffer)	; M-x save file (C-x-s)
(global-set-key [f3] 'other-window)	; M-x other-window (C-x o)
(global-set-key [f4] 'switch-to-buffer) ; M-x switch-to-buffer (C-x b)
(global-set-key [f5] 'shell-command)	; M-x shell-command
(global-set-key [f8] 'bookmark-jump)	; m-x bookmark-set (C-x r b)
(global-set-key [f9] 'ns-toggle-fullscreen) ; M-x ns-toggle-fllscreen
(global-set-key [f10] 'delete-other-windows) ; M-x delete-other-windows (C-x 1)
(global-set-key (kbd "M-p") 'previous-line) ; Set M-p the same as C-p to release finger
(global-set-key (kbd "M-n") 'next-line)	; Set M-n the same as C-n to release finger
(global-set-key (kbd "M-a") 'move-beginning-of-line) ; Set M-a the same as C-a to release finger
(global-set-key (kbd "M-e") 'move-end-of-line)	; Set M-e the same as C-e to release finger
(global-set-key (kbd "C-.") 'godef-jump) ; M-x godef-jump
(global-set-key (kbd "C-,") 'flymake-display-err-menu-for-current-line) ; M-x flymake-display-err-menu-for-current-line
(global-set-key (kbd "C-x e") 'erase-buffer) ; M-x erase-buffer (erase entire buffer)
(global-set-key (kbd "C-s-<left>") 'shrink-window-horizontally)	; shrink window horizontally
(global-set-key (kbd "C-s-<right>") 'enlarge-window-horizontally) ; enlarge window horizontally
(global-set-key (kbd "C-s-<down>") 'shrink-window) ; shrink window vertically
(global-set-key (kbd "C-s-<up>") 'enlarge-window) ; enlarge window vertically
(global-set-key (kbd "M-<left>") 'undo)

;; others
(define-key global-map (kbd "RET") 'newline-and-indent) ; newline and then indent
(setq make-backup-files nil)	  ; no backup files (which end with ~)
(setq auto-save-default nil) ; no auto save files (which is surrounded by #)
(setq inhibit-splash-screen t) ; disable splash screen (no startup screen, enter *scratch*)
(setq show-help-function nil) ; disable the tooltips in modeline (Disable whole help function, better to use M-x tooltip-mode RET)
(setq ns-pop-up-frames nil) ; open in new buffer instead of new frame when choose "open with emacs"
(setq confirm-nonexistent-file-or-buffer nil)
(setq c-basic-indent 2)			; set up tabs
(setq tab-width 4)
(setq indent-tabs-mode nil)
(setq-default c-basic-offset 4)		; set tab indent to 4 spaces in cc mode (C, java ...)
;(setq split-height-threshold nil)	; split window side-by-side(horizontally) by default (when font is bigger)
;(setq split-width-threshold 0)		; split window side-by-side(horizontally) by default
;(menu-bar-mode -99)		; disable menue (usefull in terminal)
(server-start)			; start server (type `emacs` can open file in current instance of emacs. `emacs` is alias to `emacsclient`)
(column-number-mode)		; show column number
(defalias 'yes-or-no-p 'y-or-n-p) ; answer `y` or `n` for `yes` or `no

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  fun   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable bell when hit c-g
(setq ring-bell-function 
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))

;; kill all other buffers
(defun kill-other-buffers ()
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  automatic generate (go)  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(put 'erase-buffer 'disabled nil)

(add-to-list 'load-path "~/.emacs.d/modes/")
(require 'go-mode-autoloads)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(exec-path-from-shell-copy-env "GOPATH")

(defun go-mode-setup ()
 (setq compile-command "go build -v && go test -v && go vet")
 (define-key (current-local-map) "\C-c\C-c" 'compile)
 (go-eldoc-setup)
 (setq gofmt-command "goimports")
 (add-hook 'before-save-hook 'gofmt-before-save)
 (local-set-key (kbd "C-.") 'godef-jump))
(add-hook 'go-mode-hook 'go-mode-setup)
