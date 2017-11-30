(require 'cl)
(require 'package)

(add-to-list 'package-archives
	     '("mepla" . "http://melpa.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add packages to be installed here
(defvar my-packages
	'(evil
	company
	auto-complete
	project-explorer
	async
	helm
	white-sand-theme
	moe-theme
	rainbow-mode
	latex-preview-pane
	auctex
	projectile
	helm-projectile
	magit
	evil-magit
	haskell-mode
	git-gutter+
	git-gutter-fringe+
	ample-theme
	haskell-mode
	rust-mode
))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Themes
(load-theme 'ample t t)
(enable-theme 'ample)

;; Font
(add-to-list 'default-frame-alist '(font . "-*-profont-medium-*-*-*-15-*-*-*-*-*-*-*"))

;; Custom dirs
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(add-to-list 'load-path "~/.emacs.d/lisp")

;; TODO
;; custom pe/project-root-function
;; if subdir of ~/projects use highest dir under projects, else .git else default-dir

;; autocomplete
(ac-config-default)

;; evil
(require 'evil)
(evil-mode 1)

;; Magit
(require 'magit)
(magit-file-mode)

(require 'evil-magit)

;; Git gutter
(global-git-gutter+-mode)
;(git-gutter:linum-setup)

(require 'git-gutter-fringe+)

;; Remove crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(menu-bar-mode -1)
(global-linum-mode 1)
(column-number-mode 1)
(show-paren-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Cursor color
(setq evil-emacs-state-cursor '("peru" box))
(setq evil-normal-state-cursor '("peru" box))
(setq evil-insert-state-cursor '("coral" bar))
(setq evil-visual-state-cursor '("powder blue" box))
(setq evil-replace-state-cursor '("red" bar))

;; Key bindings
(define-key evil-insert-state-map "ö" (kbd "{"))
(define-key evil-insert-state-map "ä" (kbd "}"))
(define-key evil-insert-state-map "Ö" (kbd "["))
(define-key evil-insert-state-map "Ä" (kbd "]"))
(define-key evil-normal-state-map "J" (lambda () (interactive) (forward-line 5)))
(define-key evil-normal-state-map "K" (lambda () (interactive) (forward-line -5)))
(global-set-key (kbd "M-b") 'mode-line-other-buffer)

;; Stop littering everywhere with save file, put them somewhere
(setq backup-directory-alist '(("." . "~/emacs-backups")))

;; CC mode -- this is wierd
(require 'cc-mode)
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)
(add-to-list 'c-mode-common-hook
	     (lambda () (setq c-syntactic-indentation nil)))

;; Enable java mode in .java files
(add-to-list 'auto-mode-alist '("\\.java\\'" . java-mode))

;; Helm
(require 'helm)
(require 'helm-config)

(helm-mode 1)
(setq helm-mode-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-M-x-fuzzy-match t
	)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)

;; Latex
;(latex-preview-pane-enable t)
;(setq TeX-PDF-mode t)
(setq latex-run-command "pdflatex")
;(setq TeX-auto-save t)
;(setq-default TeX-master nil)
;(setq-default TeX-save-query nil)

;; Org
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/projects/orgfiles/"
			     "~/projects/orgfiles/courses"
			     "~/projects/orgfiles/projects"))

(projectile-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-command "latex")
 '(package-selected-packages
   (quote
	(mips-mode rust-mode white-sand-theme relative-line-numbers rainbow-mode project-explorer moe-theme latex-preview-pane jdee helm-projectile haskell-mode git-gutter-fringe+ exwm evil-magit ess company avk-emacs-themes auto-complete auctex ample-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
