;;; init-org --- Org-mode Configuration

;;; Commentary:

;;; Code:

(use-package org
  :mode
  (("\\.org$" . org-mode)
   ("\\.txt$" . txt-mode))
  :commands (org-create-multibrace-regexp)
  :bind (("C-c a" . org-agenda)
         ("C-c b" . org-iswitch)
         ("C-c c" . org-capture)
         ("C-c l" . org-store-link))
  :bind (:map org-mode-map
              ("M-o" . ace-link-org))
  :init
  (setq-default org-catch-invisible-edits 'smart)
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)

  ;; https://emacs-china.org/t/org-mode/597/11
  (setq org-emphasis-regexp-components
        (list (concat " \t('\"{"            "[:nonascii:]")
              (concat "- \t.,:!?;'\")}\\["  "[:nonascii:]")
              " \t\r\n,\"'"
              "."
              1))
  :config
  (setq org-footnote-auto-adjust t)
  (setq org-hide-emphasis-markers t)
  (setq org-match-substring-regexp
        (concat
         ;; info: (org) Subscripts and superscripts
         "\\([0-9a-zA-Zα-γΑ-Ω]\\)\\([_^]\\)\\("
         "\\(?:" (org-create-multibrace-regexp "{" "}" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:" (org-create-multibrace-regexp "(" ")" org-match-sexp-depth) "\\)"
         "\\|"
         "\\(?:\\*\\|[+-]?[[:alnum:].,\\]*[[:alnum:]]\\)\\)"))

  (add-to-list 'org-latex-packages-alist '("" "ctex"))
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (add-to-list 'org-latex-packages-alist '("" "color"))
  (add-to-list 'org-latex-packages-alist '("" "geometry"))
  (add-to-list 'org-latex-packages-alist '("" "tabularx"))
  (add-to-list 'org-latex-packages-alist '("" "tabu"))
  (add-to-list 'org-latex-packages-alist '("" "fancyhdr"))
  (add-to-list 'org-latex-packages-alist '("" "natbib"))
  (add-to-list 'org-latex-packages-alist '("" "titlesec"))
  )

(use-package ob
  :ensure org
  :commands (org-babel-do-load-languages)
  :init
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((awk        . t)
     (dot        . t)
     (sed        . t)
     (sql        . t)
     (http       . t)
     (ditaa      . t)
     (shell      . t)
     (python     . t)
     (plantuml   . t)
     (emacs-lisp . t)))
  )

(use-package ob-awk        :after ob :defer t)
(use-package ob-dot        :after ob :defer t)
(use-package ob-sed        :after ob :defer t)
(use-package ob-sql        :after ob :defer t)
(use-package ob-shell      :after ob :defer t)
(use-package ob-python     :after ob :defer t)
(use-package ob-emacs-lisp :after ob :defer t)
;; @github: zweifisch/ob-http
(use-package ob-http       :after ob :defer t)
(use-package ob-ditaa      :after ob :defer t
  :init
  (setq org-ditaa-jar-path "/usr/share/ditaa/ditaa.jar"))
(use-package ob-plantuml   :after ob :defer t
  :init
  (setq org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar")
  )

(use-package ox
  :ensure org
  :commands (org-export-derived-backend-p)
  :preface
  (defun clear-single-linebreak-in-cjk-string (string)
    (let* ((regexp "\\([\u4E00-\u9FA5]\\)\n\\([\u4E00-\u9FA5]\\)")
           (start (string-match regexp string)))
      (while start
        (setq string (replace-match "\\1\\2" nil nil string)
              start (string-match regexp string start))))
    string)
  :init
  (setq org-export-default-language "zh-CN"
        org-latex-compiler "xelatex")
  :config
  (defun ox-html-clear-single-linebreak-for-cjk (string backend info)
    (when (org-export-derived-backend-p backend 'html)
      (clear-single-linebreak-in-cjk-string string))
    )
  (add-to-list 'org-export-filter-final-output-functions
               'ox-html-clear-single-linebreak-for-cjk)
  )

(use-package ox-gfm :defer t)

(use-package ox-html
  :init
  (use-package htmlize)
  (setq org-html-html5-fancy t
        org-html-doctype "html5")
  )

;; @github: marsmining/ox-twbs
(use-package ox-twbs :ensure ox-twbs :defer t)

;; @github: masayuko/ox-rst
(use-package ox-rst :ensure ox-rst :defer t)

(use-package ox-latex
  :init
  (setq org-latex-listings 'minted)
  (setq org-latex-minted-options '(("frame"      "single")
                                   ("breaklines" "")))
  (setq org-latex-pdf-process
        '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  )

(use-package ox-beamer :defer t)

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  )

(provide 'init-org)
;;; init-org.el ends here
