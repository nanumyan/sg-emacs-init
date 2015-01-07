;; larger fill column
(setq-default fill-column 100)

;; wrap lines by default
(visual-line-mode t)

;; don't show holidays, show local
(setq christian-holidays nil)
(setq hebrew-holidays nil)
(setq islamic-holidays nil)

;; Ensure ibuffer opens with point at the current buffer's entry.
(defadvice ibuffer
  (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name."
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)


;; backup files
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 3    ; and how many of the old
  )

;; Dired+
(require 'dired+)
;; reuse the same buffer when navigating in directories
(toggle-diredp-find-file-reuse-dir 1)

;; smarter mini-buffer
(require 'ido)
(ido-mode t)

;; undo/redo window configuration
(when (fboundp 'winner-mode)
      (winner-mode 1))



;; global autocomplete on
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
()


;; restore buffers from the previous session
;; I think, this needs to be at the end-ish
(require 'desktop)
(desktop-save-mode 1)

;; save different window configurations
;; ! check emacs native solution
(when 
    (require 'workgroups2 nil 'noerror)
  (setq wg-emacs-exit-save-behavior           'ask)
  (setq wg-workgroups-mode-exit-save-behavior 'ask)
(workgroups-mode 1)
)


