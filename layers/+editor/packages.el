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
    (nlinum-mode 1)
    (set-face-background 'linum "yellow")
    (set-face-foreground 'linum "red")
    (setq nlinum-format "%4d \u2502")
    (global-hl-line-mode +1)
    (set-face-background 'hl-line "dimgray")
;;    (set-face-foreground 'hl-line "white")
    (global-nlinum-mode t)
    (setq auto-window-vscroll nil)
    ))

;; ▼ ECB
    (defun editor/ecb ()
      "ECB IDE init"
      (use-package ecb
	:ensure t
	:init (setq ecb-layout-name "right5")
	(setq ecb-examples-bufferinfo-buffer-name nil)
	(setq stack-trace-on-error t)
	(setq ecb-version-check nil)
	(setq ecb-compile-window-height 15)
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
	(set-face-foreground 'semantic-highlight-func-current-tag-face "black")
;;	(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
	(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
	(global-semanticdb-minor-mode t)
;;	(global-semantic-stickyfunc-mode t)
	(global-semantic-highlight-func-mode t)
	(global-semantic-decoration-mode t)))

;; highlight symbol
(defun editor/highlight-symbol-init ()
  "hilight symbol init"
  (use-package highlight-symbol
    :ensure t
    )
  )

;;  ecb sticky enchance
(defun editor/stickyenhance ()
  "ecb stickyfunc-enhance"
  (use-package stickyfunc-enhance
    :ensure t
    :init (tabbar-mode t)
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

(defun linux-c-indent ()
  (setq c-basic-offset 8)
  (add-hook 'c-mode-hook (lambda() (c-set-style "K&R")))
  (add-hook 'c++-mode-hook (lambda() (c-set-style "K&R")))
  (add-hook 'phps-mode-hook (lambda() (c-set-style "K&R")))
  )

(defun editor/linux-c-indent ()
  "adjusted defaults for C/C++ mode use with the Linux kernel."
  (interactive)
  (setq indent-tabs-mode nil) 

  (add-hook 'c-mode-hook 'linux-c-indent)
  (add-hook 'c++-mode-hook 'linux-c-indent)
  (add-hook 'phps-mode-hook 'linux-c-indent)
  )

(defun editor/smartparens ()
  "smartparen mode"
  (use-package smartparens
    :ensure t
    :diminish smartparens-mode
    :config
    (progn
      (require 'smartparens-config)
      (smartparens-global-mode 1)
      (show-paren-mode 1)
      ))
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

(defun editor/php-mode ()
  "php mode settings"
  (use-package phps-mode
    :ensure t
    :init (autoload 'phps-mode "php-mode" "Major mode for editing PHP code." t)
    (add-to-list 'auto-mode-alist '("\\.php$" . phps-mode)))
  )

;; linum display left margin.
(defun editor/linum ()
  "left margin linum"
  (use-package linum
    :ensure t
    :init
    (global-hl-line-mode +1)

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

;; tabbar mode
(defun editor/tabbar-ruler ()
  "tabbar mode"
  (use-package tabbar-ruler
    :ensure t
;;    :init ((setq tabbar-ruler-global-tabbar t))
    :bind ("C-t" . tabbar-ruler-move)
  ))

;; encoding settings
(defun editor/language-encoding ()
  "language-encoding init"

  ;; fset yes or no --> y or n
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8)
  (set-language-environment "UTF-8")
;;(setq whitespace-space 'underline)
  )

;; limit line colume.
(defun editor/column ()
 "editor row column limit line"
 ;;  (setq-default whitespace-line-column 80
	 ;;		whitespace-style '(face lines-tail))
 ;;  (add-hook 'prog-mode-hook 'whitespace-mode)
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
 ;; http://ergoemacs.org/emacs/whitespace-mode.html
 (setq whitespace-space 'underline)
 (setq whitespace-style (quote (tabs tab-mark big-indent)))

 ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
 (setq whitespace-display-mappings
  ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
  '(
	  (space-mark 32 [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
	  (newline-mark 10 [182 10]) ; LINE FEED,
	  (tab-mark 9 [9655 9] [92 9]) ; tab
	  (big-indent 32 [46] [46])
	  ))
 (global-whitespace-mode 1)
 )

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
  (editor/winmove-init)
;;  (editor/linum)
  (editor/dired-settings)
;;  (editor/column)
;;  (editor/e2wm)
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
  (editor/php-mode)
  (editor/tabbar-ruler)
  (editor/helm-evil-marker)
  (editor/highlight-symbol-init)
  )

(defun editor/dired-settings ()
  "dired copy setting."
  (setq dired-dwim-target t)
  (bind-key "C-h" 'find-name-dired)
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
	   ("C-b" . helm-mini)
	   ("C-x l" . counsel-locate)
	   ("≈" . counsel-M-x)
	   ("M-x" . counsel-M-x)
	   ))
  )

(defun interface/init-functions ()
  "interface init functions"
  (interface/ivy)
  (interface/counsel)
  )

;; ivy gtags
(defun editor/ggtags ()
  "ivy for GNU global."
  (use-package ggtags
    :ensure t
    :init (add-hook 'c-mode-hook 'ggtags-mode)
    (add-hook 'c++-mode-hook 'ggtags-mode)
    (add-hook 'php-mode-hook 'ggtags-mode)
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

;; helm evil marker
(defun editor/helm-evil-marker ()
  "helm evil marker init"
  (use-package helm-evil-markers
    :ensure t
    :bind (("C-c e" . helm-evil-markers)
	   ("C-c m" . helm-evil-markers-set))
    )
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

;; equake mode
(defun appear/equake-init ()
  (use-package equake
    :ensure t
    :config
    :bind (("C-u" . equake-launch-shell)))
  )

;; ▼ highlight-indent-guides
(defun appear/highlight-indent-init ()
  "highlight indent guide"
  (use-package highlight-indent-guides
    :ensure t
    :config
;;    (add-hook 'c-mode-hook 'highlight-indent-guides-mode)
;;    (add-hook 'c++-mode-hook 'highlight-indent-guides-mode)
;;    (add-hook 'shell-script-mode 'highlight-indent-guides-mode)
;;    (add-hook 'python-mode-hook 'highlight-indent-guides-mode)
;;    (add-hook 'phps-mode-hook 'highlight-indent-guides-mode)
    :init (setq highlight-indent-guides-method 'character)
;;   (setq highlight-indent-guides-character ?\|)
    (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
    (setq highlight-indent-guides-delay 20)
    (setq highlight-indent-guides-auto-odd-face-perc 15)
    (setq highlight-indent-guides-auto-even-face-perc 15)
    (setq highlight-indent-guides-auto-character-face-perc 20)
    )
  )

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
  (appear/equake-init)
  (appear/highlight-indent-init)
  (setq redisplay-dont-pause t)
)

;; init editor env.
(defun editor/init ()
  "Editor envirment init"
  ;; interface -----------------
  (interface/init-functions)
  ;; Tools ---------------------
  (tools/multiplecursor)
  ;; Editor --------------------
  (editor/init-functions)
  ;; Appear
  (appear/init-functions)
  )
