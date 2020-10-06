;; load built-in package manager
(require 'package)

(add-to-list 'package-archives
	     '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(setq package-enable-at-startup nil)
(package-initialize)

;; install use-packages
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; load packages
(use-package markdown-mode
  :ensure t)
(use-package magit
  :ensure t)
(use-package atomic-chrome
  :ensure t)
(use-package xcscope
  :ensure t)
(use-package helm
  :ensure t)
(use-package helm-cscope
  :ensure t)
(use-package monokai-theme
  :ensure t)
;(use-package leuven-theme
;  :ensure t)

;; basic setup
(load-theme 'monokai t)       ; black
; (load-theme 'leuven t)      ; white
(tool-bar-mode -1)            ; no tool bar
(menu-bar-mode -1)            ; no menu bar
(toggle-scroll-bar -1)        ; no scroll bar
(set-window-fringes nil 0 0)  ; no window fringe
(column-number-mode 1)
(show-paren-mode 1)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(setq-default show-trailing-whitespace t)
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)

;; atomic chrome for emacs
; https://github.com/alpha22jp/atomic-chrome
(atomic-chrome-start-server)
(setq atomic-chrome-default-major-mode 'markdown-mode)
(setq atomic-chrome-buffer-open-style 'frame)

;; magit
; M-x magit-status (or C-x g) to see git status, and in the status buffer:
; s to stage files
; c c to commit (type the message then C-c C-c to actually commit)
; b b to switch to another branch
; P u to do a git push
; F u to do a git pull
; try to press TAB
(global-set-key (kbd "C-x g") 'magit-status)

;; source code
(require 'xcscope)
(setq cscope-do-not-update-database t)
;set default style to linux
; use M-x c-guess and c-guess-install
(setq c-default-style "linux")

;;; TODO need to be smart
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.tpp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.txx\\'" . c++-mode))


;; LLVM coding style guidelines in emacs
;; Maintainer: LLVM Team, http://llvm.org/

;; Add a cc-mode style for editing LLVM C and C++ code
(c-add-style "llvm.org"
             '("gnu"
	       (fill-column . 80)
	       (c++-indent-level . 2)
	       (c-basic-offset . 2)
	       (indent-tabs-mode . nil)
	       (c-offsets-alist . ((arglist-intro . ++)
				   (innamespace . 0)
				   (member-init-intro . ++)))))

;; Files with "llvm" in their names will automatically be set to the
;; llvm.org coding style.
(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil 
	     (if (string-match "llvm" buffer-file-name)
		 (progn
		   (c-set-style "llvm.org"))))))

(add-hook 'c-mode-common-hook
	  (function
	   (lambda nil 
	     (if (string-match "witcher" buffer-file-name)
		 (progn
		   (c-set-style "llvm.org"))))))

;; string rectangle
; C-x rt

;; helm mode
; http://tuhdo.github.io/helm-intro.html
; http://wikemacs.org/wiki/Helm
; https://emacs-helm.github.io/helm/
(require 'helm)
(require 'helm-config)
(require 'helm-cscope)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun spacemacs//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t
      helm-semantic-fuzzy-match   t
      helm-imenu-fuzzy-match      t
      helm-locate-fuzzy-match     t
      helm-apropos-fuzzy-match    t
      helm-lisp-fuzzy-completion  t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h g") 'helm-google-suggest)

;; Enable helm-cscope-mode
(add-hook 'c-mode-hook 'helm-cscope-mode)
(add-hook 'c++-mode-hook 'helm-cscope-mode)
(add-hook 'asm-mode-hook 'helm-cscope-mode)

;; Set key bindings
(eval-after-load "helm-cscope"
  '(progn
     (define-key helm-cscope-mode-map (kbd "M-t") 'helm-cscope-find-this-symbol)
     (define-key helm-cscope-mode-map (kbd "M-r") 'helm-cscope-find-global-definition)
     (define-key helm-cscope-mode-map (kbd "M-g M-c") 'helm-cscope-find-called-function)
     (define-key helm-cscope-mode-map (kbd "M-g M-p") 'helm-cscope-find-calling-this-function)
     (define-key helm-cscope-mode-map (kbd "M-s") 'helm-cscope-select)))

(helm-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (monokai-theme helm-cscope helm xcscope atomic-chrome magit markdown-mode use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
