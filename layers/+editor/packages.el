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
	   ("C-i" . grep-find))
    )
  )

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
	   ("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file)
	   ("C-c c" . counsel-compile)
	   ("C-c g" . counsel-git)
	   ("C-c j" . counsel-git-grep)
	   ("C-c k" . counsel-ag)
	   ("C-x l" . counsel-locate)
	   ("C-c C-r" . ivy-resume))
    ))

;; ivy gtags
(defun counsel/gtags ()
  "ivy for GNU global."
  (use-package counsel-gtags
    :ensure t
    :init (add-hook 'c-mode-hook 'counsel-gtags-mode)
    (add-hook 'c++-mode-hook 'counsel-gtags-mode)
    :bind (("M-." . counsel-gtags-dwim)
	   ("M-r" . counsel-gtags-find-reference)
	   ("M-s" . counsel-gtags-find-symbol)
	   ("M-t" . counsel-gtags-go-backward))
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
    (("C-c c" . cscope-find-functions-calling-this-symbol)
     ("C-c ]" . cscope-find-global-definition)
     ("C-c [" . cscope-pop-mark)
     ("C-c t" . cscope-find-this-text-string)
     ("C-c n" . cscope-find-egrep-pattern))
    ))

;; Appearance ----------------------------------------------------------
  
;; init editor env.
(defun editor/init ()
  "Editor envirment init"
  ;; interface -----------------
  (interface/ivy)
  (counsel/gtags)
  (cscope/init-xcscope)
  ;; Tools ---------------------
  (tools/multiplecursor)
  ;; Editor --------------------
  (editor/init-functions)
  )
