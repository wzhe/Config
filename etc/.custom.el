;; use gruvbox theme
(load-theme 'molokai t)

;; Org
;;http://www.zmonster.me/2018/02/28/org-mode-capture.html
(setq org-agenda-files '("~/my-org/agenda.org"))
(setq org-default-notes-file "~/my-org/inbox.org")

;;(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))
;; key
;; Use `SPC` as leader key
;; all keywords arguments are still supported
(nvmap :prefix "SPC"
       "ff" 'find-file
       "fs" 'save-buffer
       "bb" 'switch-to-buffer
       "cl" 'evilnc-comment-or-uncomment-lines
       "oa" 'org-agenda
       "oc" 'org-capture
       "<SPC>"  'counsel-M-x
       "TAB" 'evil-switch-to-windows-last-buffer
       "w/" 'split-window-right
       "w-" 'split-window-below
       "wM" 'delete-other-windows

       "0" 'winum-select-window-0-or-10
       "1" 'winum-select-window-1
       "2" 'winum-select-window-2
       "3" 'winum-select-window-3
       "4" 'winum-select-window-4
       "5" 'winum-select-window-5
       "6" 'winum-select-window-6
       "7" 'winum-select-window-7
       "8" 'winum-select-window-8
       "9" 'winum-select-window-9
       "qq" 'save-buffers-kill-terminal
       )
