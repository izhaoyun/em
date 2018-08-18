;;; -*- lexical-binding: t -*-

(setq load-prefer-newer t
      package-enable-at-startup nil)
(autoload 'package-initialize "package")

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents)
  (package-install 'use-package)
  )

(use-package use-package
  :init
  (setq use-package-always-ensure t
        use-package-verbose t)
  )

(use-package diminish
  :defer t
  )

(use-package bind-key
  :defer t
  )

(use-package system-packages
  :defer t
  :init
  (setq system-packages-use-sudo t
        system-packages-package-manager 'apt)
  )

(use-package use-package-ensure-system-package
  :defer t
  :after (system-packages)
  )

(use-package use-package-chords
  :defer t
  :init
  (key-chord-mode 1)
  )

(use-package auto-package-update
  :defer t
  :commands (auto-package-update-maybe)
  :init
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t
        auto-package-update-prompt-before-update t
        auto-package-update-interval 14)
  (auto-package-update-maybe)
  )

(provide 'setup-packages)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:
;;; setup-packages.el ends here
