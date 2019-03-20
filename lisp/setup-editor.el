;;; -*- lexical-binding: t -*-

(fset 'yes-or-no-p 'y-or-n-p)

(if window-system (tool-bar-mode -1))

(use-package ivy
  :diminish ivy-mode
  :bind
  ((("C-x b" . ivy-switch-buffer)
    ("C-c C-r" . ivy-resume)))
  :bind
  (:map ivy-minibuffer-map
        ("C-c o" . ivy-occur)
        ("<tab>" . ivy-alt-done)
        ("C-i"   . ivy-partial-or-done)
        ("C-r"   . ivy-previous-line-or-history)
        ("M-r"   . ivy-reverse-i-search)
        ("<return>" . ivy-alt-done))
  :bind
  (:map ivy-switch-buffer-map
        ("C-k" . ivy-switch-buffer-kill))
  :init
  (setq ivy-use-virtual-buffers t
        ivy-count-format "(%d/%d) "
        ivy-display-style 'fancy
        ivy-use-selectable-prompt t
        ivy-wrap t)
  (ivy-mode 1)
  :config
  (ivy-set-occur 'swiper
                 'swiper-occur)
  (ivy-set-occur 'ivy-switch-buffer
                 'ivy-switch-buffer-occur)
  )

(use-package swiper
  :after ivy
  :bind
  ((("C-c u a" . swiper-all)
    ("C-r" . swiper)))
  :bind
  (:map swiper-map
        ("M-q" . swiper-query-replace)
        ("C-l" . swiper-recenter-top-bottom)
        ("C-'" . swiper-avy)
        ("M-c" . swiper-mc))
  )

(use-package counsel
  :after swiper
  :bind
  ((("C-s" . counsel-grep-or-swiper)
    ("M-x" . counsel-M-x)
    ("C-x C-f" . counsel-find-file)
    ("C-x C-r" . counsel-recentf)
    ("C-x r b" . counsel-bookmark)
    ("C-x r d" . counsel-bookmarked-directory)
    ("C-x C-b" . counsel-ibuffer)
    ("C-c c" . counsel-org-capture)
    ("<f2> m" . counsel-imenu)
    ("<f2> f" . counsel-git)
    ("<f2> g" . counsel-git-grep)
    ("<f2> s" . counsel-stash)
    ("<f2> b" . counsel-switch-to-shell-buffer)
    ("<f2> a" . counsel-ag)
    ("C-c k" . counsel-ag)
    ("<f2> r" . counsel-rg)
    ("C-c r" . counsel-rg)
    ("C-x l" . counsel-locate)
    ("C-x m" . counsel-mark-ring)
    ("M-y" . counsel-yank-pop)
    ("C-c f" . counsel-git-log)
    ("M-s d" . counsel-dired-jump)
    ("M-s f" . counsel-file-jump)
    ("C-h a" . counsel-apropos)
    ("C-h g" . counsel-info-lookup-symbol)
    ("C-h u" . counsel-unicode-char)
    ("C-h l" . counsel-find-library)
    ("C-h L" . counsel-load-library)
    ("C-h b" . counsel-descbinds)
    ("C-h w" . woman)))
  :bind
  (:map minibuffer-local-map
        ("C-r" . counsel-minibuf-history))
  :init
  (setq counsel-find-file-at-point t)
  )

(use-package rg
  ;; :ensure-system-package (rg . ripgrep)
  :init
  (rg-enable-default-bindings (kbd "M-s r"))
  )

(use-package wgrep-ag
  :hook
  ((ag-mode rg-mode) . wgrep-ag-setup)
  )

(use-package hydra)

(use-package ivy-hydra
  :after (ivy hydra)
  )

(use-package avy
  :bind
  (("C-:" . avy-goto-char)
   ("C-'" . avy-goto-char-2)
   ("M-g c" . avy-goto-char)
   ("M-g f" . avy-goto-line)
   ("M-g w" . avy-goto-word-1)
   ("M-g e" . avy-goto-word-0)
   ("C-c C-j" . avy-resume))
  :init
  (avy-setup-default)
  )

(use-package ace-pinyin
  :diminish ace-pinyin-mode
  )

(use-package avy-zap
  :bind
  (("M-z" . avy-zap-to-char-dwim)
   ("M-Z" . avy-zap-up-to-char-dwim))
  )

(use-package ace-link
  :init
  (ace-link-setup-default)
  )

(use-package popwin
  :bind-keymap
  ("C-<f2>" . popwin:keymap)
  :config
  ;; M-x dired-jump-other-window
  (push '(dired-mode :position top)
        popwin:special-display-config)

  ;; M-!
  (push "*Shell Command Output*"
        popwin:special-display-config)

  ;; M-x compile
  (push '(compilation-mode :noselect t)
        popwin:special-display-config)

  ;; vc
  (push "*vc-diff*" 
        popwin:special-display-config)
  (push "*vc-change-log*" 
        popwin:special-display-config)

  ;; undo-tree
  (push '(" *undo-tree*" :width 0.3 :position right)
        popwin:special-display-config)
  )

(use-package show-marks
  :bind
  (("<f2> <right>" . forward-mark)
   ("<f2> <left>" . backward-mark)
   ("<f2> <up>" . show-marks))
  )

(use-package volatile-highlights
  :diminish volatile-highlights-mode
  :init
  (volatile-highlights-mode)
  )

(use-package highlight-symbol
  :if window-system
  :bind
  (("C-<f3>" . highlight-symbol)
   ("<f3>"   . highlight-symbol-next)
   ("S-<f3>" . highlight-symbol-prev)
   ("M-<f3>" . highlight-symbol-query-replace))
  )

(use-package which-key
  :diminish which-key-mode
  :hook
  (after-init . which-key-mode)
  :init
  (which-key-setup-side-window-right-bottom)
  )

(use-package ws-butler
  :diminish ws-butler-mode
  :hook
  (prog-mode . ws-butler-mode)
  )

(use-package expand-region
  ;; :if window-system
  :bind
  (("<f2> =" . er/expand-region)
   ("<f2> -" . er/contract-region))
  )

(use-package undo-tree
  :diminish undo-tree-mode
  :hook
  ((prog-mode cmake-mode org-mode) . undo-tree-mode)
  :bind
  (("<f2> z" . undo)
   ("<f2> c" . redo))
  :init
  (defalias 'redo 'undo-tree-redo)
  (setq undo-tree-visualizer-diff t
        undo-tree-visualizer-timestamps t)
  )

(use-package dired-async
  :ensure async
  :hook
  (dired-mode . dired-async-mode)
  )

(use-package hippie-exp
  :ensure nil
  :bind
  ("M-/" . hippie-expand)
  )

(use-package paren
  :ensure nil
  :hook
  (prog-mode . show-paren-mode)
  )

(use-package winner
  :ensure nil
  :hook
  (after-init . winner-mode)
  )

(use-package wgrep
  :defer t
  )

(use-package flyspell
  :disabled
  :diminish flyspell-mode
  :hook
  ((text-mode . flyspell-mode)
   (prog-mode . flyspell-prog-mode))
  :init
  ;; settings for ispell
  (setq ispell-dictionary "en_US")
  )

(use-package easy-kill
  :bind
  (([remap kill-ring-save] . easy-kill)
   ([remap mark-sexp] . easy-mark))
  )

(use-package help-fns+
  :load-path "site-lisp/help-fns-plus"
  )

(use-package shell-pop
  :bind
  ("<f2> t" . shell-pop)
  :init
  (setq shell-pop-full-span t
        shell-pop-term-shell "/bin/bash"
        shell-pop-window-size 35
        shell-pop-window-position "bottom")
  (setq shell-pop-shell-type
        '("ansi-term" "*ansi-term*"
          (lambda nil (ansi-term shell-pop-term-shell))))
  )

(use-package multiple-cursors
  :preface
  :bind
  (("C-c m c" . mc/edit-lines))
  :config
  (defhydra multiple-cursors-hydra (:hint nil)
    "
     ^Up^            ^Down^        ^Other^
----------------------------------------------
[_p_]   Next    [_n_]   Next    [_l_] Edit lines
[_P_]   Skip    [_N_]   Skip    [_a_] Mark all
[_M-p_] Unmark  [_M-n_] Unmark  [_r_] Mark by regexp
^ ^             ^ ^             [_q_] Quit
"
    ("l" mc/edit-lines :exit t)
    ("a" mc/mark-all-like-this :exit t)
    ("n" mc/mark-next-like-this)
    ("N" mc/skip-to-next-like-this)
    ("M-n" mc/unmark-next-like-this)
    ("p" mc/mark-previous-like-this)
    ("P" mc/skip-to-previous-like-this)
    ("M-p" mc/unmark-previous-like-this)
    ("r" mc/mark-all-in-region-regexp :exit t)
    ("q" nil)
    )
  )

(use-package ranger)

(use-package server
  :ensure nil
  :commands (server-running-p)
  :init
  (unless (server-running-p)
    (server-start))
  )

(use-package window-numbering
  :defer t
  )

(provide 'setup-editor)

;; Local Variables:
;; coding: utf-8
;; indent-tabs-mode: nil
;; End:

;;; setup-editor.el ends here
