(deftheme lisp-settings
  "Settings for Lisp")

(define-keys lisp-mode
  ("C-c C-q"  . #'slime-close-all-parens-in-sexp)
  ("<tab>"    . #'slime-fuzzy-indent-and-complete-symbol)
  ("<return>" . #'newline-and-indent)
  ("RET"      . #'newline-and-indent))



(provide-theme 'lisp-settings)
