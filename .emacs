;;Disable GUI
(tooltip-mode -1)
(scroll-bar-mode -1) 
(tool-bar-mode -1) 
(menu-bar-mode -1)
(setq redisplay-dont-pause t)
(setq inhibit-splash-screen t)
(setq use-dialog-box nil)

;;Disable backup
(setq make-backup-files        nil)
(setq auto-save-default        nil)
(setq auto-save-list-file-name nil)

;;Tabs
;;(setq-default tab-width 4)
;;(global-set-key (kdb "tab") 'indent-for-tab-command)
(setq-default ident-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-width 4)

;;Server
(require 'server)
(unless (server-running-p)
  (server-start))

;;Melpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;Imenu
(require 'imenu)
(setq imenu-auto-rescan t)
(setq imenu-use-popup-menu nil)
(global-set-key (kbd "<f6>") 'imenu)

;;Display name buffer
(setq frame-title-format "GNU Emacs: %b")

;;System-type definition
(defun system-in-linux()
  (string-equal system-type "gnu/linux"))

;;Unix path-variable
(when (system-in-linux)
  (setq unix-init-path "~/.emacs.d/lisp")
  (setq unix-init-ct-path "~/.emacs.d/lisp/plugins/color-theme"))

;;Load path for plugins
(if (system-in-linux)
    (add-to-list 'load-path unix-init-path))

;;Color-theme
;;(defun color-theme-init()
;;  (add-to-list 'load-path unix-init-ct-path)
;;  (require 'color-theme)
;;  (color-theme-initialize)
;;  (setq color-theme-is-global t))
;;  (color-theme-emacs-nw))
;;(if (system-in-linux)
;;    (when (file-directory-p unix-init-ct-path)
;;       (add-to-list 'load-path unix-init-ct-path)
;;       (color-theme-init)))

(add-to-list 'custom-theme-load-path "~/.emacs.d/elpa/")
(load-theme 'zenburn t)


;;Solarized
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/lisp/")
;;(require 'emacs-color-theme-solarized)
;;(load-theme 'solarized t)
;;(set-background-color "black")
;;(enable-theme 'solarized)
;;(set-terminal-parameter nil 'background-mode 'dark)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (let ((mode (if (display-graphic-p frame) 'light 'dark)))
              (set-frame-parameter frame 'background-mode mode)
              (set-terminal-parameter frame 'background-mode mode))
            (enable-theme 'solarized)))



;;Gitlab
(add-to-list 'load-path "~/.emacs.d/elpa/")
(require 'gitlab)

(setq gitlab-host "http://localhost"
	  gitlab-username "root"
	  gitlab-password "root1234")

;;Org-bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;;Minimap
;;(require 'sublimity)
;;(require 'sublimity-scroll)
;;(require 'sublimity-map)



;;Dired
(require 'dired)
(setq dired-reqursive-deletes 'top)

;;Org-mode
(require 'org-install)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cl" 'org-store-link)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-long-done t)

;;(global-set-key "\e\el" 'org-store-link)
(global-set-key "\e\ec" 'org-capture)
(global-set-key "\e\ea" 'org-agenda)
(global-set-key "\e\eb" 'org-iswitchb)
(setq org-agenda-files (quote ("~/.org/")))
(setq org-startup-indented t)

(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
;;(setq org-todo-keywords
;;	  (quote ((sequence "TODO(t!)" "NEXT(n!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
;;			  (sequence "QUOTE(Q!)" "QUOTED(D!)" "|" "APPROVED(A@)" "EXPIRED(E@)" "REJECTED(R@)")
;;			                (sequence "OPEN(O!)" "|" "CLOSED(C!)"))))


;;Startup screen
(setq inhibit-splash-screen t)
(setq ingibit-startup-message t)

;;Show-parrent-mode
(show-paren-mode t)
;;(setq show-paren-style 'expression)
(require 'paren)
;;(setq show-paren-style 'parenthesis)
;;(show-paren-mode t)
(set-face-background 'show-paren-match "#fff");;(face-background 'default))
(set-face-foreground 'show-paren-match "#000")
(set-face-attribute 'show-paren-match nil :weight 'extra-bold)


;;Electric-modes
;;(electric-pair-mode 1)
;;(electric-indent-mode -1)

;;Coding-system
(set-language-environment 'UTF-8)
(setq default-buffer-file-coding-system 'utf-8)
(setq-default coding-system-for-read 'utf-8)
(setq file-name-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;Linum plugin
(require 'linum)
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
(setq linum-format " %d")

;;Display file/time
(setq display-time-24hr-format t)
(display-time-mode t)
(size-indication-mode t)

;;Ido plugin
(require 'ido)
(ido-mode t)
(icomplete-mode t)
(ido-everywhere t)
(setq ido-virtual-buffers t)
(setq ido-enable-matching t)

;;Buffer selection
(require 'bs)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)
(global-set-key (kbd "<f2>") 'bs-show)

;;Syntax highlighting
(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximus-decoration t)

;;Scrolling
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservatively 10000)

;;Powerline
(require 'powerline)
(powerline-default-theme)
;;(setq powerline-color1 "grey21")
;;(setq foreground "grey12")
;;(setq powerline-color1 "#222")
;;(setq powerline-color2 "#444")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(mode-line ((t (:foreground "#7CFC00" :background "#006411" :box nil))))
 '(mode-line-inactive ((t (:foreground "#696969" :background "#666666" :box nil)))))

;;(require 'smart-mode-line)
;;(sml/setup)
;;(setq sml/show-time t)
;;(setq sml/mode-width 'full)
;;(setq sml/numbers-separator "")
;;(add-to-list 'sml/hidden-modes " Server")
;;(add-to-list 'sml/hidden-modes " yas")
;;(add-to-list 'sml/hidden-modes " Abbrev")
;;(add-to-list 'sml/hidden-modes " Undo-Tree")
;;(add-to-list 'sml/hidden-modes " Google")
;;(require 'smart-mode-line-powerline-theme)
;;(sml/apply-theme 'powerline)
;;(setq powerline-arrow-shape 'curve)
;;(setq powerline-default-separator-dir '(right . left))
;;(setq powerline-default-separator 'utf-8)

;;Emacs-powerline
;;(add-to-list 'load-path "~/.emacs.d/lisp/themes/emacs-powerline")
;;(require 'powerline)
;;(setq powerline-arrow-shape 'curve)

;;Web-mode
;;(require 'multi-web-mode)
;;(setq mweb-default-major-mode 'html-mode)
;;(setq mweb-tags '((php-mode "<\\?php\\|<\\?|\\?=" "\\?>")
;;		 (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;		 (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;;(setq mweb-filename-extensions '("php" "html" "htm" "css" "js"))
;;(multi-web-global-mode 1)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;;web-beauty
(require 'web-beautify) ;; Not necessary if using ELPA package
    (eval-after-load 'js2-mode
      '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
    (eval-after-load 'json-mode
      '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))
    (eval-after-load 'sgml-mode
      '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))
    (eval-after-load 'css-mode
      '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

    (eval-after-load 'js2-mode
      '(add-hook 'js2-mode-hook
                 (lambda ()
                   (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

    (eval-after-load 'json-mode
      '(add-hook 'json-mode-hook
                 (lambda ()
                   (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

    (eval-after-load 'sgml-mode
      '(add-hook 'html-mode-hook
                 (lambda ()
                   (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

    (eval-after-load 'css-mode
      '(add-hook 'css-mode-hook
                 (lambda ()
                   (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))

;;php-mode
(require 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
	("71ecffba18621354a1be303687f33b84788e13f40141580fa81e7840752d31bf" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" "ce371b56cf0952d838db6dafd92aaa6e3aadd74199c06ed7440da9df5595c4ae" "0c29db826418061b40564e3351194a3d4a125d182c6ee5178c237a7364f0ff12" "f0b0710b7e1260ead8f7808b3ee13c3bb38d45564e369cbe15fc6d312f0cd7a0" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(mediawiki-site-alist
   (quote
	(("Вікіпедія" "https://uk.wikipedia.org/w/" "Markjamba" "blaster13" nil "Main Page"))))
 '(package-selected-packages
   (quote
	(geben term+ lua-mode mediawiki dokuwiki-mode zenburn-theme yaml-mode web-mode web-beautify sublimity sublime-themes solarized-theme smart-mode-line-powerline-theme php-mode org-bullets org-beautify-theme nyan-mode neotree muttrc-mode multi-web-mode minimap helm-gitlab gotham-theme cyberpunk-theme ac-html))))

							
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
