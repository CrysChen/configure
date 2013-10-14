(require 'package)

;; Main line
(display-time-mode 1)
(setq major-mode 'conf-mode)
(display-battery-mode 1)

(setq frame-title-format
      '("" invocation-name " : " (:eval (if (buffer-file-name)
                                            (abbreviate-file-name (buffer-file-name))
                                          "%b"))))

(electric-indent-mode +1)
(global-hl-line-mode -1)

(setq savehist-additional-variables '(kill-ring compile-command search-ring regexp-search-ring))

(setq-default  tab-width 2
               standard-indent 2
               indent-tabs-mode nil)	; makes sure tabs are not used.

(global-set-key (kbd "C-j") 'reindent-newline-and-indent)

;; Theme & Font
(add-to-list 'custom-theme-load-path "~/.emacs.d/personal/themes")
(load-theme 'monokai t)
(set-default-font "Monaco-14")
(setq default-frame-alist '((font . "Monaco-14"))) ;; emacs --daemon

(require 'powerline)
(powerline-default-theme)

;; Trailing whitespace is unnecessary
(setq prelude-clean-whitespace-on-save nil)
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))
;; (add-hook 'before-save-hook (lambda () (prelude-indent-region-or-buffer)))

;; copy & paste
(global-set-key [mouse-2] 'mouse-yank-at-click)
(global-set-key [S-mouse-2] 'mouse-yank-at-click)

(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-primary t)  ; stops killing/yanking interacting with primary X11 selection
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)


(require 'multiple-cursors)
(require 'region-bindings-mode)
(region-bindings-mode-enable)

(define-key region-bindings-mode-map "a" 'mc/mark-all-like-this)
(define-key region-bindings-mode-map "p" 'mc/mark-previous-like-this)
(define-key region-bindings-mode-map "n" 'mc/mark-next-like-this)
(define-key region-bindings-mode-map "m" 'mc/mark-more-like-this-extended)

(global-set-key (kbd "C-x o") 'switch-window)

;; Wrap region
(require 'wrap-region)
(wrap-region-global-mode)

;; Sudo Save
(require 'sudo-save)

;;; IDO
(icomplete-mode t)
(ido-mode t)
(ido-everywhere 1)
(setq
 ido-enable-flex-matching t
 ido-enable-last-directory-history t
 ido-case-fold t
 ido-use-virtual-buffers t
 ido-file-extensions-order '(".org" ".txt" ".py" ".emacs" ".xml" ".el"
                             ".ini" ".cfg" ".conf" ".rb" ".rake" ".coffee" ".scss")
 ido-ignore-buffers '("\\` " "^\*Mess" "^\*Back" "^\*Buffer"
                      ".*Completion" "^\*Ido" "^\*trace" "^\*ediff" "^\*vc")
 )

;; Auto Generate Tags
(autoload 'turn-on-ctags-auto-update-mode "ctags-update" "turn on `ctags-auto-update-mode'." t)

;; Set limit line length
(setq whitespace-line-column 100)

;; Cua Mode
(cua-mode 'emacs)
(setq cua-enable-cua-keys nil)

;; Write good mode
;; (add-hook 'text-mode-hook 'writegood-mode)
;; (add-hook 'org-mode-hook 'writegood-mode)

;; SQL Mode
(add-hook 'sql-interactive-mode-hook (lambda ()
                                       (yas-minor-mode -1)))

;; Diminish
(require 'diminish)
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
(eval-after-load "auto-complete" '(diminish 'auto-complete-mode))
(eval-after-load "flycheck" '(diminish 'flycheck-mode))
(eval-after-load "flyspell" '(diminish 'flyspell-mode))

;; Guru
(setq prelude-guru nil)

;; Undo
(setq undo-tree-visualizer-timestamps t)
(setq undo-tree-history-directory-alist (quote (("." . "~/.cache/emacs"))))
(setq undo-tree-auto-save-history t)

;; Recentf
(setq recentf-exclude '(
                        "\.hist$"
                        "/COMMIT_EDITMSG$"
                        ))

;; Keyfreq
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;; Gnutls
(setq gnutls-min-prime-bits 2048)

;; Sauron
(setq
 sauron-dbus-cookie t
 sauron-separate-frame nil
 )

(add-hook 'sauron-event-added-functions
          (lambda (origin prio msg &optional props)
            (if (string-match "ping" msg)
                (sauron-fx-sox "/usr/share/sounds/freedesktop/stereo/bell.oga")
              (sauron-fx-sox "/usr/share/sounds/freedesktop/stereo/bell.oga"))
            (when (>= prio 4)
              (sauron-fx-sox "/usr/share/sounds/freedesktop/stereo/message-new-instant.oga")
              (sauron-fx-gnome-osd msg 10))))

(sauron-start-hidden)
(global-set-key (kbd "<C-f1>") 'sauron-toggle-hide-show)

;; iCal
(require 'calfw-ical)
(setq calcred (netrc-machine (netrc-parse "~/.authinfo.gpg") "calics" t))
;; (cfw:open-ical-calendar (netrc-get cred "password"))
(require 'calfw-gcal)

;; Doc View
(setq doc-view-continuous t)
(add-hook 'doc-view-mode-hook (lambda ()
                           (define-key doc-view-mode-map (kbd "j") 'doc-view-next-line-or-next-page)
                           (define-key doc-view-mode-map (kbd "k") 'doc-view-previous-line-or-previous-page)
                           (define-key doc-view-mode-map (kbd "h") 'image-backward-hscroll)
                           (define-key doc-view-mode-map (kbd "l") 'image-forward-hscroll)
                           ))
