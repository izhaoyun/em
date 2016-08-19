(defconst my/starter-kit-packages
  '(ivy
	swiper
	counsel
	hydra
	avy
	ace-window
	lispy
	which-key
	hi-lock
	expand-region
	rainbow-delimiters
	undo-tree
	iedit
	highlight-symbol
	ace-pinyin
	)
  )

(install-packages my/starter-kit-packages)

(defalias 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "RET") 'newline-and-indent)
;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)
;; ibuffer
(global-set-key (kbd "C-x C-b") 'ibuffer)
;; hippie-expand
(global-set-key (kbd "M-/") 'hippie-expand)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(use-package hydra)

(use-package counsel
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
	   "Not completing files currently"))
	)
  :bind (("C-s"		. counsel-grep-or-swiper)
		 ("M-x"		. counsel-M-x)
		 ("M-y"		. counsel-yank-pop)
		 ("C-r"		. ivy-resume)
		 ("C-x C-f" . counsel-find-file)
		 ("C-x r b" . counsel-bookmark)
		 ("C-c s a" . counsel-ag)
		 ("C-c s f" . counsel-git)
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
			  ("C-:"	. ivy-dired)
			  ("C-c o"	. ivy-occur))
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
  :bind (("C-:"   . avy-goto-char)
		 ("C-'"   . avy-goto-char-2)
		 ("M-g f" . avy-goto-line)
		 ("M-g w" . avy-goto-word-1)
		 ("M-g e" . avy-goto-word-0)
		 ("M-g c" . avy-goto-conditional)
		 ("M-g p" . avy-goto-paren))
  :init
  (avy-setup-default)
  :config
  ;; Jumping to conditionals in Elisp
  (defun avy-goto-conditional ()
	(interactive)
	(avy--generic-jump "\\s(\\(if\\|cond\\|when\\|unless\\)\\b" nil 'pre)
	)
  (defun avy-goto-paren ()
	(interactive)
	(avy--generic-jump "(" nil 'pre)
	)

  :config
  (advice-add 'swiper :before 'avy-push-mark)

  (use-package ace-pinyin
	:diminish ace-pinyin-mode
	:config
	(ace-pinyin-global-mode)
	)
  )

(use-package ace-window)

(use-package iedit
  :bind ("C-c i e" . iedit-mode)
  )

(use-package lispy
  :diminish lispy-mode
  :init
  ;; enable lispy automatically for emacs-lisp-mode
  (add-hook 'emacs-lisp-mode-hook 'lispy-mode)

  ;; enable lispy for eval-expression
  (defun conditionally-enable-lispy ()
	(when (eq this-command 'eval-expression)
	  (lispy-mode 1))
	)
  (add-hook 'minibuffer-setup-hook 'conditionally-enable-lispy)
  )

(use-package which-key
  :defer t
  :diminish which-key-mode
  :config
  (which-key-mode)
  (which-key-setup-side-window-right-bottom)
  )

(use-package highlight-symbol
  :bind (("C-<f3>" . highlight-symbol)
		 ("<f3>"   . highlight-symbol-next)
		 ("S-<f3>" . highlight-symbol-prev)
		 ("M-<f3>" . highlight-symbol-query-replace))
  )

(use-package winner
  :if (not noninteractive)
  :defer 18
  :config
  (winner-mode 1)
  )

(use-package recentf
  :defer 10
  :commands (recentf-open-files)
  :bind ("C-x C-r" . recentf-open-files)
  :config
  (recentf-mode 1)
  )

(use-package undo-tree
  :defer 15
  :diminish undo-tree-mode
  :commands (undo-tree-visualizer-mode)
  :bind (("C-/"   . undo-tree-undo)
		 ("C-_"   . undo-tree-undo)
		 ("M-_"   . undo-tree-redo)
		 ("C-?"   . undo-tree-redo)
		 ("C-x u" . undo-tree-visualize-mode)
		 ("C-x r u" . undo-tree-save-state-to-register)
		 ("C-x r U" . undo-tree-restore-state-from-register))
  :config
  (global-undo-tree-mode 1)
  (setq undo-tree-auto-save-history t)
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t)
  )

(use-package abbrev
  :defer t
  :diminish abbrev-mode
  :commands abbrev-mode
  :config
  (if (file-exists-p abbrev-file-name)
	  (quietly-read-abbrev-file))

  (add-hook 'prog-mode-hook #'abbrev-mode)
  (add-hook 'text-mode-hook #'abbrev-mode)
  (add-hook 'LaTeX-mode-hook #'abbrev-mode)
  )

(use-package autorevert
  :diminish auto-revert-mode
  :defer 25
  :config
  (global-auto-revert-mode)
  )

(provide 'init-starter-kit)
;; init-starter-kit.el ends here.
