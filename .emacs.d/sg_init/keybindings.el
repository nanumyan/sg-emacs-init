;; RET indents
(define-key global-map (kbd "RET") 'reindent-then-newline-and-indent)


;; Calculator
(autoload 'calculator "calculator" "Run the Emacs calculator." t)
  (global-set-key [(control return)] 'calculator)

;; trigger autocompletion with Win+TAB
;(ac-set-trigger-key "\s-TAB")

;; PS printing
(global-set-key [f12]  'ps-print-buffer)
(global-set-key [f8]  'ps-print-region)

;; org-mode
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; navigate between windows
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;; toggle line wrapping
(global-set-key "\M-q" 'visual-line-mode)


;; Control + scroll to change font type
(global-set-key [C-mouse-4] 'my-buffer-face-mode-fixed)
(global-set-key [C-mouse-5] 'my-buffer-face-mode-variable)

;; Shift + scroll to change font size
(global-set-key [S-mouse-4] 'text-scale-increase)
(global-set-key [S-mouse-5] 'text-scale-decrease)


;; enter Writeroom
(global-set-key [f9] 'writeroom-mode)


;; Google this
(require 'google-this)
(global-set-key (kbd "C-x g") 'google-this-mode-submap)


;; list of buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; dired: move to parent directory
(add-hook 'dired-mode-hook
	  (lambda ()
	    (define-key dired-mode-map (kbd "C-<up>")
	      (lambda () (interactive) (find-alternate-file "..")))
					; was dired-up-directory
	    ))

;; dired: open a file in the leftermost window
(defun dired-window () (window-at 0 1))
(eval-after-load 'dired
  '(define-key dired-mode-map (kbd "o")
     (lambda ()
       (interactive)
       (let ((dired-window (dired-window)))
	 (set-window-buffer dired-window
			    (find-file-noselect 
			     (dired-get-file-for-visit)))
	 (select-window dired-window)))))



;; ORG-MODE: Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'org-mode-hook 'set-newline-and-indent)
