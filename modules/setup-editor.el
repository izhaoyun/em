;;; setup-editor --- basic settings -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defalias 'yes-or-no-p 'y-or-n-p)

(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq buffer-file-coding-system 'utf-8)

(global-set-key (kbd "C-h C-f") 'find-function)
(global-set-key (kbd "C-h C-v") 'find-variable)

;; automatic and manual symbol highlighting for emacs.
;; @github: nschum/highlight-symbol.el
(use-package highlight-symbol
  :defer t
  :bind (("C-<f3>" . highlight-symbol)
         ("<f3>"   . highlight-symbol-next)
         ("S-<f3>" . highlight-symbol-prev)
         ("M-<f3>" . highlight-symbol-query-replace)))

;; trim spaces from end of line.
;; @github: lewang/ws-butler
(use-package ws-butler
  :defer t
  :diminish ws-butler-mode
  :init
  (ws-butler-global-mode))

(use-package whitespace
  :defer t
  :init
  (add-hook 'before-save-hook 'whitespace-cleanup))

;; a replacement for the emacs' built-in command `comment-dwim'.
;; @github: remyferre/comment-dwim-2
(use-package comment-dwim-2
  :bind ("M-;" . comment-dwim-2))

;; treat undo history as a tree.
(use-package undo-tree
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode)
  :config
  (setq undo-tree-visualizer-diff t)
  (setq undo-tree-visualizer-timestamps t))

;; expand region increases the selected region by semantic units.
;; @github: magnars/expand-region.el
(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

;; a popup window manager.
;; @github: m2ym/popwin-el
(use-package popwin
  :bind-keymap ("C-z" . popwin:keymap)
  :commands (popwin-mode)
  :config
  (popwin-mode 1))

;; @github: malabarba/aggressive-indent-mode
(use-package aggressive-indent
  :diminish aggressive-indent-mode
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode))

;; highlights indentation levels via font-lock.
;; @github: DarthFennec/highlight-indent-guides
(use-package highlight-indent-guides
  :init
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  (setq highlight-indent-guides-auto-odd-face-perc 15)
  (setq highlight-indent-guides-auto-even-face-perc 15)
  (setq highlight-indent-guides-auto-character-face-perc 20))

(use-package clean-aindent-mode
  :config
  (add-hook 'prog-mode-hook 'clean-aindent-mode))

(use-package dtrt-indent
  :diminish (dtrt-indent-mode)
  :init
  (dtrt-indent-mode 1)
  :config
  (setq dtrt-indent-verbosity 0))

;; @github: fourier/ztree
(use-package ztree)

;; @github: Fanael/rainbow-delimiters
(use-package rainbow-delimiters
  :init
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(provide 'setup-editor)
;;; setup-editor.el ends here
