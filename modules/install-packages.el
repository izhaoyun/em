;;; install-packages --- Installed Packages Lists -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(eval-when-compile
  (require 'cl))

(defun my/packages-installed-p ()
  "Check whether all packages are installed."
  (loop for pkg in package-selected-packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (my/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg package-selected-packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(provide 'install-packages)
;;; install-packages.el ends here
