

;; Nice bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;; load org
(require 'org)
(require 'ox-latex)
(require 'ox-beamer)

(require 'org-ac)
(org-ac/config-default)
(add-to-list 'ac-modes 'org-mode)

;; Google Calendar Sync
;; https://github.com/myuhe/org-gcal.el
(require 'org-gcal)
(load "gcal-credentials")

;; MobileOrg
(setq org-mobile-directory "~/Dropbox/MobileOrg")
(setq org-mobile-inbox-for-pull "~/ORG/mobileorg-inbox.org")

(setq org-src-fontify-natively t)
(setq org-startup-indented t)

;; Ignoring electric indentation
(defun electric-indent-ignore-org (char)
  "Ignore electric indentation for python-mode"
  (if (equal major-mode 'org-mode)
      `no-indent'
    nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-org)


;(define-key org-mode-map "\M-q" 'longlines-mode)
;; Make org-mode work with files ending in .org
;;(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-tag-alist '(("@work" . ?w)
		      ("@home" . ?h)
		      ("laptop" . ?l)
		      ("reading" . ?r)))
(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
;(require 'ox-md)

(setq org-directory
      "~/ORG")

(setq org-agenda-files
      '("~/ORG"
	"~/SG"
	"~/SG/ORG/"
	"~/SG/ORG/research"))

(setq org-default-notes-file
      "~/ORG/notes.org")
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/ORG/TODO.org" "Tasks")
             "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/ORG/journal.org")
             "* %?\nEntered on %U\n  %i\n  %a")))

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (R . t)
   (sql . t)
   (sh . t)))
(setq org-babel-python-mode 'python)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images)   
(add-hook 'org-mode-hook 'org-display-inline-images)

(setq org-babel-use-quick-and-dirty-noweb-expansion t)

;; Block header defaults
(setq org-babel-default-header-args
       '((:noweb . "yes")
	 (:comments . "link")
	 (:results . "replace")
	 (:cache . "yes")))

;; Org-LaTeX export
(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

(setq org-export-with-sub-superscripts nil)
(setq org-export-date-timestamp-format "%B %d, %Y")
(setq org-latex-listings t)
(add-to-list 'org-latex-packages-alist '("" "listings"))
(add-to-list 'org-latex-packages-alist '("" "color"))
(add-to-list 'org-latex-packages-alist '("" "graphicx"))
(add-to-list 'org-latex-packages-alist '("" "longtable"))
(add-to-list 'org-latex-packages-alist '("" "graphicx"))
(add-to-list 'org-latex-packages-alist '("utf8" "inputenc"))
(add-to-list 'org-latex-packages-alist '("" "amsmath"))
(add-to-list 'org-latex-packages-alist '("" "tikz"))

(add-to-list 'org-latex-classes
	     '("ethpaper"
"\\documentclass{ETHpaper}

[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]

\\usepackage{./codestyle}
\\usepackage{./special_commands}
\\lstset{style=python}
\\reference{Version of \\today}"
	       ("\\section{%s}" . "\\section*{%s}")
	       ("\\subsection{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")))

(add-to-list 'org-latex-classes
	     '("sg-ethclass"
"\\documentclass{SG-ETHclass}

[NO-DEFAULT-PACKAGES]                
[PACKAGES]

\\usepackage{./codestyle}
\\usepackage{./special_commands_beamer}
\\lstset{style=python}
 \\usepackage{kmath}
 \\usepackage{eulervm}

\\institute{Chair of Systems Design}
\\newcommand{\\place}{place}
\\newcommand{\\homepage}{www.sg.ethz.ch}
\\newcommand{\\shorttitle}{shorttitle}
\\newcommand{\\collaborators}{collaborators} 
\\newcommand{\\event}{Agent-based Modelling of Social Systems}
\\newcommand{\\coursepage}{\\footnotesize \\url{http://www.sg.ethz.ch/teaching}}

\\usetikzlibrary{calc,3d}
\\usetikzlibrary{decorations.pathreplacing}
[EXTRA]"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

(defun beamer-bold (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\textbf" contents)))

(defun beamer-red (contents backend info)
  (when (eq backend 'beamer)
    (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\alert" contents)))

(add-to-list 'org-export-filter-bold-functions 'beamer-bold)
(add-to-list 'org-export-filter-underline-functions 'beamer-red)


(add-to-list 'org-beamer-environments-extra
             '("onlyenv" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}"))

(setq org-latex-pdf-process
;      '("rubber -d --into %o %f"))
      '("latexmk -pdflatex='pdflatex -interaction nonstopmode' -pdf -bibtex -f %f"))


;;; Setup RefTEX to work  with Org-mode
(defun org-mode-reftex-search ()
  ;;jump to the notes for the paper pointed to at from reftex search
  (interactive)
  (org-open-link-from-string (format "[[notes:%s]]" (first (reftex-citation t)))))

(defun my-rtcite-export-handler (path desc format)
  (message "my-rtcite-export-handler is called : path = %s, desc = %s, format = %s" path desc format)
  (let* ((search (when (string-match "::#?\\(.+\\)\\'" path)
                   (match-string 1 path)))
         (path (substring path 0 (match-beginning 0))))
    (cond ((eq format 'latex)
           (if (or (not desc) 
                   (equal 0 (search "rtcite:" desc)))
               (format "\\cite{%s}" search)
             (format "\\cite[%s]{%s}" desc search))))))


(defun org-mode-reftex-setup ()
  (load-library "reftex")
  (and (buffer-file-name) (file-exists-p (buffer-file-name))
       (progn
	 ;enable auto-revert-mode to update reftex when bibtex file changes on disk
	 (global-auto-revert-mode t)
	 (reftex-parse-all)
	 ;add a custom reftex cite format to insert links
	 (reftex-set-cite-format
	  '((?b . "[[bib:%l][%l-bib]]")
	    (?n . "[[notes:%l][%l-notes]]")
	    (?p . "[[papers:%l][%l-paper]]")
	    (?u . "[[%U][%l-web]]") ;; Not yet there?
	    (?t . "%t")
	    (?l . "(%a, %y)")
	    (?c . "/%t/ (%a, %y)")
	    (?h . "** TOREAD %t\n   :PROPERTIES:\n   :Custom_ID: %l\n   :END:\n   [[papers:%l][%l-paper]]")))))
  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)
  (define-key org-mode-map (kbd "C-c (") 'org-mode-reftex-search))

(org-add-link-type "rtcite" 
                   'org-bibtex-open
                   'my-rtcite-export-handler)

(add-hook 'org-mode-hook 'org-mode-reftex-setup)

(setq reftex-default-bibliography
      '("~/SG/bibliography.bib"))

(setq org-link-abbrev-alist
      '(("bib" . "rtcite:~/SG/bibliography.bib::%s")
	("notes" . "rtcite:~/SG/ORG/sg_refnotes.org::#%s")
	("papers" . "~/SG/papers/%s.pdf")
	("google" . "http://www.google.com/search?q=%s")))

(setq org-tags-column -100)

(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

(setq org-agenda-include-diary nil)
