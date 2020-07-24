;; .emacs.d/init.el


;; ===================================

;; MELPA Package Support

;; ===================================

;; Enables basic packaging support

(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(require 'package)


;; Adds the Melpa archive to the list of available repositories

(add-to-list 'package-archives
                '(("melpa" . "http://melpa.org/packages/")
                  ("melpa-stable" . "http://stable.melpa.org/packages/")
                  ("org-elpa" . "https://orgmode.org/elpa/")))

(package-initialize)
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")


;; If there are no archived package contents, refresh them

(when (not package-archive-contents)

  (package-refresh-contents))



;; Installs packages

;;

;; myPackages contains a list of package names

(defvar myPackages

  '(better-defaults                 ;; Set up some better Emacs defaults
    elpy                            ;; Emacs Lisp Python Environment
    flycheck                        ;; On the fly syntax checking
    py-autopep8                     ;; Run autopep8 on save
    blacken                         ;; Black formatting on save
    magit                           ;; Git integration
    enh-ruby-mode
    
    web-mode
    powerline

     org
    org-bullets
    ido-vertical-mode
    flx-ido
    autopair
    auto-complete
    ag
    material-theme                  ;; Theme
    
    )

  )


;; Scans the list in myPackages

;; If the package listed is not already installed, install it

(mapc #'(lambda (package)

          (unless (package-installed-p package)

            (package-install package)))

      myPackages)

;; ===================================

;; Basic Customization

;; ===================================


(setq inhibit-startup-message t)    ;; Hide the startup message

(load-theme 'material t)            ;; Load material theme

;;(global-linum-mode t)               ;; Enable line numbers globally

(elpy-enable)

;; Enable Flycheck

(when (require 'flycheck nil t)

  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8

(require 'py-autopep8)

(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; ruby
(add-hook 'enh-ruby-mode-hook 'robe-mode)
(add-hook 'enh-ruby-mode-hook 'yard-mode)
(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . enh-ruby-mode))


;; User-Defined init.el ends here

(global-set-key (kbd "C-<right>") 'next-buffer)
(global-set-key (kbd "C-<left>") 'previous-buffer)
(global-set-key (kbd "C-<up>") 'delete-other-windows)


(defun org-insert-inactive-timestamp()
  "Inserta un timestamp inactive"
  (interactive)
  (org-insert-time-stamp nil nil t)
  )
(global-set-key (kbd "C-{") 'org-insert-inactive-timestamp)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key (kbd "C-}") 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(defun nolinum ()
  (global-linum-mode 0)
)
(add-hook 'org-mode-hook 'nolinum)

(add-hook 'tcl-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (linum-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (hl-line-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (show-paren-mode 1)))
(add-hook 'tcl-mode-hook 'autopair-mode)

(add-hook 'python-mode-hook (lambda () (linum-mode 1)))

(fset 'yes-or-no-p 'y-or-n-p)

;; isearch at point
(defun xah-search-current-word ()
  "Call `isearch' on current word or text selection.
“word” here is A to Z, a to z, and hyphen 「-」 and underline 「_」, independent of syntax table.
URL `http://ergoemacs.org/emacs/modernization_isearch.html'
Version 2015-04-09"
  (interactive)
  (let ( $p1 $p2 )
    (if (use-region-p)
        (progn
          (setq $p1 (region-beginning))
          (setq $p2 (region-end)))
      (save-excursion
        (skip-chars-backward "-_A-Za-z0-9")
        (setq $p1 (point))
        (right-char)
        (skip-chars-forward "-_A-Za-z0-9")
        (setq $p2 (point))))
    (setq mark-active nil)
    (when (< $p1 (point))
      (goto-char $p1))
    (isearch-mode t)
    (isearch-yank-string (buffer-substring-no-properties $p1 $p2))))
(global-set-key (kbd "<f8>") 'xah-search-current-word)

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
(recentf-mode 1)
(setq recentf-max-menu-items 25)
;; ido mo
(require 'flx-ido)
(setq ido-enable-flex-maching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)
(setq ido-create-new-buffer 'always)
(setq ido-ignore-buffers '("\\` " "^\*" "\*.\*~"))
(ido-mode 1)

(require 'dired-x)
(require 'ag)


;; Configuracion de web-mode
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers
(add-hook 'js2-mode-hook 'autopair-mode)
(set-cursor-color "#aaaaaa")

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start 3)
(add-to-list 'ac-modes 'web-mode)
(setq ac-ignore-case t)
(setq ac-auto-start nil)
(global-set-key (kbd "C-<tab>") 'auto-complete)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html$\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-part-face t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'web-mode-hook 'autopair-mode)
(add-hook 'web-mode-hook 'auto-complete-mode)


(define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)


(require 'powerline)
(powerline-default-theme)


;; --------------------------------------------
;; Aca termina lo que yo he programado
;; --------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("d4f8fcc20d4b44bf5796196dbeabec42078c2ddb16dcb6ec145a1c610e0842f3" "afd761c9b0f52ac19764b99d7a4d871fc329f7392dfc6cd29710e8209c691477" default)))
 '(elpy-rpc-python-command "python3")
 '(org-agenda-files
   (quote
    ("~/orgblok/agenda.org" "~/orgblok/rb.org" "~/orgblok/pro.org" "~/orgblok/kubuntu.org" "~/orgblok/doc.org")))
 '(org-modules (quote (org-mouse)))
 '(org-mouse-features
   (quote
    (context-menu move-tree yank-link activate-stars activate-bullets activate-checkboxes)))
 '(package-selected-packages
   (quote
    (smartparens enh-ruby-mode org py-autopep8 org-bullets material-theme magit ido-vertical-mode flycheck elpy blacken better-defaults ag)))
 '(pyvenv-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono" :foundry "FBI " :slant normal :weight normal :height 143 :width normal)))))
