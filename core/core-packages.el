;; use-package --- Use Packages define.
(require 'package)

;; add package repositories url.
;;(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(provide 'core-packages)
