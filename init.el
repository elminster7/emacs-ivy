;; elminster emacs configuration init.el.
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(package-initialize)

(when (version< emacs-version "26.0")
	(error "babel requires at least GNU Emacs 26.0"))
(defvar emacs-dir (file-name-directory load-file-name)
	"The root dir of the Emacs babel distribution.")
(defvar emacs-core-dir (expand-file-name "core" emacs-dir)
  "The home of babel's core functionality.")

;; hide the startup message
(setq inhibit-startup-message t)

;; add babel's directories to Emacs's `load-path'
(add-to-list 'load-path emacs-core-dir)

;; the core stuff
(require 'core-emacs)
(require 'core-packages)

(emacs/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (ivy-rich yasnippet vlf use-package telephone-line tabbar-ruler sublimity sublime-themes subatomic256-theme spacemacs-theme solarized-theme smex s pyvenv org-bullets nyx-theme multiple-cursors multi-term monokai-alt-theme magit igrep highlight-symbol highlight-indentation highlight-indent-guides helm-tramp helm-projectile helm-gtags helm-cscope helm-bind-key google-c-style ggtags function-args flycheck eyebrowse exec-path-from-shell ecb docker-tramp dired+ darkokai-theme company-jedi bm better-defaults beacon autumn-light-theme auto-highlight-symbol auto-complete anything all-the-icons alect-themes)))
 '(pdf-view-midnight-colors (quote ("#b2b2b2" . "#292b2e")))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(vlf-application (quote dont-ask)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

