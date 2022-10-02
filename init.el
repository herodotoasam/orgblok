;; (spell-check-support-enabled nil) ;; Enable with t if you prefer

; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

(setq debug-on-error nil)

;; Allow access from emacsclient
(add-hook 'after-init-hook
          (lambda ()
            (require 'server)
            (unless (server-running-p)
              (server-start))))


;; will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 140)
(defvar efs/default-variable-font-size 140)

(setq byte-compile-warnings '(cl-functions))



(defun efs/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                     (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'efs/display-startup-time)


;; Initialize package sources
(require 'package)


(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))



(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(setq use-package-always-ensure t)


(use-package no-littering)

; no-littering doesn't set this by default so we must place
; auto save files in the same path as it uses for sessions
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))


(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
(use-package simpleclip)
(simpleclip-mode 1)           ; enable simpleclip globaly
(use-package ag)
(use-package ligature)
(use-package ace-window)

;; Set up the visible bell
;;(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)
;;(smartparens-global-mode t)
(show-paren-mode 1)
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)



;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(set-face-attribute 'default nil :font "Azeret Mono" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Fira Code" :height efs/default-font-size)

;; Set the variable pitch face
(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)


;;Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
     
(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package evil-leader
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (global-evil-leader-mode))
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "f" 'find-file
  "h" 'projectile-find-file
  "0" 'delete-other-windows
  "2" 'split-window-below
  "3" 'split-window-right
  "g" 'magit-status
  "d" 'dired
  "k" 'kill-buffer
  "s" 'save-buffer
  "b" 'switch-to-buffer
  "a" 'ag
  "r" 'rg-project
  "o" 'rg-dwim-current-file
  "p" 'pomidor-break
  "<f5>" #'(lambda() (interactive)(find-file "~/fl5/main.py"))
  "w" #'(lambda() (interactive)(find-file "~/orgblok/work.org"))
  "i" #'(lambda() (interactive)(find-file "~/orgblok/init.el"))
  "q" 'save-buffers-kill-terminal
  "," 'counsel-buffer-or-recentf
  "." 'counsel-find-file
  )

(use-package evil
   :init
   (setq evil-undo-system 'undo-redo)
   (setq evil-want-integration t)
   (setq evil-want-keybinding nil)
   (setq evil-want-C-u-scroll t)
   (setq evil-want-C-i-jump nil))
   :config
   (evil-mode 1)
   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)


;;   ;; Use visual line motions even outside of visual-line-mode buffers
   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
   (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

   (evil-set-initial-state 'messages-buffer-mode 'normal)
   (evil-set-initial-state 'dashboard-mode 'normal)

;;   ;; agregado por mi
   ;(setq evil-want-fine-undo 'fine)
   (define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
   (evil-global-set-key 'normal (kbd "3") 'evil-search-word-backward)
   (evil-global-set-key 'normal (kbd "4") 'evil-end-of-line)
   (evil-global-set-key 'normal (kbd "5") 'evil-jump-item)
   (evil-global-set-key 'normal (kbd "t") 'avy-goto-char-timer)
   (evil-global-set-key 'visual (kbd "t") 'avy-goto-char-timer)
   (evil-global-set-key 'normal (kbd "m") 'set-mark-command)
   (evil-global-set-key 'normal (kbd "K") 'kill-whole-line)
   (evil-global-set-key 'normal (kbd "L") 'duplicate-line)
   (evil-global-set-key 'normal (kbd "C-r") 'undo-redo)

 (use-package evil-collection
   :after evil
   :config
   (evil-collection-init))

(use-package command-log-mode
  :commands command-log-mode)

(use-package atom-dark-theme)
(use-package doom-themes
  ;; :init (load-theme 'doom-badger t))
  :init (load-theme 'atom-dark t))

 (use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package all-the-icons
  :ensure t)

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))


(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))


(use-package hydra
  :defer t)

(defhydra hydra-text-scale (:timeout 4)
  "scale text"
  ("j" text-scale-increase "in")
  ("k" text-scale-decrease "out")
  ("f" nil "finished" :exit t))

(efs/leader-keys
  "ts" '(hydra-text-scale/body :which-key "scale text"))


(defun eh-ivy-partial-or-done ()
  (interactive)
  (or (ivy-partial)
      (ivy-alt-done)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 ("C-r" . swiper-backward)
         :map ivy-minibuffer-map
         ("TAB" . eh-ivy-partial-or-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))


(defun efs/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.1)
                  (org-level-8 . 1.1)))
    (set-face-attribute (car face) nil :font "Cantarell" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil   :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch))


(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))



(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ido))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/fl5")
    (setq projectile-project-search-path '("~/fl5")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :after projectile
  :config (counsel-projectile-mode))

(use-package magit
  :commands magit-status
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))
(use-package forge
  :after magit
  )
(setq forge-add-default-bindings nil)
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))


