(setq gc-cons-threshold 100000000)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))
;; will most likely need to adjust this font size for your system!
(defvar efs/default-font-size 140)
(defvar efs/default-variable-font-size 140)

(setq byte-compile-warnings '(cl-functions))

;Make frame transparency overridable	;h
(defvar efs/frame-transparency '(90 . 90))

;; Initialize package sources
(require 'package)


(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))


; list the packages you want
(setq package-list
    '(simpleclip  flx-ido powerline ag web-mode js2-mode projectile ))


(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)




(setq inhibit-startup-message t)

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room

(menu-bar-mode -1)            ; Disable the menu bar
(simpleclip-mode 1)           ; enable simpleclip globaly

;; Set up the visible bell
;;(setq visible-bell t)

(column-number-mode)
(global-display-line-numbers-mode t)
(smartparens-global-mode t)
(show-paren-mode 1)
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)


;; Set frame transparency
(set-frame-parameter (selected-frame) 'alpha efs/frame-transparency)
(add-to-list 'default-frame-alist `(alpha . ,efs/frame-transparency))
(set-frame-parameter (selected-frame) 'fullscreen 'maximized)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                shell-mode-hook
                treemacs-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(set-face-attribute 'default nil :font "Hack" :height efs/default-font-size)

;; Set the fixed pitch face
(set-face-attribute 'fixed-pitch nil :font "Hack" :height efs/default-font-size)

;; Set the variable pitch face
;;(set-face-attribute 'variable-pitch nil :font "Cantarell" :height efs/default-variable-font-size :weight 'regular)


;;Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
     
(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package doom-themes)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled
(load-theme 'doom-gruvbox t)


 ;; - doom-1337 -- ported from VSCode's 1337 theme (ported by @ccmywish)
 ;; - doom-acario-dark -- an original dark theme (ported by @gagbo)
 ;; - doom-acario-light -- an original light theme (ported by @gagbo)
 ;; - doom-ayu-dark -- inspired by Ayu Dark (ported by @ashton)
 ;; - doom-ayu-light -- inspirted by Ayu Light (ported by @LoveSponge)
 ;; - doom-ayu-mirage -- inspired by Ayu Mirage (ported by @LoveSponge)
 ;; - doom-badger -- inspired by cann's Badger colorscheme (ported by @jsoa)
 ;; - doom-challenger-deep -- inspired by Vim's Challenger Deep theme (ported by @fuxialexander)
 ;; - doom-city-lights -- inspired by Atom's City Lights theme (ported by @fuxialexander)
 ;; - doom-dark+ -- ported from equinusocio's VSCode Theme, dark+ (ported by @ema2159)
 ;; - doom-dracula -- inspired by the popular Dracula theme (ported by @fuxialexander)
 ;; - doom-earl-grey -- a gentle color scheme, for code (ported by @JuneKelly)
 ;; - doom-ephemeral -- inspired by the Ephemeral Theme from elenapan's dotfiles (ported by @karetsu)
 ;; - doom-fairy-floss -- a candy colored theme by sailorhg (ported by @ema2159)
 ;; - doom-flatwhite -- inspired by Atom's Flatwhite Syntax theme (ported by @JuneKelly)
 ;; - doom-gruvbox -- inspired by morhetz's Gruvbox (ported by @JongW)
 ;; - doom-gruvbox-light -- inspired by morhetz's Gruvbox (light) (ported by @jsoa)
 ;; - doom-henna -- based on VSCode's Henna theme (ported by @jsoa)
 ;; - doom-homage-black -- a minimalistic, colorless theme inspired by eziam, tao, and jbeans (ported by @mskorzhinskiy)
 ;; - doom-homage-white -- minimal white theme inspired by editors from 2000s (ported by @mskorzhinskiy)
 ;; - doom-horizon -- ported from VSCode Horizon (ported by @karetsu)
 ;; - doom-Iosvkem -- ported from the default dark theme for Adobe Brackets (ported by @neutaaaaan)
 ;; - doom-ir-black -- ported from Vim's ir_black colorscheme (ported by @legendre6891)
 ;; - doom-lantern -- based on Gitleptune's Lantern theme (ported by @paladhammika)
 ;; - doom-laserwave -- a clean synthwave/outrun theme inspired by VSCode's Laserwave (ported by @hyakt)
 ;; - doom-manegarm -- an original autumn-inspired dark theme (ported by @kenranunderscore)
 ;; - doom-material -- adapted from equinusocio's Material themes (ported by @tam5)
 ;; - doom-material-dark -- inspired by Material Theme by xrei (ported by @trev-dev)
 ;; - doom-meltbus -- a dark (mostly) monochromatic theme (ported by @spacefrogg)
 ;; - doom-miramare -- a port of Franbach's Miramare theme; a variant of Grubox (ported by @sagittaros)
 ;; - doom-molokai -- inspired by Tomas Restrepo's Molokai (ported by @hlissner)
 ;; - doom-monokai-classic -- port of Monokai Classic (ported by @ema2159)
 ;; - doom-monokai-machine -- port of Monokai Classic (ported by @minikN)
 ;; - doom-monokai-octagon -- port of Monokai Octagon (ported by @minikN)
 ;; - doom-monokai-pro -- Port of Monokai Pro (ported by @minikN)
 ;; - doom-monokai-ristretto -- Port of Monokai Ristretto (ported by @minikN)
 ;; - doom-monokai-spectrum -- port of Monokai Spectrum (ported by @minikN)
 ;; - doom-moonlight -- inspired by VS code's Moonlight (ported by @Brettm12345)
 ;; - doom-nord -- dark variant of Nord (ported by @fuxialexander)
 ;; - doom-nord-aurora -- a light variant of Nord (ported by @MoskitoHero)
 ;; - doom-nord-light -- light variant of Nord (ported by @fuxialexander)
 ;; - doom-nova -- inspired by Trevord Miller's Nova (ported by @bigardone)
 ;; - doom-oceanic-next -- inspired by Oceanic Next (ported by @juanwolf)
 ;; - doom-old-hope -- inspired by An Old Hope, in a galaxy far far away (ported by @teesloane)
 ;; - doom-one -- inspired by Atom One Dark (ported by @hlissner)
 ;; - doom-one-light -- inspired by Atom One Light (ported by @ztlevi)
 ;; - doom-opera -- an original light theme (ported by @jwintz)
 ;; - doom-opera-light -- an original light theme (ported by @jwintz)
 ;; - doom-outrun-electric -- a high contrast, neon theme inspired by Outrun Electric on VSCode (ported by @ema2159)
 ;; - doom-palenight -- adapted from equinusocio's Material themes (ported by @Brettm12345)
 ;; - doom-peacock -- inspired by daylerees' Peacock (ported by @teesloane)
 ;; - doom-plain -- inspired by gko's plain theme for VSCode (ported by @das-s)
 ;; - doom-plain-dark -- inspired by gko's plain theme for VSCode (ported by @das-s)
 ;; - doom-rouge -- ported from VSCode's Rouge Theme (ported by @das-s)
 ;; - doom-shades-of-purple -- a port of VSCode's Shades of Purple (ported by @jwbaldwin)
 ;; - doom-snazzy -- inspired by Hyper Snazzy (ported by @ar1a)
 ;; - doom-solarized-dark -- a dark variant of Solarized (ported by @ema2159)
 ;; - doom-solarized-dark-high-contrast -- a high-contrast variant of Solarized Dark (ported by @jmorag)
 ;; - doom-solarized-light -- a light variant of Solarized (ported by @fuxialexander)
 ;; - doom-sourcerer -- a port of xero's Sourcerer (ported by @fm0xb)
 ;; - doom-spacegrey -- I'm sure you've heard of it (ported by @teesloane)
 ;; - doom-tokyo-night -- inspired by VSCode's Tokyo Night theme (ported by @FosterHangdaan)
 ;; - doom-tomorrow-day -- a light variant of Tomorrow (ported by @emacswatcher)
 ;; - doom-tomorrow-night -- One of the dark variants of Tomorrow (ported by @hlissner)
 ;; - doom-vibrant -- a more vibrant variant of doom-one (ported by @hlissner)
 ;; - doom-wilmersdorf -- port of Ian Pan's Wilmersdorf (ported by @ema2159)
 ;; - doom-xcode -- based off of Apple's Xcode Dark Theme (ported by @kadenbarlow)
 ;; - doom-zenburn -- port of the popular Zenburn theme (ported by @jsoa)

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))




(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 1))

;; ido mo
(require 'flx-ido)
(setq ido-enable-flex-maching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-ignore-buffers '("\\` " "^\*" "\*.\*~"))
(ido-mode 1)



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


;; (defun efs/org-mode-visual-fill ()
;;   (setq visual-fill-column-width 100
;;         visual-fill-column-center-text t)
;;   (visual-fill-column-mode 1))

;; (use-package visual-fill-column
;;   :hook (org-mode . efs/org-mode-visual-fill))


;; Mis propios ajustes 
(global-set-key (kbd "C-<right>") 'next-buffer)
(global-set-key (kbd "C-<left>") 'previous-buffer)
(global-set-key (kbd "C-<up>") 'delete-other-windows)
(global-set-key [f12] (lambda() (interactive)(find-file "~/.emacs.d/init.el")))
(global-set-key [f8] 'web-mode-fold-or-unfold)

;; Mis propios ajustes de orgmode 
(defun org-insert-inactive-timestamp()
  "Inserta un timestamp inactive"
  (interactive)
  (org-insert-time-stamp nil nil t)
  )
(global-set-key (kbd "C-{") 'org-insert-inactive-timestamp)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;;(global-set-key (kbd "C-}") 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-auto-fill)


(require 'powerline)
(powerline-default-theme)
(powerline-center-evil-theme)

;;;python-elpy
;; (require 'elpy)
;; (elpy-enable)
;; (setq elpy-rpc-python-command "python3")

(require 'ag)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

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
;;(recentf-mode 1)
;;(setq recentf-max-menu-items 25)

(autoload 'tcl-mode "tcl" "Tcl mode." t)
(add-hook 'tcl-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (hl-line-mode 1)))
;; (autoload 'python-mode' "python" "Python" t)
;; (add-hook 'python-mode-hook' (lambda () (auto-complete-mode 1)))

(use-package evil-nerd-commenter
  :bind ("M-/" . evilnc-comment-or-uncomment-lines))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

;; NOTE: Make sure to configure a GitHub token before using this package!
;; - https://magit.vc/manual/forge/Token-Creation.html#Token-Creation
;; - https://magit.vc/manual/ghub/Getting-Started.html#Getting-Started
;;(use-package forge)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-hook 'web-mode-hook (lambda () (emmet-mode)))
(add-hook 'web-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'web-mode-hook (lambda () (hl-line-mode 1)))
(setq web-mode-enable-current-element-highlight 1)

(global-set-key [f3] 'neotree-toggle)
(global-set-key (kbd "}") 'web-mode-tag-match)

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-hook 'js2-mode-hook (lambda () (auto-complete-mode 1)))

;; Better imenu
(add-hook 'js2-mode-hook #'js2-imenu-extras-mode)


;; org-roam
;; (use-package org-roam
;;   :ensure t
;;   :init
;;   (setq org-roam-v2-ack t)
;;   :custom
;;   (org-roam-directory "~/orgblok/roam")
;;   (org-roam-completion-everywhere t)
;;   :bind (("C-c n l" . org-roam-buffer-toggle)
;; 	 ("C-c n f" . org-roam-node-find)
;; 	 ("C-c n i" . org-roam-node-insert)
;; 	 :map org-mode-map
;; 	 ("C-M-i" . completion-at-point)
;; 	 )
;;   )
(setq org-startup-folded t)
;; (use-package all-the-icons)

;; (use-package dashboard
;;   :init      ;; tweak dashboard config before loading it
;;   (setq dashboard-set-heading-icons t)
;;   (setq dashboard-set-file-icons t)
;;   (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
;;   ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
;;   (setq dashboard-startup-banner "~/.emacs.d/emacs-dash.png")  ;; use custom image as banner
;;   (setq dashboard-center-content nil) ;; set to 't' for centered content
;;   (setq dashboard-items '((recents . 5)
;;                           (agenda . 5 )
;;                           (bookmarks . 3)
;;                           (projects . 3)
;;                           (registers . 3)))
;;   :config
;;   (dashboard-setup-startup-hook)
;;   (dashboard-modify-heading-icons '((recents . "file-text")
;; 			      (bookmarks . "book"))))
;; make sp-select-next-thing works even the cusor is in the open/close tag
;; like matchit in vim
;; @return t => start from open tag; nil start from close tag

;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(evil-smartparens smartparens evil-commentary ripgrep pdf-tools all-the-icons  simpleclip ac-js2 web-mode js2-mode web-mode-edit-element all-the-icons-gnus all-the-icons-dired neotree mic-paren parent-mode vterm which-key visual-fill-column use-package python-mode py-autopep8 powerline org-bullets material-theme magit ivy-rich ido-vertical-mode general flycheck flx-ido evil-collection emmet-mode  doom-themes doom-modeline counsel company-box blacken better-defaults auto-complete ag))
 '(projectile-globally-ignored-file-suffixes '("#"))
 '(projectile-globally-ignored-files '("#*#" "TAGS"))
 '(projectile-mode t nil (projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
