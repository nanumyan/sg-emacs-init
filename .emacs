;; .emacs --- 
;; 
;; Filename: .emacs
;; Description: 
;; Author: Vahan Nanumyan
;; Created: Tue Jan  6 23:11:19 CET 2015
;; Version: 
;; Last-Updated: 
;;           By: 
;;     Update #: 0
;; URL: 
;; Keywords: 
;; Compatibility: Emacs 24.4

(add-to-list 'load-path "~/.emacs.d/sg_init")

;; set and install the needed packages
(load "loadpackages")

;; set the visual settings
(load "visuals")

;; miscellaneous
(load "misc")

;; key bindings
(load "keybindings")

;; Org-mode settings
(load "orgsettings")

;; LaTeX settings
(load "latexsettings")

;; Python settings
(load "pythonsettings")



;;;;;;;;;;;;;;;;;;;;;;
;;;;   R (ESS)

;; autocomplete
(setq ess-use-auto-complete t) ;;(Setq ess-use-auto-complete 'script-only)
;; quick help
;; doesn't work
;define-key ac-completing-map (kbd "M-h") 'ac-quick-help)
;; autocompletion to <TAB> instead of <RET>
;(define-key ac-completing-map [tab] 'ac-complete)
;(define-key ac-completing-map [return] nil)

(require 'polymode)
;; MARKDOWN
;(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))
;; ORG
;(add-to-list 'auto-mode-alist '("\\.org" . poly-org-mode))
;; R related modes
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(defun ess-rmarkdown ()
   "Compile R markdown (.Rmd). Should work for any output type."
   (interactive)
   ; Check if attached R-session
   (condition-case nil
       (ess-get-process)
   (error 
    (ess-switch-process)))
   (let* ((rmd-buf (current-buffer)))
     (save-excursion
       (let* ((sprocess (ess-get-process ess-current-process-name))
              (sbuffer (process-buffer sprocess))
              (buf-coding (symbol-name buffer-file-coding-system))
              (R-cmd
          (format "library(rmarkdown); rmarkdown::render(\"%s\")"
          buffer-file-name)))
    (message "Running rmarkdown on %s" buffer-file-name)
         (ess-execute R-cmd 'buffer nil nil)
         (switch-to-buffer rmd-buf)
         (ess-show-buffer (buffer-name sbuffer) nil)))))
(define-key polymode-mode-map "\M-ns" 'ess-rmarkdown)






;; SQL TODO
(add-hook 'sql-mode-hook
          (lambda ()
            (sql-highlight-mysql-keywords)))
;;(load "sqlup-mode.el")
;(require 'sqlup-mode)
;(add-hook 'sql-mode-hook 'sqlup-mode)
;(add-hook 'sql-interactive-mode-hook 'sqlup-mode)
;(eval-after-load "sql"
;  '(load-library "sql-indent"))




