

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Latex for Emacs
;; 
;; Dependencies: okular, texlive-full, auctex
;;
;; Okular setup: 
;; 1.) Open Okular and go to...
;; 2.) Settings -> Configure Okular -> Editor
;; 3.) Set Editor to "Emacs client"
;; 4.) Command should automatically set to: 
;; emacsclient -a emacs --no-wait +%l %f
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; only start server for okular comms when in latex mode
(require 'server)
(or (server-running-p)
    (server-start))
(add-hook 'LaTeX-mode-hook 'server-start)
(setq TeX-PDF-mode t) ;; use pdflatex instead of latex

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Standard emacs/latex config
;; http://emacswiki.org/emacs/AUCTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)

;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Enable synctex correlation
(setq TeX-source-correlate-method 'synctex)
;; Enable synctex generation. Even though the command shows
;; as "latex" pdflatex is actually called
(custom-set-variables '(LaTeX-command "latex -synctex=1") )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; use Okular to view AUCTeX-generated PDFs
(when (require 'latex nil t)
  (push '("%(masterdir)" (lambda nil (file-truename (TeX-master-directory))))
        TeX-expand-list)
  (push '("Okular" "okular --unique %o#src:%n%(masterdir)./%b")
        TeX-view-program-list)
  (push '(output-pdf "Okular") TeX-view-program-selection))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autocomplete for LaTeX
(add-to-list 'ac-modes 'latex-mode)   ; make auto-complete aware of `latex-mode`

(defun ac-latex-mode-setup ()         ; add ac-sources to default ac-sources
  (setq ac-sources
     (append '(ac-source-math-unicode ac-source-math-latex ac-source-latex-commands)
               ac-sources)))

(add-hook 'TeX-mode-hook 'ac-latex-mode-setup)
(ac-flyspell-workaround)
