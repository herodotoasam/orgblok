(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes (quote (leuven)))
 '(custom-safe-themes
   (quote
    ("c72a772c104710300103307264c00a04210c00f6cc419a79b8af7890478f380e" default)))
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-echo-area-message "hero")
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/orgblok/topiramato.org" "~/orgblok/age-programacion.org" "/home/hero/orgblok/edu-orgmode.org" "/home/hero/orgblok/art-1.org" "/home/hero/orgblok/doc-fichaje.org" "~/orgblok/dia-programacion.org" "/home/hero/orgblok/age-pagos.org" "/home/hero/orgblok/age-tareas.org" "/home/hero/orgblok/age-turnos.org" "/home/hero/orgblok/dia-aprendizaje.org" "/home/hero/orgblok/dia-films.org" "/home/hero/orgblok/dia-general.org" "/home/hero/orgblok/dia-migrana.org" "/home/hero/orgblok/doc-deepin.org" "/home/hero/orgblok/edu-emacs.org" "/home/hero/orgblok/edu-i3.org" "/home/hero/orgblok/edu-vim.org" "/home/hero/orgblok/habitos.org" "/home/hero/orgblok/manualusuario.org" "/home/hero/orgblok/pro-dpto.org" "/home/hero/orgblok/proyectos.org" "/home/hero/orgblok/vim.org")))
 '(org-agenda-span (quote day))
 '(org-deadline-warning-days 0)
 '(org-habit-show-habits-only-for-today t)
 '(org-indent-indentation-per-level 2)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-mouse org-rmail org-w3m org-bullets)))
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (leuven-theme ## rings icicles ido-vertical-mode minimap org-pdfview org-bullets org-beautify-theme color-theme auto-complete ag)))
 '(python-shell-completion-native-enable nil)
 '(python-shell-interpreter "python3.5"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key (kbd "C-}") 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'python-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'python-mode-hook (lambda () (linum-mode 1)))
(add-hook 'python-mode-hook (lambda () (hl-line-mode 1)))


(defun org-insert-inactive-timestamp()
  "Inserta un timestamp inactive"
  (interactive)
  (org-insert-time-stamp nil nil t)
  )
(global-set-key (kbd "C-{") 'org-insert-inactive-timestamp)
(global-set-key (kbd "C-M-{") 'org-clock-in)
(global-set-key (kbd "C-M-}") 'org-clock-out)

(global-set-key (kbd "M-<f6>") (lambda() (interactive)(find-file "~/.emacs")))
(global-set-key (kbd "M-<f1>") (lambda() (interactive)(find-file "~/orgblok/index.org")))

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

(show-paren-mode 1)
(hl-line-mode 1)

(require 'ido-vertical-mode)
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-vertical-mode 1)
(setq ido-vertical-define-keys 'C-n-and-C-p-only)
(setq ido-vertical-show-count t)
(setq ido-use-faces t)
(set-face-attribute 'ido-vertical-first-match-face nil
                    :background nil
                    :foreground "orange")
(set-face-attribute 'ido-vertical-only-match-face nil
                    :background nil
                    :foreground nil)
(set-face-attribute 'ido-vertical-match-face nil
                    :foreground nil)



;; para cortar,copiar,yankear la entera linea
(defun my-kill-ring-save (beg end flash)
      (interactive (if (use-region-p)
                       (list (region-beginning) (region-end) nil)
                     (list (line-beginning-position)
                           (line-beginning-position 2) 'flash)))
      (kill-ring-save beg end)
      (when flash
        (save-excursion
          (if (equal (current-column) 0)
              (goto-char end)
            (goto-char beg))
          (sit-for blink-matching-delay))))
    (global-set-key [remap kill-ring-save] 'my-kill-ring-save)


;;iclicles
;;(setq load-path (cons "/usr/share/emacs/site-lisp/icicles" load-path))
;;(require 'icicles)
;;(icy-mode 1)
;;(eval-after-load "ring" '(progn (require 'ring+)))

;;(require 'helm-config)
;;(helm-mode 1)
(desktop-save-mode 1)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
