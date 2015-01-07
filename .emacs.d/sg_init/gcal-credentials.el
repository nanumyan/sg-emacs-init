(require 'org-gcal)
(setq org-gcal-client-id "your-id-foo.apps.googleusercontent.com"
      org-gcal-client-secret "your-secret"
      org-gcal-file-alist '(("your-calendar-id@gmail.com" .  "~/your-org-path/schedule.org")
                            ("another-calendar-id@gmail.com" .  "~/your-org-path/task.org")))
