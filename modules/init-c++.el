(defconst my/c++-packages
  '(company-c-headers
    irony
    company-irony
    flycheck-irony
    google-c-style
    flycheck-google-cpplint
    irony-eldoc
    company-irony-c-headers
    rtags
    cmake-ide
    )
  )

(install-packages my/c++-packages)

(use-package cc-mode
  :mode ("\\.h\\(h?\\|xx\\|pp\\)\\'" . c++-mode)
  :preface
  (defun my/init-hs-minor-mode ()
    (hs-minor-mode 1)
    (diminish 'hs-minor-mode)
    )
  :config
  (defun my/c-mode-common-hook ()
    (setq-default indent-tabs-mode nil)
    (define-key c-mode-map  [(tab)] 'company-complete)
    (define-key c++-mode-map  [(tab)] 'company-complete)

	(setq-default indent-tabs-mode nil)
    )
  (use-package google-c-style
    :init
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (add-hook 'c-mode-common-hook 'google-make-newline-indent)
    )
  (add-hook 'c-mode-common-hook 'my/init-hs-minor-mode)
  (add-hook 'c-mode-common-hook 'my/c-mode-common-hook)
  )

(use-package irony
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async)
    )
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)

  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

  (use-package company-irony
    :init
    (use-package company-irony-c-headers
      :init
      (eval-after-load 'company
        '(add-to-list 'company-backends 'company-irony-c-headers))
      )
    (add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
    :config
    (add-to-list 'company-backends 'company-irony)
    )

  (use-package flycheck-irony
    :init
    (add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
    )

  (use-package irony-eldoc
    :init
    (add-hook 'irony-mode-hook 'irony-eldoc)
    )
  )

(use-package company-c-headers
  :init
  (add-to-list 'company-backends 'company-c-headers)
  )

(defun c++/init-flycheck-google-cpplint ()
  (use-package flycheck-google-cpplint
    :after flycheck
    :init
    (setq flycheck-googlelint-verbose "3")
    (setq flycheck-googlelint-filter "-whitespace,+whitespace/braces")
    (setq flycheck-googlelint-root "project/src")
    (setq flycheck-googlelint-linelength "120")
    :config
    (flycheck-add-next-checker 'c/c++-cppcheck
                               '(warning . c/c++-googlelint))
    )
  )
(add-hook 'c-mode-common-hook 'c++/init-flycheck-google-cpplint)

(defun c++/init-cmake-ide ()
  (use-package cmake-ide
    :defer t
    :init
    (setq cmake-ide-rdm-executable "/usr/local/bin/rdm")
    :config
    (require 'rtags)
    (cmake-ide-setup)
    (rtags-enable-standard-keybindings c-mode-base-map)
    )
  )
(add-hook 'c-mode-common-hook 'c++/init-cmake-ide)

(provide 'init-c++)
;;; init-c++.el ends here
