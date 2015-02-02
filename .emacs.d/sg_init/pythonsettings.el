;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   PYTHON SETTINGS
(require 'python)

;; 1. =jedi= :: autocompletion and more
;; 2. =anaconda-mode= ::
;; 3. =flycheck/flymake= :: warning and error highlighting
;; 4. =rome= :: for refactoring (add someday)
;; 5. =virtualenvwrapper= :: TODO

;; JEDI
;; run ~M-x jedi:install-server RET~ the first time
;;
;; Keybinds
;;;;;;;;;;;;;;;
;; <C-tab> jedi:complete
;;         Complete code at point.
;; C-c ? jedi:show-doc
;;        Show the documentation of the object at point.
;; C-.
;; C-c . jedi:goto-definition
;;       Goto the definition of the object at point.
;;       Also check out the behaviour with the prefix command(s) (C-u)
;; C-,
;; C-c , jedi:goto-definition-pop-marker
;;       Goto the last point where jedi:goto-definition was called.

(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(add-hook 'python-mode-hook 'jedi:setup)

(eval-after-load "python"
	    '(progn
	       (define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer)
	       (define-key python-mode-map "\M-/" 'jedi:get-in-function-call)
	       ))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)



;; ANACONDA-MODE
;; Key	Description
;; M-.	anaconda-mode-goto-definitions
;; M-*	anaconda-nav-pop-marker
;; M-?	anaconda-mode-view-doc
;; M-r	anaconda-mode-usages

(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'eldoc-mode)


;; SMART-OPERATOR
(require 'smart-operator)
(add-hook 'python-mode-hook 'smart-operator-mode)


;; PROJECTILE
;; project management
;; https://github.com/bbatsov/projectile
;; https://github.com/IvanMalison/org-projectile
;;
;; If you ever forget any of Projectile's keybindings just do a:
;; C-c p C-h
(require 'projectile)
(projectile-global-mode)
;(add-hook 'python-mode-hook 'projectile-mode)

(persp-mode)
(require 'persp-projectile)

;; https://github.com/IvanMalison/org-projectile
