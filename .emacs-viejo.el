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
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(canlock-password "f76b6d512dd29cedcc83666eb5a5733c5e67a2be")
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes (quote (tsdh-light)))
 '(custom-safe-themes
   (quote
    ("d66e8428842d4b1e38e79f51b153d3e747220fdd9018acf38227a5d9e13b84c4" "11e57648ab04915568e558b77541d0e94e69d09c9c54c06075938b6abc0189d8" "d1ede12c09296a84d007ef121cd72061c2c6722fcb02cb50a77d9eae4138a3ff" "86e2d09ebcfff3b7ec95543bce5a163384579a2bf2e2a81bfba8908b7a0c44df" "a4c9e536d86666d4494ef7f43c84807162d9bd29b0dfd39bdf2c3d845dcc7b2e" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" "c72a772c104710300103307264c00a04210c00f6cc419a79b8af7890478f380e" default)))
 '(fci-rule-color "#2e2e2e")
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(hl-bg-colors
   (quote
    ("#DEB542" "#F2804F" "#FF6E64" "#F771AC" "#9EA0E5" "#69B7F0" "#69CABF" "#B4C342")))
 '(hl-fg-colors
   (quote
    ("#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3" "#fdf6e3")))
 '(hl-sexp-background-color "#efebe9")
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-echo-area-message "hero")
 '(inhibit-startup-screen t)
 '(magit-diff-use-overlays nil)
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4")))
 '(org-agenda-files
   (quote
    ("/media/veracrypt1/orgblok/oficina.org" "/media/veracrypt1/orgblok/teoria.org" "/media/veracrypt1/orgblok/jornal.org")))
 '(org-agenda-span (quote day))
 '(org-blank-before-new-entry nil)
 '(org-deadline-warning-days 0)
 '(org-habit-following-days 5)
 '(org-habit-graph-column 50)
 '(org-habit-preceding-days 21)
 '(org-habit-show-habits-only-for-today t)
 '(org-indent-indentation-per-level 2)
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-gnus org-habit org-info org-irc org-mhe org-mouse org-rmail org-w3m org-bullets)))
 '(org-sparse-tree-open-archived-trees t)
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (slime w3m nimbus-theme monokai-alt-theme zerodark-theme popup-kill-ring atom-one-dark-theme pomidor org-journal projectile molokai-theme solarized-theme smartparens leuven-theme ## rings icicles minimap org-pdfview org-bullets org-beautify-theme color-theme auto-complete ag)))
 '(pos-tip-background-color "#eee8d5")
 '(pos-tip-foreground-color "#586e75")
 '(python-shell-completion-native-enable nil)
 '(python-shell-interpreter "python3.5")
 '(pyvenv-workon nil)
 '(send-mail-function (quote smtpmail-send-it))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(vc-annotate-background "#3b3b3b")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dd5542")
     (40 . "#CC5542")
     (60 . "#fb8512")
     (80 . "#baba36")
     (100 . "#bdbc61")
     (120 . "#7d7c61")
     (140 . "#6abd50")
     (160 . "#6aaf50")
     (180 . "#6aa350")
     (200 . "#6a9550")
     (220 . "#6a8550")
     (240 . "#6a7550")
     (260 . "#9b55c3")
     (280 . "#6CA0A3")
     (300 . "#528fd1")
     (320 . "#5180b3")
     (340 . "#6380b3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(virtualenv-root "~hero/pyrx1/")
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(xterm-color-names
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#073642"])
 '(xterm-color-names-bright
   ["#fdf6e3" "#cb4b16" "#93a1a1" "#839496" "#657b83" "#6c71c4" "#586e75" "#002b36"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-todo ((t (:foreground "red" :weight bold)))))
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(global-set-key (kbd "C-}") 'org-agenda)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'tcl-mode-hook (lambda () (auto-complete-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (linum-mode 1)))
(add-hook 'tcl-mode-hook (lambda () (hl-line-mode 1)))
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
(global-set-key (kbd "M-1") (lambda() (interactive)(neotree-toggle)))

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



(desktop-save-mode 1)
(recentf-mode 1)
(setq recentf-max-menu-items 25)




;;company mode enable para todos
;;(add-hook 'after-init-hook 'global-company-mode)
;;(setq ag-reuse-buffers 't)



;;smartparents
(smartparens-global-mode 1)

;; ver column number
(setq column-number-mode t)


(setq org-todo-keywords
      (quote ((sequence "TODO(t)"  "DONE(d!)"))))

(setq pomidor-sound-tick nil
      pomidor-sound-tack nil
      )

;;;
;; Move to beginning of word before yanking word in isearch-mode.
;; Make C-s C-w and C-r C-w act like Vim's g* and g#, keeping Emacs'
;; C-s C-w [C-w] [C-w]... behaviour.

(require 'thingatpt)
;;(require 'helm-config)

(defun my-isearch-yank-word-or-char-from-beginning ()
  "Move to beginning of word before yanking word in isearch-mode."
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string))
      (beginning-of-thing 'word))
  (isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning 
			     'isearch-yank-word-or-char
			     isearch-mode-map))

(add-hook 'isearch-mode-hook
 (lambda ()
   "Activate my customized Isearch word yank command."
   (substitute-key-definition 'isearch-yank-word-or-char 
			      'my-isearch-yank-word-or-char-from-beginning
			      isearch-mode-map)))


(global-set-key (kbd "<f5>") 'point-to-register)
(global-set-key (kbd "<f6>") 'jump-to-register)
(global-set-key (kbd "C-<right>") 'next-buffer)
(global-set-key (kbd "C-<left>") 'previous-buffer)
(global-set-key (kbd "C-<up>") 'delete-other-windows)

(fset 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-<f12>") 'mu4e)



;; I have my "default" parameters from Gmail
(setq mu4e-sent-folder "/home/hero/Maildir/sent"
      ;; mu4e-sent-messages-behavior 'delete ;; Unsure how this should be configured
      mu4e-drafts-folder "/home/hero/Maildir/drafts"
      user-mail-address "romitexcba@gmail.com"
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587)

;;(global-set-key (kbd "M-x") #'helm-M-x)
;;(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
;;(global-set-key (kbd "C-x C-f") #'helm-find-files)


;;(helm-mode 1)

(global-set-key (kbd "C-0") 'org-capture)


(setq org-capture-templates
 '(("t" "Todo" entry (file "/media/hero/bora/orgblok/tareas.org")
        "* TODO %?%^g\n%U\n%i\n")
   ("j" "Journal" entry (file+olp+datetree "/media/hero/bora/orgblok/jornal.org")
    "* %?%^g \n %i \n" :clock-in t :clock-resume t)
   ("b" "Bugs" entry (file "/media/hero/bora/orgblok/bugs.org")
    "* TODO %?%^g\n%U\n%i\n%a\n ")
   ("m" "Manual" entry (file+headline "/media/hero/bora/orgblok/teoria.org" "Refile")
    "* %?%^g\n%U\n%i\n%a\n ")
   ("d" "devoluciones" entry (file+headline "/media/hero/bora/orgblok/devoluciones.org")
    "* %^{Cuenta} %^{fecha}p %^{prom}p %^{zona}p %^{dni}p %^{direccion}p %^{articulo}p %^{estado}p %^{cobrador}p %^{multa}p %^{totalparcial}p %^{excusa}p \n")
   ("h" "Habit" entry (file "/media/hero/bora/orgblok/habitos.org")
    "* TODO %?\n%U\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:END:\n"))
 )



(global-set-key (kbd "C-9") 'w3m)

(setq browse-url-browser-function 'w3m-browse-url) 
      (global-set-key "\C-xm" 'browse-url-at-point)      


(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt"))) 
;;  set to nil to use symmetric encryption.
;;(setq org-crypt-key nil)
(setq org-crypt-key "hfj024@gmail.com")
(global-set-key (kbd "C-8") 'org-decrypt-entries)
(setq org-crypt-disable-auto-save nil)


