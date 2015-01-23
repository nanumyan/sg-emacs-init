
;; default font
(set-default-font '(:family "Droid Sans Mono-14" :height 110)) ; "Source Code Pro"

;; Use variable width font faces in current buffer
(defun my-buffer-face-mode-variable ()
"Set font to a variable width (proportional) fonts in current buffer"
(interactive)
(setq buffer-face-mode-face '(:family "Noto Sans" :height 110))
(buffer-face-mode))

;; Use monospaced font faces in current buffer
(defun my-buffer-face-mode-fixed ()
"Sets a fixed width (monospace) font in current buffer"
(interactive)
(setq buffer-face-mode-face '(:family "Droid Sans Mono" :height 110)) ;; Source Code Pro
(buffer-face-mode))

;; Set default font faces for some modes
(add-hook 'org-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'Info-mode-hook 'my-buffer-face-mode-variable)
(add-hook 'text-mode-hook 'my-buffer-face-mode-variable)

(add-hook 'python-mode-hook 'my-buffer-face-mode-fixed)

;; Enable syntax highlighting when editing code.
(global-font-lock-mode t) 


;(global-linum-mode t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(show-paren-mode 1)
(display-time-mode t)
(column-number-mode t)

;; no startup msg  
(setq inhibit-startup-message t)

;; theme from =sublime-themes=
(load-theme 'spolsky t) ; I like spolsky and hickey

;; disable the sound
(setq visible-bell 1)
;; Turn off the bell completely (annoying at least with thinkpad trackpad)
;(setq ring-bell-function 'ignore)

;; start maximized
(toggle-frame-maximized)

;; start maximized - FOR EMACS OLDER THAN 24.4
;(defun toggle-fullscreen ()
;  (interactive)
;  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32	 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32	 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;  )
;(toggle-fullscreen)
;(global-set-key [f11] 'toggle-fullscreen)

;; opacity when Emacs not on focus 
(set-frame-parameter (selected-frame) 'alpha '(100 90)) ;  '(<active> [<inactive>])
;(add-to-list 'default-frame-alist '(alpha 100 90))  ;'(<active> [<inactive>])



;; mode-line theme
(require 'powerline)
(powerline-default-theme)
(set-face-attribute 'mode-line nil
                    :family "Noto Sans"
                    :foreground "Grey85"
                    :background "Grey15"
                    :box nil)
(setq powerline-arrow-shape 'curve)

;; smooth scrolling
(require 'nurumacs)


;; Org-mode colors
(defface org-block-begin-line
  '((t (:foreground "#B8B8B8" :background "#3E454F")))
  "Face used for the line delimiting the begin of source blocks.")

(defface org-block-background
  '((t (:background "#232930")))
  "Face used for the source block background.")

(defface org-block-end-line
  '((t (:foreground "#B8B8B8" :background "#3E454F"))) ;EAEAFF
  "Face used for the line delimiting the end of source blocks.")
