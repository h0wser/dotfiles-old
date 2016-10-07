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
	rainbow-mode
	latex-preview-pane
	auctex
))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'white-sand t)

;; Font
(add-to-list 'default-frame-alist '(font . "Hack-12"))

;; Custom dirs
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; TODO
;; custom pe/project-root-function
;; if subdir of ~/projects use highest dir under projects, else .git else default-dir

;; autocomplete
(ac-config-default)

;; evil
(require 'evil)
(evil-mode 1)

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

(require 'latex-mode)
(define-key LaTeX-mode-map (kbd "C-c +") 'TeX-next-error)

;; Stop littering everywhere with save file, put them somewhere
(setq backup-directory-alist '(("." . "~/emacs-backups")))

;; CC mode -- this is wierd
(require 'cc-mode)
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode t)
(add-to-list 'c-mode-common-hook
	     (lambda () (setq c-syntactic-indentation nil)))

;; Helm
(require 'helm)
(require 'helm-config)

(helm-mode 1)
(setq helm-mode-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-locate-fuzzy-match t
	helm-M-x-fuzzy-match t
	)

(global-set-key (kbd "M-x") 'helm-M-x)

;; Latex
(latex-preview-pane-enable t)
(setq TeX-PDF-mode t)
(setq TeX-auto-save t)
(setq-default TeX-master nil)
