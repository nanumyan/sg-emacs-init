;; maybe el-get one day?
(require 'package)

;; list the packages you want
(defvar required-packages
  '(
    ac-math
    org
    org-ac
    org-gcal
    org-bullets
    ipython
    dired+
    powerline
    writeroom-mode
    sublime-themes
    polymode
    workgroups2
    ;yasnippet
    nurumacs
  ) "a list of packages to ensure are installed at launch.")

;; list the repositories containing them
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
			 ("melpa" . "http://melpa.milkbox.net/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; activate all the packages (in particular autoloads)
(package-initialize)

(require 'cl)
;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in required-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p required-packages)
    (when (not (package-installed-p p))
      (package-install p))))


;; load packages

