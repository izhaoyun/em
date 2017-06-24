;;; custom.el --- Customization -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(before-save-hook (quote (whitespace-cleanup)))
 '(column-number-mode t)
 '(gc-cons-threshold 104857600)
 '(gdb-many-windows t)
 '(gdb-show-main t)
 '(gdb-speedbar-auto-raise t)
 '(global-auto-revert-mode t)
 '(global-linum-mode nil)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(ispell-extra-args (quote ("--lang=en_US" "--sug-mode=ultra")))
 '(load-prefer-newer t)
 '(menu-bar-mode nil)
 '(mouse-avoidance-mode (quote jump) nil (avoid))
 '(package-archives
   (quote
    (("melpa" . "http://elpa.emacs-china.org/melpa/")
     ("org" . "http://elpa.emacs-china.org/org/")
     ("gnu" . "http://elpa.emacs-china.org/gnu/"))))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   (quote
    (company-irony-c-headers org inf-ruby puppet-mode ivy-hydra ox-gfm rainbow-delimiters ob-http markdown-mode git-timemachine rtags elf-mode multiple-cursors git-gutter smartparens sr-speedbar ztree yaml-mode ws-butler which-key web-mode use-package undo-tree stickyfunc-enhance python pyenv-mode projectile popwin pip-requirements org-plus-contrib magit lispy js2-mode jinja2-mode hungry-delete htmlize highlight-symbol highlight-indent-guides gnuplot-mode ggtags function-args flycheck-pos-tip flycheck-plantuml flycheck-irony expand-region dtrt-indent diff-hl company-quickhelp company-irony company-go company-erlang company-edbi company-c-headers company-auctex company-anaconda comment-dwim-2 cmake-font-lock clean-aindent-mode auto-compile aggressive-indent ace-pinyin)))
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(show-paren-mode t)
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(vc-handled-backends (quote (SVN Git Hg)))
 '(visible-bell t)
 '(winner-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;; custom.el ends here
