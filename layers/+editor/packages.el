;; ▼ multiple cursor
(defun tools/multiplecursor ()
  "Multiple Cursor Init"
  (use-package multiple-cursors
    :ensure t
    :bind (("C-l" . mc/edit-lines)
           ("C-;" . mc/mark-all-like-this)
           ("C-'" . mc/mark-all-words-like-this)))
  )

;; ▶ Editor ---------------------------------------

;; symbol function imenu
(defun editor/popup-imenu ()
  "symbol function for imenu."
  (use-package popup-imenu
    :ensure t
    :bind (("C-f" . popup-imenu))
    ))

;; nlinum function setting.
(defun editor/nlinum ()
  "nlinum install"
  (use-package nlinum
    :ensure t
    :init
    (require 'nlinum)
    (set-face-background 'hl-line "yellow")
    (global-nlinum-mode t)))

;; ▼ ECB
    (defun editor/ecb ()
      "ECB IDE init"
      (use-package ecb
	:ensure t
	:init (setq ecb-layout-name "right5")
	(setq ecb-examples-bufferinfo-buffer-name nil)
	(setq stack-trace-on-error t)
	(setq ecb-version-check nil)
	(setq ecb-compile-window-height 12)
	(setq ecb-windows-width 0.20)
	(bind-key "M-1" 'ecb-goto-window-sources)
	(bind-key "M-2" 'ecb-goto-window-history)
	(bind-key "M-0" 'ecb-goto-window-edit1)
	;; disable tip of the day
	(setq ecb-tip-of-the-day nil)
	;; semantic settings
	(semantic-mode t)
	(require 'stickyfunc-enhance)
	(set-face-background 'semantic-highlight-func-current-tag-face "blue")
	(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
	(global-semanticdb-minor-mode t)
	(global-semantic-stickyfunc-mode t)
	(global-semantic-highlight-func-mode t)
	(global-semantic-decoration-mode t)))

;;  ecb sticky enchance
(defun editor/stickyenhance ()
  "ecb stickyfunc-enhance"
  (use-package stickyfunc-enhance
    :ensure t
  )
)

;; ▼ CodeComplete ( Autocomplete, yasnippet )
(defun editor/autocomplete ()
  "autocomplete init"
  (use-package auto-complete
    :ensure t
    :init (ac-config-default)
    (global-auto-complete-mode t)
    (setq ac-auto-start 1)
    (setq ac-auto-show-menu 0.1)
    (ac-set-trigger-key "TAB"))
  )

(defun editor/linux-c-indent ()
  "adjusted defaults for C/C++ mode use with the Linux kernel."
  (interactive)
  (setq indent-tabs-mode nil) 
  (setq c-basic-offset 4)
  (add-hook 'c-mode-hook 'linux-c-indent)
  (add-hook 'c-mode-hook (lambda() (c-set-style "gnu")))
  (add-hook 'c++-mode-hook 'linux-c-indent)
  )

(defun editor/smartparens ()
  "smartparen mode"
  (use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config
    (progn
      (require 'smartparens-config)
      (smartparens-global-mode 1)))
  )

;; ▼ yasnippet
(defun editor/yasnippet ()
  "yasnippet init"
  (use-package yasnippet
    :ensure t
    :defer t
    :diminish yas-minor-mode
    :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
    :init
    (progn
      (setq yas-verbosity 3)
      (yas-global-mode 1))
    (add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))
    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
    (ac-set-trigger-key "TAB")
    (ac-set-trigger-key "<tab>")
    (add-hook
     'prog-mode-hook
     (lambda ()
       (setq ac-sources
             (append '(ac-source-yasnippet) ac-sources)))))
  )

(defun editor/rainbow-delimiters ()
  "rainbow-delimiters"
  (use-package rainbow-delimiters
    :ensure t
    :defer t
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook #'rainbow-delimiters-mode)))
  )

;; linum display left margin.
(defun editor/linum ()
  "left margin linum"
  (use-package linum
    :ensure t
    :init
    (global-hl-line-mode +1)
    (setq linum-format "%-4d")
    (column-number-mode t)
    (size-indication-mode t)
    )
  )

;; package signature
(defun editor/load-error-settings ()
  "load error settings"
  (setq package-check-signature nil)
  )

;; windows move bind key
(defun editor/winmove-init ()
  "w:indow move init"
  (use-package winmove
    :bind (("C-c <right>" . windmove-right)
	   ("C-c <left>" . windmove-left)
	   ("C-c <up>" . windmove-up)
	   ("C-c <down>" . windmove-down)
	   )))

;; ripgrep search
(defun editor/ripgrep ()
  "ripgrep init"
  (use-package ripgrep
    :ensure t
    :bind (("C-p" . ripgrep-regexp))
    ))

;; emacs window manager
(defun editor/e2wm ()
  "window manager for emacs."
  (use-package e2wm
    :ensure t
    :bind (("M-+" . e2wm:start-management))
    )
  )
  
(defun editor/function-args ()
  ""
  )

;; encoding settings
(defun editor/language-encoding ()
  "language-encoding init"

  ;; fset yes or no --> y or n
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8)
  (set-language-environment "UTF-8")
  )

;; limit line colume.
(defun editor/column ()
  "editor row column limit line"
  (setq-default whitespace-line-column 80
		whitespace-style '(face lines-tail))
  (add-hook 'prog-mode-hook 'whitespace-mode))

;; auto-highlight-symbol
(defun editor/auto-highlight-symbol ()
  "thils only installs it for programming mode derivatives. you can also makeit global.."
  (use-package auto-highlight-symbol
    :ensure t
    :init (add-hook 'prog-mode-hook 'highlight-symbol-mode)
    (global-auto-highlight-symbol-mode t)
    :bind (:map auto-highlight-symbol-mode-map
                ("M-p" . ahs-backward)
                ("M-n" . ahs-forward)
                )
    )
  )

;; ▼ flycheck
(defun editor/flycheck ()
  "flycheck init"
  (use-package flycheck
    :ensure t
    :init (global-flycheck-mode))
  )

(defun editor/init-functions ()
  "init functions function-args, encoding, column"
  (editor/function-args)
  (editor/language-encoding)
  (editor/column)
  (editor/winmove-init)
  (editor/linum)
  (editor/dired-settings)
  (editor/e2wm)
  (editor/popup-imenu)
  (editor/load-error-settings)
  (editor/ecb)
  (editor/ripgrep)
  (editor/nlinum)
  (editor/autocomplete)
  (editor/yasnippet)
  (editor/auto-highlight-symbol)
  (editor/flycheck)
  (editor/linux-c-indent)
  (editor/smartparens)
  (editor/rainbow-delimiters)
  (editor/helm-gtags)
  (editor/helm-cscope)
  (editor/stickyenhance)
  )

(defun editor/dired-settings ()
  "dired copy setting."
  (setq dired-dwim-target t)
  )

;; ▶ Interface ---------------------------------------

;; ivy is an interactive interface for completion.
;; counsel package include ivy, bind-key, swiper.
(defun interface/ivy ()
    "interactive interface for completion."
  (use-package ivy 
    :ensure t
    :init
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    :bind (("C-s" . swiper )
	   ("C-c C-r" . ivy-resume)
	   )
    ))

;; counsel
(defun interface/counsel ()
  "interface counsel package"
  (use-package counsel
	       :ensure t
	       :init
	       :bind (("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file)
	   ("C-c c" . counsel-compile)
	   ("C-c g" . counsel-git)
	   ("C-c j" . counsel-git-grep)
	   ("C-c k" . counsel-ag)
	   ("C-b" . counsel-ibuffer)
	   ("C-x l" . counsel-locate)
	   ("≈" . counsel-M-x)
	   ("M-x" . counsel-M-x)
	   ))
  )

;; ivy gtags
(defun editor/ggtags ()
  "ivy for GNU global."
  (use-package ggtags
    :ensure t
    :init (add-hook 'c-mode-hook 'ggtags-mode)
    (add-hook 'c++-mode-hook 'ggtags-mode)
    :bind (("M-." . ggtags-find-tag-dwim)
	   ("M-r" . ggtags-find-reference)
	   ("M-s" . ggtags-find-other-symbol)
	   ("M-t" . ggtags-prev-mark)
	   ("M-n" . ggtags-next-mark))
    )
  )

;; helm gtags
(defun editor/helm-gtags ()
  "helm gtags gnu global"
  (use-package helm-gtags
    :ensure t
    :init (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'php-mode-hook 'helm-gtags-mode)
    :bind (("M-." . helm-gtags-dwim)
	   ("M-t" . helm-gtags-pop-stack)
	   ("M-r" . helm-gtags-find-tags)
	   ("M-s" . helm-gtags-find-symbol)
	   ("M-," . helm-gtags-previous-history)
	   ("M-n" . helm-gtags-next-history)))
  )

;; helm cscope
(defun editor/helm-cscope ()
  "helm cscope"
  (use-package helm-cscope
    :ensure t
    :init
    (add-hook 'c-mode-hook 'helm-cscope-mode)
    (add-hook 'c++-mode-hook 'helm-cscope-mode)
    (add-hook 'asm-mode-hook 'helm-cscope-mode)
    :bind (("C-c c" . helm-cscope-find-calling-this-function)
	   ("C-c d" . helm-cscope-find-called-this-function)
	   ("C-c ]" . helm-cscope-find-global-definition)
	   ("C-c [" . helm-cscope-pop-mark)
	   ("C-c e" . helm-cscope-find-egrep-pattern)))
  )

(defun cscope/init-xcscope ()
  "cscope package install"
  (use-package xcscope
    :ensure t
    :init
    (add-hook 'c-mode-hook 'xcscope-mode)
    (add-hook 'c++-mode-hook 'xcscope-mode)
    (add-hook 'asm-mode-hook 'xcscope-mode)
    :bind
    (("C-c c" . cscope-find-functions-calling-this-function)
     ("C-c ]" . cscope-find-global-definition)
     ("C-c [" . cscope-pop-mark)
     ("C-c t" . cscope-find-this-text-string)
     ("C-c n" . cscope-find-egrep-pattern))
    ))

;; Appearance ----------------------------------------------------------
  ;; ▼ telephone-line
(defun appear/telephone-init ()
 "telephone line init"
 (use-package telephone-line
  :ensure t
  :init 
  (setq telephone-line-primary-left-separator 'telephone-line-cubed-left
   telephone-line-secondary-left-separator 'telephone-line-cubed-hollow-left
   telephone-line-primary-right-separator 'telephone-line-cubed-right
   telephone-line-secondary-right-separator 'telephone-line-cubed-hollow-right)
  (setq telephone-line-height 20
   telephone-line-evil-use-short-tag t)
  (telephone-line-mode)))

;; ▼ powerline evil
(defun appear/powerline ()
  "powerline evil"
  (use-package powerline-evil
    :ensure t
    :init (evil-mode 1)
    (powerline-default-theme)
    ))

(defun appear/init-functions ()
  "init appear function."
)

;; init editor env.
(defun editor/init ()
  "Editor envirment init"
  ;; interface -----------------
  (interface/ivy)
  (interface/counsel)
  ;; Tools ---------------------
  (tools/multiplecursor)
  ;; Editor --------------------
  (editor/init-functions)
  ;; Appear
  (appear/init-functions)
  )
