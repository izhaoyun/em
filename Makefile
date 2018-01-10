EMACS=emacs

FILES=init.el \
	custom.el \
	lisp/setup-editor.el \
	lisp/init-c++.el \
	lisp/init-lisp.el \
	lisp/init-org.el \
	lisp/init-python.el \
	lisp/init-go.el \
	lisp/init-web.el


all: $(FILES)
	$(EMACS) --eval '(mapc (lambda (x) (byte-compile-file (symbol-name x))) (quote ($(FILES))))'


clean:
	find . -maxdepth 2 -name "*elc" -exec rm {} \;
