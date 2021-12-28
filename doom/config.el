;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Wzhe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; set windows size
;; (pushnew! initial-frame-alist '(width . 200) '(height . 55))
(add-hook 'window-setup-hook #'toggle-frame-maximized)
;; (add-hook 'window-setup-hook #'toggle-frame-fullscreen)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; (after! evil (setq  evil-default-cursor '("red" box)
;;                     evil-normal-state-cursor '("red" box)
;;                     evil-insert-state-cursor '("red" (bar . 2))
;;                     evil-visual-state-cursor '("red" hollow)
;;                     evil-replace-state-cursor '("red" hollow)
;;                     evil-emacs-state-cursor '("red" hbar))
;;   )

(use-package! go-translate
  :init
  ;; 配置多个翻译语言对
  (setq gts-translate-list '(("en" "zh")))

  ;; 配置默认的 translator
  ;; 这些配置将被 gts-do-translate 命令使用
  ;; (setq gts-default-translator
  ;;       (gts-translator

  ;;        :picker ; 用于拾取初始文本、from、to，只能配置一个

  ;;        ;;(gts-noprompt-picker)
  ;;        ;;(gts-noprompt-picker :texter (gts-whole-buffer-texter))
  ;;        (gts-prompt-picker)
  ;;        ;;(gts-prompt-picker :single t)
  ;;        ;;(gts-prompt-picker :texter (gts-current-or-selection-texter) :single t)

  ;;        :engines ; 翻译引擎，可以配置多个。另外可以传入不同的 Parser 从而使用不同样式的输出

  ;;        (list
  ;;         (gts-bing-cn-engine)
  ;;         ;;(gts-google-engine)
  ;;         ;;(gts-google-rpc-engine)
  ;;         ;;(gts-deepl-engine :auth-key [YOUR_AUTH_KEY] :pro nil)
  ;;         (gts-google-engine :parser (gts-google-summary-parser))
  ;;         ;;(gts-google-engine :parser (gts-google-parser))
  ;;         ;;(gts-google-rpc-engine :parser (gts-google-rpc-summary-parser))
  ;;         (gts-google-rpc-engine :parser (gts-google-rpc-parser))
  ;;         )

  ;;        :render ; 渲染器，只能一个，用于输出结果到指定目标。如果使用 childframe 版本的，需自行安装 posframe

  ;;        (gts-buffer-render)
  ;;        ;;(gts-posframe-pop-render)
  ;;        ;;(gts-posframe-pop-render :backcolor "#333333" :forecolor "#ffffff")
  ;;        ;;(gts-posframe-pin-render)
  ;;        ;;(gts-posframe-pin-render :position (cons 1200 20))
  ;;        ;;(gts-posframe-pin-render :width 80 :height 25 :position (cons 1000 20) :forecolor "#ffffff" :backcolor "#111111")
  ;;        ;;(gts-kill-ring-render)
  ;;        ))

  )

(use-package! citre
  :init
  ;; This is needed in `:init' block for lazy load to work.
  (require 'citre-config)
  ;; Bind your frequently used commands.  Alternatively, you can define them
  ;; in `citre-mode-map' so you can only use them when `citre-mode' is enabled.
  (global-set-key (kbd "C-x c j") 'citre-jump)
  (global-set-key (kbd "C-x c k") 'citre-jump-back)
  (global-set-key (kbd "C-x c p") 'citre-ace-peek)
  (global-set-key (kbd "C-x c f") 'citre-peek-chain-forward)
  (global-set-key (kbd "C-x c b") 'citre-peek-chain-backward)
  (global-set-key (kbd "C-x c u") 'citre-update-this-tags-file)
  :config
  (setq
   ;; Set these if readtags/ctags is not in your path.
   ;; citre-readtags-program "/path/to/readtags"
   ;; citre-ctags-program "/path/to/ctags"
   ;; Set this if you use project management plugin like projectile.  It's
   ;; used for things like displaying paths relatively, see its docstring.
   citre-project-root-function #'projectile-project-root
   ;; Set this if you want to always use one location to create a tags file.
   citre-default-create-tags-file-location 'global-cache
   ;; See the "Create tags file" section above to know these options
   citre-use-project-root-when-creating-tags t
   citre-prompt-language-for-ctags-command t
   ;; By default, when you open any file, and a tags file can be found for it,
   ;; `citre-mode' is automatically enabled.  If you only want this to work for
   ;; certain modes (like `prog-mode'), set it like this.
   citre-auto-enable-citre-mode-modes '(prog-mode)))
;; key
;; {{ Use `SPC` as leader key
;; all keywords arguments are still supported
(map! :leader
      :desc "Find file in project"  ":"  #'projectile-find-file
      :desc "M-x"                   "SPC"    #'execute-extended-command

      "cc" #'evilnc-comment-operator
      "cl" #'evilnc-comment-or-uncomment-lines
      "cp" #'evilnc-comment-or-uncomment-paragraphs

      "0" #'winum-select-window-0-or-10
      "1" #'winum-select-window-1
      "2" #'winum-select-window-2
      "3" #'winum-select-window-3
      "4" #'winum-select-window-4
      "5" #'winum-select-window-5
      "6" #'winum-select-window-6
      "7" #'winum-select-window-7
      "8" #'winum-select-window-8
      "9" #'winum-select-window-9
      )
