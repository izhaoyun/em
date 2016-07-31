(defconst my/starter-kit-packages
  '(ivy
    swiper
    counsel
    hydra
    avy
    which-key
    hi-lock
    expand-region
    rainbow-delimiters
    undo-tree))

(install-packages my/starter-kit-packages)

(use-package hydra)

(use-package counsel
  :commands (ivy-mode)
  :preface
  (defun ivy-dired ()
      (interactive)
      (if ivy--directory
	  (ivy-quit-and-run
	   (dired ivy--directory)
	   (when (re-search-forward
		  (regexp-quote
		   (substring ivy--current 0 -1)) nil t)
	     (goto-char (match-beginning 0))))
	(user-error
	 "Not completing files currently")))
  :bind (("C-s" . counsel-grep-or-swiper)
	 ("M-x" . counsel-M-x)
	 ("M-y" . counsel-yank-pop)
	 ("C-r" . ivy-resume)
	 ("C-x C-f" . counsel-find-file)
	 ("C-x r b" . counsel-bookmark)
	 ("C-c s a" . counsel-ag)
	 ("C-c s g" . counsel-git)
	 ("C-c s i" . counsel-imenu)
	 ("C-c s p" . counsel-git-grep)
	 ("C-c s l" . counsel-locate)
	 ("C-c s t" . counsel-tmm)
	 ("C-c s r" . counsel-load-library)
	 ("C-c s n" . counsel-linux-app)
	 ("C-c u"   . swiper-all)
	 ("C-c v"   . ivy-push-view)
	 ("C-c V"   . ivy-pop-view))
  :bind (:map help-map
	      ("b" . counsel-descbinds)
	      ("f" . counsel-describe-function)
	      ("v" . counsel-describe-variable)
	      ("s" . counsel-info-lookup-symbol)
	      ("u" . counsel-unicode-char))
  :bind (:map ivy-minibuffer-map
	      ("C-:" . ivy-dired)
	      ("C-c o" . ivy-occur))
  :init
  (use-package ivy
    :init
      (ivy-mode 1)
      (diminish 'ivy-mode)
      :config
      (setq ivy-use-virtual-buffers t)
      (setq ivy-display-style 'fancy)
      (setq ivy-count-format "(%d/%d) ")
      )
  :config
  (setq counsel-find-file-at-point t)
  )

(use-package avy
  :bind (("C-:" . avy-goto-char)
	 ("M-p" . avy-pop-mark))
  :init
  (avy-setup-default)
  :config
  (advice-add 'swiper :before 'avy-push-mark)
  )

(use-package which-key
  :diminish which-key-mode
  :commands (which-key-mode
             which-key-setup-side-window-right-bottom)
  :init
  (which-key-mode)
  (which-key-setup-side-window-right-bottom))

(use-package hi-lock
  :init
  (global-hi-lock-mode))

(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package paren
  :init
  (show-paren-mode)
  :preface
  (defun match-paren (arg)
      "Go to the matching paren if on a paren; otherwise insert
%."
      (interactive "p")
      (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1)))))
  :bind (("%" . match-paren))
  :config
  (setq show-paren-style 'expression))

(use-package rainbow-delimiters
  :commands (rainbow-delimiters-mode)
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package winner
  :if (not noninteractive)
  :defer 5
  :config
  (winner-mode 1))

(use-package recentf
  :defer t
  :bind ("C-x C-r" . recentf-open-files)
  :config
  (recentf-mode))

(use-package undo-tree
  :defer t
  :diminish undo-tree-mode
  :commands (global-undo-tree-mode)
  :bind (("C-z"   . undo)
	 ("C-S-z" . undo-tree-redo))
  :config
  (progn
    (global-undo-tree-mode)
    (setq undo-tree-visualizer-diff t)
    (setq undo-tree-visualizer-timestamps t))
  )

(use-package hippie-exp
  :commands (hippie-expand)
  :bind ("M-/" . hippie-expand)
  
  )

(provide 'init-starter-kit)
;; init-starter-kit.el ends here.
