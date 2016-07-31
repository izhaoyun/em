(defconst my/devel-packages
  '(company
    company-quickhelp
    yasnippet
    projectile
    comment-dwim-2
    aggressive-indent
    magit
    ))

(install-packages my/devel-packages)

(eval-and-compile
  (defun my/prog-mode-hook ()
    (setq case-fold-search nil)
    )
  (add-hook 'prog-mode-hook 'my/prog-mode-hook)
  )

(use-package company
  :init
  ;; (add-hook 'prog-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  :config
  (setq company-show-numbers t)
  (setq company-tooltip-limit 20)
  )

(use-package company-quickhelp
  :commands company-quickhelp-mode
  :after company
  :init
  (company-quickhelp-mode 1)
  (setq company-quickhelp-delay nil)
  :bind
  (:map company-active-map
	("M-h" . company-quickhelp-manual-begin))
  )

(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

(use-package projectile
  :diminish projectile-mode
  :commands (projectile-global-mode)
  :init
  (projectile-global-mode)
  (setq projectile-completion-system 'ivy)
  )

(use-package eldoc
  :diminish eldoc-mode
  :config
  (add-hook 'prog-mode-hook #'eldoc-mode)
  )

(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :init
  (add-hook 'prog-mode-hook #'aggressive-indent-mode)
  )

(use-package magit
  :defer t
  :bind ("C-x t g" . magit-status))

(use-package yasnippet
  :commands (yas-reload-all
	     yas-minor-mode)
  :init
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  :config
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)
  )

(provide 'init-devel)
