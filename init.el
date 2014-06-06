(if window-system
      (set-frame-size (selected-frame) 200 54))
(load-theme 'maxmink t)
(set-fringe-mode '(1 . 0))
(show-paren-mode 1)

(setenv "PATH" (concat (getenv "HOME") "/bin:"
		       "/usr/local/bin:"
		       (getenv "PATH")))

(setq exec-path (append exec-path '("/usr/local/bin/")))

(let ((default-directory "~/.emacs.d/vendor/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

(when (> emacs-major-version 23)
	(require 'package)
	(package-initialize)
	(add-to-list 'package-archives
		     '("melpa" . "http://melpa.milkbox.net/packages/")
		     'APPEND))
(setq visible-bell t)
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

(require 'multiple-cursors)
(require 'wrap-region)
(wrap-region-mode t)

(global-set-key "\C-c#" 'comment-or-uncomment-region)
(defadvice comment-or-uncomment-region (before slick-comment activate compile)
  "When called interactively with no active region, comment a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

;; DASH
(add-to-list 'load-path "dash-at-point")
(autoload 'dash-at-point "dash-at-point"
	  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)

;; in modes
(set 'dash-at-point-mode-alist ())
(add-to-list 'dash-at-point-mode-alist '(ruby-mode . "ruby"))


;; SASS-SCSS

(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq scss-compile-at-save nil)
(defun customizations-for-sass-mode ()
  (interactive)
  (flyspell-prog-mode)
  (flymake-sass-load)
  (linum-mode t)
  (fci-mode)
  (auto-complete-mode)
  (setq indent-tabs-mode nil)
  (setq tab-width 2)
  (setq highlight-indentation-offset 2)
  (highlight-indentation-mode)
  (highlight-indentation-current-column-mode)
)

(add-hook 'sass-mode-hook 'customizations-for-sass-mode)

;; HAML
(require 'haml-mode)
(add-hook 'haml-mode-hook
	     '(lambda ()
		    (setq indent-tabs-mode nil)
		    (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;; Coffeescript Mode setup
(add-to-list 'load-path "~/.emacs.d/vendor/coffee-mode")
(require 'coffee-mode)
(defun coffee-custom ()
  "coffee-mode-hook"
 (set (make-local-variable 'tab-width) 2))
 (define-key coffee-mode-map [(s-r)] 'coffee-compile-region)
 (define-key coffee-mode-map [(s-R)] 'coffee-compile-buffer)

(add-hook 'coffee-mode-hook
  '(lambda() (coffee-custom))
)
(custom-set-variables '(coffee-tab-width 2))

(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace
(global-whitespace-mode)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; START: Ruby / Rails setup

;; Interactively Do Things (highly recommended, but not strictly required)
(require 'ido)
(ido-mode t)


;; Assign .rb, .rake and GEMFILE files to use ruby mode
(setq auto-mode-alist (cons '("\\.rb\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.rake\\'" . ruby-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\GEMFILE\\'" . ruby-mode) auto-mode-alist))

;; Show syntax highlighting when in ruby mode
(add-hook 'ruby-mode-hook '(lambda () (font-lock-mode 1)))

;; END: Ruby / Rails setup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(add-to-list 'load-path "/path/to/ack-and-a-half")
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(require 'handlebars-mode)


;; (require 'autopair)
;; (autopair-global-mode) ;; to enable in all buffers

(electric-pair-mode)

(require 'textmate)
(textmate-mode)

;; (require 'icicles)

(require 'whole-line-or-region)
(whole-line-or-region-mode) ;; to enable in all buffers



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-command "/usr/local/bin/coffee")
 '(coffee-js-mode (quote Javascript))
 '(css-indent-offset 2)
 '(custom-safe-themes (quote ("27b413061e87e7942c858e351c61915b2c4d88f33f86f5df4cb7e129707f519a" "97d8e9c858500ad5d642691b41e99153677842915b99b6fe39849aee0d47cdd9" "404daa8fce5ddf652e607f55c3fac52b04bc058211e463668d780a4e39c9282a" "47674274ab98da21f4b955a0246fb97bd6abfab9a0bf478373ab67580ceee568" "17927a37ac39f1111b24c392d8f6796610226a2fa90c399819072f654631d8e2" "56c2a22f1ffa3ff79b6d21867e6e3889ba29ffa9a74b4b39ee95bb7e2050a7f5" "e42898fa676fe8dcd5d93f9b02ae2e3fd167137b9c7ed99cd0442febafb1ba4d" "9bb90f5aa884f41c469dfe3c97f8214095b78b18ad89c139698aa88e35ab3a47" "d4dccc5d66eaa8bd06dff1f29b41220cb2db8344f948eacce90d96cdbb0c22d8" default)))
 '(display-time-mode nil)
 '(frame-background-mode nil)
 '(global-linum-mode t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(js-indent-level 2)
 '(ns-tool-bar-display-mode (quote both) t)
 '(ns-tool-bar-size-mode (quote regular) t)
 '(size-indication-mode t)
 '(tool-bar-mode nil)
 '(visual-line-mode nil t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(put 'upcase-region 'disabled nil)

(add-hook
 'align-load-hook
 (lambda ()
   (add-to-list
    'align-rules-list
    '(symbol-value-alignment
      (regexp . ":\\(\\s-*\\)")
      (group . 1)
      (modes . '(ruby-mode coffee-mode))
      (repeat . nil)))))


(global-set-key (kbd "s-=") 'zoom-frm-in)
(global-set-key (kbd "s--") 'zoom-frm-out)
(global-set-key (kbd "s-0") 'zoom-frm-unzoom)

(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(global-auto-complete-mode)
(put 'downcase-region 'disabled nil)