(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-single-up-directory
    "l" 'dired-single-buffer))

(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(use-package dired-hide-dotfiles
  :hook (dired-mode . dired-hide-dotfiles-mode)
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "H" 'dired-hide-dotfiles-mode))

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))


;; Mis propios ajustes 
(global-set-key (kbd "M-<right>") 'next-buffer)
(global-set-key (kbd "M-<left>") 'previous-buffer)
(global-set-key (kbd "M-<up>") 'delete-other-windows)
(global-set-key [f6] 'projectile-ibuffer)
(global-set-key [f12] (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key [f10] (lambda() (interactive)(find-file "~/fl5/main.py")))

;; Mis propios ajustes de orgmode 
(defun org-insert-inactive-timestamp()
  "Inserta un timestamp inactive"
  (interactive)
  (org-insert-time-stamp nil nil t)
  )
(global-set-key (kbd "C-{") 'org-insert-inactive-timestamp)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'turn-on-auto-fill)




(require 'ag)

(fset 'yes-or-no-p 'y-or-n-p)


;; Duplicate line
(defun duplicate-line (arg)
  "Duplicate current line, leaving point in lower line."
  (interactive "*p")

  ;; save the point for undo
  (setq buffer-undo-list (cons (point) buffer-undo-list))

  ;; local variables for start and end of line
  (let ((bol (save-excursion (beginning-of-line) (point)))
        eol)
    (save-excursion

      ;; don't use forward-line for this, because you would have
      ;; to check whether you are at the end of the buffer
      (end-of-line)
      (setq eol (point))

      ;; store the line and disable the recording of undo information
      (let ((line (buffer-substring bol eol))
            (buffer-undo-list t)
            (count arg))
        ;; insert the line arg times
        (while (> count 0)
          (newline)         ;; because there is no newline in 'line'
          (insert line)
          (setq count (1- count)))
        )

      ;; create the undo information
      (setq buffer-undo-list (cons (cons eol (point)) buffer-undo-list)))
    ) ; end-of-let

  ;; put the point in the lowest line and return
  (next-line arg))

(global-set-key (kbd "C-S-d") 'duplicate-line)

(defun move-line (n)
  "Move the current line up or down by N lines."
  (interactive "p")
  (setq col (current-column))
  (beginning-of-line) (setq start (point))
  (end-of-line) (forward-char) (setq end (point))
  (let ((line-text (delete-and-extract-region start end)))
    (forward-line n)
    (insert line-text)
    ;; restore point to original column in moved line
    (forward-line -1)
    (forward-char col)))

(defun move-line-up (n)
  "Move the current line up by N lines."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
  "Move the current line down by N lines."
  (interactive "p")
  (move-line (if (null n) 1 n)))

(global-set-key (kbd "M-<up>") 'move-line-up)
(global-set-key (kbd "M-<down>") 'move-line-down)

(desktop-save-mode 1)


(use-package company
  :bind (:map company-active-map
         ("<tab>" . company-indent-or-complete-common))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))
(setq company-idle-delay
      (lambda () (if (company-in-string-or-comment) nil 0.3)))
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-align-annotations t)
(setq company-tooltip-limit 4)
(setq company-tooltip-offset-display 'lines)
(setq company-tooltip-minimum 4)
(setq company-tooltip-flip-when-above t)
(setq company-tooltip-margin 3)
(setq company-selection-wrap-around t)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip ((t (:background "gray14" :foreground "white"))))
 '(company-tooltip-annotation ((t (:foreground "white"))))
 '(company-tooltip-common ((t (:weight bold :foreground "white"))))
 '(company-tooltip-scrollbar-thumb ((t (:background "gray0"))))
 '(company-tooltip-scrollbar-track ((t (:background "gray0"))))
 '(company-tooltip-selection ((t (:background "gray20" :foreground "white")))))
(setq company-text-face-extra-attributes
      '(:weight bold :slant italic)) 
(setq company-text-icons-add-background t)

(use-package company-box
  :hook (company-mode . company-box-mode))


(setq company-idle-delay 0
      company-tooltip-idle-delay 10
      company-require-match nil
      company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend-with-delay
        company-preview-frontend
        company-echo-metadata-frontend)
      company-backends '(company-capf))

(global-set-key (kbd "<tab>")
                (lambda ()
                  (interactive)
                  (let ((company-tooltip-idle-delay 0.0))
                    (company-complete)
                    (and company-candidates
                         (company-call-frontends 'post-command)))))
(setq company-tooltip-align-annotations t)

(add-to-list 'company-backends 'company-capf)
(add-to-list 'company-backends '(company-files company-dabbrev))
(add-to-list 'company-backends 'company-css)
(add-to-list 'company-backends '(company-keywords company-dabbrev))
(add-to-list 'company-backends '(company-jedi company-dabbrev))
(add-to-list 'company-backends '(company-semantic company-dabbrev))
(add-to-list 'company-backends '(company-web-html company-dabbrev))

(setq company-dabbrev-other-buffers #'all)
(setq company-dadbrev-ignore-buffers #'*.org) 


(add-hook 'elisp-mode-hook
  (lambda ()
    (setq company-backends '(company-capf :with company-files))))




(use-package eglot)
 (require 'eglot)

(use-package emmet-mode)
(require 'emmet-mode)
(use-package web-mode)
 (require 'web-mode)
 (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
 (add-hook 'web-mode-hook (lambda () (emmet-mode)))
 (add-hook 'web-mode-hook (lambda () (hl-line-mode 1)))
  (evil-collection-define-key 'normal 'web-mode-map
    "z" 'web-mode-fold-or-unfold
    "q" 'web-mode-navigate)
(setq web-mode-enable-current-element-highlight 1)
(setq web-mode-enable-auto-indentation 1)
(setq web-mode-enable-auto-closing 1)
(setq web-mode-enable-auto-opening 1)
(setq web-mode-enable-current-column-highlight 1)
(setq web-mode-enable-element-tag-fontification 1)
(setq web-mode-engines-alist
      '(("jinja2"    . "\\.html\\'"))
)
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-style-padding 1)
(setq web-mode-script-padding 1)
(setq web-mode-block-padding 0)
(setq web-mode-comment-style 2)
(setq web-mode-enable-css-colorization t) 
;; (add-hook 'web-mode-hook (lambda ()
;;                           (set (make-local-variable 'company-backends) '(company-web-html))
;;                           (company-mode t)))

(add-hook 'css-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends) '(company-web-html))))

(use-package js2-mode)
(require 'js2-mode)
(use-package company-flow)
(require 'company-flow)
;; (eval-after-load 'company
;;   (add-to-list 'company-backends 'company-flow))
(add-hook 'js2
  (lambda ()
    (setq company-backends '(company-flow))))

;; defun flow/set-flow-executable ()
;;   (interactive)
;;   (let* ((os (pcase system-type
;;                ('darwin "osx")
;;                ('gnu/linux "linux64")
;;                (_ nil)))
;;          (root (locate-dominating-file  buffer-file-name  "node_modules/flow-bin"))
;;          (executable (car (file-expand-wildcards
;;                            (concat root "node_modules/flow-bin/*" os "*/flow")))))
;;     (setq-local company-flow-executable executable)
;;     ;; These are not necessary for this package, but a good idea if you use
;;     ;; these other packages
;;     (setq-local flow-minor-default-binary executable)
;;     (setq-local flycheck-javascript-flow-executable executable))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-hook 'js2-mode-hook #'flow/set-flow-executable t)
;; (add-hook 'js2-mode-hook (lambda () (auto-complete-mode 1)))


(use-package python-mode)
(require 'python-mode)
(autoload 'python-mode "python-mode" "Python Mode." t)
 (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
 (add-to-list 'interpreter-mode-alist '("python3" . python-mode))
(add-hook 'python-mode-hook (lambda() (hs-minor-mode)))
(add-hook 'python-mode
  (lambda ()
    (set (make-local-variable 'company-backends) '(company-jedi))))

(setq org-startup-folded t)
(ligature-set-ligatures 't '("www"))

;; Enable ligatures in programming modes                                                           
(ligature-set-ligatures 'prog-mode '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\" "{-" "::"
                                     ":::" ":=" "!!" "!=" "!==" "-}" "----" "-->" "->" "->>"
                                     "-<" "-<<" "-~" "#{" "#[" "##" "###" "####" "#(" "#?" "#_"
                                     "#_(" ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*" "/**"
                                     "/=" "/==" "/>" "//" "///" "&&" "||" "||=" "|=" "|>" "^=" "$>"
                                     "++" "+++" "+>" "=:=" "==" "===" "==>" "=>" "=>>" "<="
                                     "=<<" "=/=" ">-" ">=" ">=>" ">>" ">>-" ">>=" ">>>" "<*"
                                     "<*>" "<|" "<|>" "<$" "<$>" "<!--" "<-" "<--" "<->" "<+"
                                     "<+>" "<=" "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<"
                                     "<~" "<~~" "</" "</>" "~@" "~-" "~>" "~~" "~~>" "%%"))

(global-ligature-mode 't)

(setq-default abbrev-mode t)
(setq save-abbrevs 'silent)


;;; ace-window
(global-set-key (kbd "M-o") 'ace-window)

;; popper
(require 'popper)
(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode +1)
  (popper-echo-mode +1))         
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; end

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(popper company-web-html which-key web-mode use-package skewer-mode simpleclip rg rainbow-delimiters popup org-bullets no-littering ligature ivy-rich ivy-prescient hydra general forge evil-nerd-commenter evil-leader evil-collection emmet-mode eglot doom-themes doom-modeline dired-single dired-open dired-hide-dotfiles counsel-projectile company-web company-jedi company-flow company-box command-log-mode atom-dark-theme all-the-icons-dired ag ace-window)))
