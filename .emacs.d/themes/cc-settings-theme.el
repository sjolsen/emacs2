;;; -*- lexical-binding: t -*-

(deftheme cc-settings
  "Settings for C, C++, and more")

(defvar cc-map/hook-alist
  '((c-mode-map   . c-mode-hook)
    (c++-mode-map . c++-mode-hook))
  "Modes to which we're going to add common key customizations. This
should be an alist mapping mode-map names to mode-hook names.")

(defvar cc-keybind-alist
  '(("C-m" . #'c-context-line-break))
  "An alist mapping forms which evaluate to suitable arguments to
`read-kbd-macro' to forms which evaluate to commands")

(defun hook-up-cc-keybinds ()
  (let ((binding-alist (make-alist cc-keybind-alist)))
    (dolist (map/hook cc-map/hook-alist)
      (let ((mode-map-sym (car map/hook))
            (mode-hook-sym (cdr map/hook)))
        (add-hook mode-hook-sym (λ ()
                                  (dolist (binding binding-alist)
                                    (define-key (eval mode-map-sym)
                                      (read-kbd-macro (car binding))
                                      (cdr binding)))))))))

(eval-after-load 'cc-mode
  (hook-up-cc-keybinds))


;; Convenience features

(eval-after-load 'cc-mode
  '(progn
     (let ((hooks (mapcar #'cdr cc-map/hook-alist)))
       (require 'smart-tabs-mode)
       (smart-tabs-insinuate 'c 'c++))))


;; Style

(c-add-style "sjolsen"
  '("bsd"
    (tab-width . 4)
    (c-basic-offset . 4)
    (c-offsets-alist . ((cpp-define-intro . 0)
                        (cpp-macro        . 0)
                        (label            . 0)
                        (case-label       . +)
                        (innamespace      . +)))))


;; Backslashes

(defface c-backslash-face
  '((default . (:inherit shadow)))
  "Face for displaying terminal backslashes in C and related modes")

(font-lock-add-keywords 'c-mode
  '(("\\(\\\\\\)$" 1 'c-backslash-face)))
(font-lock-add-keywords 'c++-mode
  '(("\\(\\\\\\)$" 1 'c-backslash-face)))



(custom-theme-set-variables
 'cc-settings
 '(c-auto-align-backslashes nil)
 '(c-basic-offset 'set-from-style)
 '(c-cleanup-list (quote (scope-operator)))
 '(c-default-style "sjolsen")
 '(c-doc-comment-style (quote ((c-mode . gtkdoc) (c++-mode . javadoc) (java-mode . javadoc) (pike-mode . autodoc)))))

(custom-theme-set-faces
 'cc-settings)

(provide-theme 'cc-settings)
