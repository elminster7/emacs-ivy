;;
;; emacs first load path
;;

(defvar emacs-start-directory
  user-emacs-directory
  "emacs start directory.")

(defvar emacs-core-directory
  (expand-file-name (concat emacs-start-directory "core/"))
  "emacs core directory.")

;; ▶ ex) Appearance, VersionControl, Editor, Build, Tools... etc
(defvar emacs-layers-dir (expand-file-name "layers" emacs-dir)
  " This directory is divide to package.")

;; ▶ appearance directory.
(defvar layer-appearance-dir (expand-file-name "+appearance/packages.el" emacs-layers-dir)
  "This directory Appearance directory.")

;; ▶ VersionControl Directory.
(defvar layer-version-control-dir (expand-file-name "+versioncontrol/packages.el" emacs-layers-dir)
  "This Directory VersionControl.")

;; ▶ Editor Directory.
(defvar layer-editor-dir (expand-file-name "+editor/packages.el" emacs-layers-dir)
  "This Directory Editor.")

;; ▶tags Directory.
(defvar layer-tags-dir (expand-file-name "+tags/packages.el" emacs-layers-dir)
  "This Directory Editor.")

;; tools Directory.
(defvar layer-tools-dir (expand-file-name "+tools/package.el" emacs-layers-dir)
  "This Directory Editor.")

;; global nlinum directory
(defvar layer-editor-nlinum-dir (expand-file-name "+editor/nlinum/nlinum.el" emacs-layers-dir)
  "This Directory nlinum dir.")

;; ▶ Build/Debugger Directory.
(defvar layer-build-dir (expand-file-name "+build/packages.el" emacs-layers-dir)
  "This Directory Build/Debugger.")

;; ▶ add layer-version-control-dir
(defun emacs/layer-version-control-path ()
    "emacs version control layer directory load path."
  (load-file layer-version-control-dir)
  (versioncontrol/init))

;; ▶ add appearance path init.
(defun emacs/load-appearance-path ()
  "emacs theme layer directory load path."
  (load-file layer-appearance-dir)
  (appearance/init))

;; ▶ add editor path init
(defun emacs/load-editor-dir ()
  "emacs editor directory load path."
  (load-file layer-editor-dir)
;;  (load-file layer-editor-nlinum-dir)
  (editor/init))

;; ▶add tags path init
(defun emacs/load-tags-dir ()
  "emacs tags directory load path."
  (load-file layer-tags-dir)
  (tags/init))

;; add tools path init
(defun emacs/load-tools-dir ()
  "emacs tags directory load path."
  (load-file layer-tools-dir)
  (tools/init))

;; ▶ add build/debugging path init
(defun emacs/load-debug-dir ()
  "emacs build/debugging directory load path."
  (load-file layer-build-dir)
  (build/init))

(defun emacs/load-path-init ()
  " Defined Directory default init."
  ;; VersionControl init
  ;;(emacs/layer-version-control-path)
  ;; Appearance init
  ;;(emacs/load-appearance-path)
  ;; Editor init
  (emacs/load-editor-dir)
  ;; emacs tags init
  ;;(emacs/load-tags-dir)
  ;; Build/debugger init
  ;;(emacs/load-debug-dir)
  ;; helm-imenu
  ;;(emacs/load-tools-dir)
  )

(provide 'core-load-path)
