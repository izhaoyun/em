(use-package python
  :mode ("\\.py\\'" . python-mode)
  :interpreter ("python" . python-mode)
  )

;; @github: proofit404/anaconda-mode
(use-package anaconda-mode
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  :config
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
  )

;; @github: proofit404/company-anaconda
(use-package company-anaconda
  :init
  (push 'company-anaconda company-backends)
  )

(provide 'init-python)
