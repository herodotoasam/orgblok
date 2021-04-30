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
    ;;elpy                            ;; Emacs Lisp Python Environment
    ;;flycheck                        ;; On the fly syntax checking
    ;;py-autopep8                     ;; Run autopep8 on save
    ;;blacken                         ;; Black formatting on save
    ;;magit                           ;; Git integration
    ;;enh-ruby-mode
    
    ;;web-mode
    powerline

     org
    org-bullets
    ido-vertical-mode
    flx-ido
    ;;autopair
    auto-complete
    ag
    material-theme                  ;; Theme
    evil
    emmet-mode
    
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

;;(elpy-enable)

;; Enable Flycheck

;;(when (require 'flycheck nil t)

;;  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))

;;  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; Enable autopep8

;;(require 'py-autopep8)

;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)



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

;;(add-hook 'tcl-mode-hook (lambda () (auto-complete-mode 1)))
;;(add-hook 'tcl-mode-hook (lambda () (linum-mode 1)))
;;(add-hook 'tcl-mode-hook (lambda () (hl-line-mode 1)))
;;(add-hook 'tcl-mode-hook (lambda () (show-paren-mode 1)))
;;(add-hook 'tcl-mode-hook 'autopair-mode)

;; (require 'js2-mode)
;; (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;; ;; Better imenu
;; (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)

;; (add-hook 'js2-mode-hook (lambda () (auto-complete-mode 1)))
;; (add-hook 'js2-mode-hook (lambda () (linum-mode 1)))
;; (add-hook 'js2-mode-hook (lambda () (hl-line-mode 1)))
;; (add-hook 'js2-mode-hook (lambda () (show-paren-mode 1)))
;; (add-hook 'js2-mode-hook 'autopair-mode)

(add-hook 'python-mode-hook (lambda () (linum-mode 1)))
(add-hook 'python-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'python-mode-hook (lambda () (hl-line-mode 1)))
(add-hook 'python-mode-hook (lambda () (show-paren-mode 1)))
(add-hook 'python-mode-hook 'autopair-mode)

(fset 'yes-or-no-p 'y-or-n-p)

;;(require 'web-mode)
;;(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;(defun my-web-mode-hook ()
;;  "Hooks for Web mode."
;;  (setq web-mode-markup-indent-offset 2)
;;)
;;(add-hook 'web-mode-hook  'my-web-mode-hook)
;;(add-hook 'web-mode-hook (lambda () (linum-mode 1)))
;;(add-hook 'web-mode-hook (lambda () (auto-complete-mode 1)))
;;(add-hook 'web-mode-hook (lambda () (hl-line-mode 1)))
;;(add-hook 'web-mode-hook (lambda () (show-paren-mode 1)))
;;(add-hook 'web-mode-hook (lambda () (emmet-mode 1)))
;;(add-hook 'web-mode-hook 'autopair-mode)


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

(require 'ag)
;;(require 'evil)
;;(evil-mode 1)



(require 'powerline)
(powerline-default-theme)
;;(require 'powerline-evil)
;; Enable Evil
(require 'evil)
(evil-mode 1)
;; Enable emmet
(require 'emmet-mode)


;; --------------------------------------------
;; ACA termina lo que yo he programado
;; --------------------------------------------
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Input Mono" :foundry "FBI " :slant normal :weight normal :height 143 :width normal)))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#242424" "#e5786d" "#95e454" "#cae682" "#8ac6f2" "#333366" "#ccaa8f" "#f6f3e8"])
 '(custom-enabled-themes (quote (material)))
 '(custom-safe-themes
   (quote
    ("d4f8fcc20d4b44bf5796196dbeabec42078c2ddb16dcb6ec145a1c610e0842f3" default)))
 '(fci-rule-color "#37474f")
 '(hl-sexp-background-color "#1c1f26")
 '(org-agenda-files (quote ("~/orgblok/*.org")))
 '(package-selected-packages
   (quote
    (emmet-mode evil material-theme ag auto-complete autopair flx-ido ido-vertical-mode org-bullets powerline better-defaults)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f36c60")
     (40 . "#ff9800")
     (60 . "#fff59d")
     (80 . "#8bc34a")
     (100 . "#81d4fa")
     (120 . "#4dd0e1")
     (140 . "#b39ddb")
     (160 . "#f36c60")
     (180 . "#ff9800")
     (200 . "#fff59d")
     (220 . "#8bc34a")
     (240 . "#81d4fa")
     (260 . "#4dd0e1")
     (280 . "#b39ddb")
     (300 . "#f36c60")
     (320 . "#ff9800")
     (340 . "#fff59d")
     (360 . "#8bc34a"))))
 '(vc-annotate-very-old-color nil))
