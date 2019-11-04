; use gruvbox theme
(load-theme 'gruvbox t)


;; Org
;;http://www.zmonster.me/2018/02/28/org-mode-capture.html
(setq org-agenda-files '("~/my-org/inbox.org"))
(setq org-default-notes-file "~/my-org/inbox.org")

;; 这边就是为路径赋值
(defvar org-agenda-dir "" "gtd org files location")
(setq-default org-agenda-dir "~/my-org/")
(setq org-agenda-file-note (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-gtd (expand-file-name "gtd.org" org-agenda-dir))
(setq org-agenda-file-task (expand-file-name "task.org" org-agenda-dir))
(setq org-agenda-file-calendar (expand-file-name "calendar.org" org-agenda-dir))
(setq org-agenda-file-finished (expand-file-name "finished.org" org-agenda-dir))
(setq org-agenda-file-canceled (expand-file-name "canceled.org" org-agenda-dir))
(setq org-agenda-file-journal (expand-file-name "journal.org" org-agenda-dir))
(setq org-agenda-file-code-snippet (expand-file-name "snippet.org" org-agenda-dir))

(setq org-default-notes-file (expand-file-name "notes.org" org-agenda-dir))
(setq org-agenda-file-blogposts (expand-file-name "all-posts.org" org-agenda-dir))

(setq org-agenda-files (list org-agenda-dir))
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!/!)")
              (sequence "WAITING(w@/!)" "SOMEDAY(S)" "|" "CANCELLED(c@/!)" "MEETING(m)" "PHONE(p)"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org clock
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Change task state to STARTED when clocking in
(setq org-clock-in-switch-to-state "STARTED")
;; Save clock data and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t) ;; Show the clocked-in task - if any - in the header line

(setq org-tags-match-list-sublevels nil)
;; define the refile targets

;; the %i would copy the selected text into the template
;http://www.howardism.org/Technical/Emacs/journaling-org.html
;;add multi-file journal
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline org-agenda-file-gtd "Workspace")
         "* TODO [#B] %?\n  %i\n %U"
         :empty-lines 1)
        ("n" "notes" entry (file+headline org-agenda-file-note "Quick notes")
         "* %?\n  %i\n %U"
         :empty-lines 1)
        ("b" "Blog Ideas" entry (file+headline org-agenda-file-note "Blog Ideas")
         "* TODO [#B] %?\n  %i\n %U"
         :empty-lines 1)
        ("s" "Code Snippet" entry
         (file org-agenda-file-code-snippet)
         "* %?\t%^g\n#+BEGIN_SRC %^{language}\n\n#+END_SRC")
        ("w" "work" entry (file+headline org-agenda-file-gtd "Work")
         "* TODO [#A] %?\n  %i\n %U"
         :empty-lines 1)
        ("c" "Chrome" entry (file+headline org-agenda-file-note "Quick notes")
         "* TODO [#C] %?\n %(zilongshanren/retrieve-chrome-current-tab-url)\n %i\n %U"
         :empty-lines 1)
        ("l" "links" entry (file+headline org-agenda-file-note "Quick notes")
         "* TODO [#C] %?\n  %i\n %a \n %U"
         :empty-lines 1)
        ("j" "Journal Entry"
         entry (file+datetree org-agenda-file-journal)
         "* %?"
         :empty-lines 1)))

(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ":END:"
                   "\n\n")        ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"              ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+headline org-agenda-file-blogposts "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

;;An entry without a cookie is treated just like priority ' B '.
;;So when create new task, they are default 重要且紧急
(setq org-agenda-custom-commands
      '(
        ("w" . "任务安排")
        ("wa" "重要且紧急的任务" tags-todo "+PRIORITY=\"A\"")
        ("wb" "重要且不紧急的任务" tags-todo "-Weekly-Monthly-Daily+PRIORITY=\"B\"")
        ("wc" "不重要且紧急的任务" tags-todo "+PRIORITY=\"C\"")
        ("b" "Blog" tags-todo "BLOG")
        ("p" . "项目安排")
        ("pw" tags-todo "PROJECT+WORK+CATEGORY=\"work\"")
        ("pl" tags-todo "PROJECT+DREAM+CATEGORY=\"zilongshanren\"")
        ("W" "Weekly Review"
         ((stuck "") ;; review stuck projects as designated by org-stuck-projects
          (tags-todo "PROJECT") ;; review all projects (assuming you use todo keywords to designate projects)
          ))))



;;(add-hook 'c-mode-common-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(with-eval-after-load 'evil
  (defalias #'forward-evil-word #'forward-evil-symbol))

;; key
;; {{ Use `SPC` as leader key
;; all keywords arguments are still supported
(nvmap :prefix "SPC"
  "ff" 'find-file
  "fs" 'save-buffer
  "bb" 'switch-to-buffer
  "cl" 'evilnc-comment-or-uncomment-lines
  "oa" 'org-agenda
  "oc" 'org-capture
  "oo" 'compile
  "<SPC>"  'counsel-M-x
  "w/" 'split-window-right
  "w-" 'split-window-below
  "wm" 'delete-other-windows

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
