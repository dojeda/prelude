(add-hook 'text-mode-hook 'turn-off-flyspell t)
;;(add-hook 'text-mode-hook 'turn-off-autofill t)

;;(powerline-default-theme t)
;;(nlinum-mode t)
;;(require 'main-line)

(defun my-latex-hook ()
  (linum-mode 1) ;; numero de linea a la izquierda
  (auto-fill-mode 0) ;; no filling !
  (set-input-method "latin-prefix")
  (flyspell-mode t) ;; spell check
  (reftex-mode 1)   ;; reftex
  (smartparens-mode 0) ;; no smartparen because it's laggy as of sept2013
  )
(add-hook 'TeX-mode-hook 'my-latex-hook)
(setq reftex-plug-into-AUCTeX t)

(defun reftex-format-cref (label def-fmt)
  (format "\\cref{%s}" label))
(setq reftex-format-ref-function 'reftex-format-cref)

(electric-pair-mode nil)

;; (require 'sr-speedbar)


;; A more useful header:

(defmacro with-face (str &rest properties)
    `(propertize ,str 'face (list ,@properties)))

;; (which-function-mode)
;; (setq mode-line-format (delete (assoc 'which-func-mode
;;                                       mode-line-format) mode-line-format)
;;       mywhich-func-header-line-format '(which-func-mode ("" which-func-format)))

(defun sl/make-header ()
  ""
  (let* ((sl/full-header (abbreviate-file-name buffer-file-name))
         (sl/header ( file-name-directory sl/full-header))
         (sl/drop-str "[...]"))
    (if (> (length sl/full-header)
           (window-body-width))
        (if (> (length sl/header)
               (window-body-width))
            (progn
              (concat (with-face sl/drop-str
                                 :background "blue"
                                 :weight 'bold
                                 )
                      (with-face (substring sl/header
                                            (+ (- (length sl/header)
                                                  (window-body-width))
                                               (length sl/drop-str))
                                            (length sl/header))
                                 ;; :background "red"
                                 :weight 'bold
                                 )))
          (concat (with-face sl/header
                             ;; :background "red"
                             :foreground "#8fb28f"
                             :weight 'bold
                             )))

              (with-face (file-name-nondirectory buffer-file-name)
                         :weight 'bold
                         ;; :background "red"
                         ))))

(defun sl/display-header ()
  (setq header-line-format
        '("" ;; invocation-name
          (:eval (if (buffer-file-name)
                     (sl/make-header)
                   "%b")))))
;; (add-hook 'buffer-list-update-hook
;;             'sl/display-header)


;; ;; auto complete
;; (require 'auto-complete-config)
;; (ac-config-default)

;; (semantic-mode 1)
;; (semantic-add-system-include "/usr/local/include" 'c++-mode)

;; (defun my-c-mode-cedet-hook ()

;;   (semantic-add-system-include "/usr/local/include" 'c++-mode)
;;   ;; (add-to-list 'ac-sources 'ac-source-gtags)
;;   ;; (add-to-list 'ac-sources 'ac-source-semantic)
;;   )
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;;(set-face-attribute 'default nil :font "Droid Sans Mono-10")
;;(setq default-frame-alist '((font . "Droid Sans Mono-10")))

;;(text-scale-set -5)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode t)
 '(TeX-default-unit-for-image "\\linewidth")
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(cppcm-makefile-name ".Makefile.cppcm")
 '(custom-safe-themes (quote ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(doc-view-continuous t)
 '(doc-view-resolution 200)
 '(ecb-compile-window-width (quote edit-window))
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote (("/" "/"))))
 '(ediff-merge-split-window-function (quote split-window-horizontally))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(electric-pair-mode nil)
 '(electric-pair-skip-self nil)
 '(fill-column 80)
 '(flycheck-clang-language-standard "c++11")
 '(global-flycheck-mode t nil (flycheck))
 '(global-semantic-highlight-func-mode nil)
 '(global-semantic-idle-breadcrumbs-mode t nil (semantic/idle))
 '(jedi:key-complete [(meta return)])
 '(prelude-auto-save nil)
 '(prelude-guru nil)
 '(prelude-whitespace nil)
 '(reftex-bibliography-commands (quote ("bibliography" "nobibliography" "addbibresource")))
 '(semantic-default-submodes (quote (global-semantic-highlight-func-mode global-semantic-decoration-mode global-semantic-stickyfunc-mode global-semantic-idle-completions-mode global-semantic-idle-scheduler-mode global-semanticdb-minor-mode global-semantic-idle-summary-mode global-semantic-mru-bookmark-mode global-semantic-idle-local-symbol-highlight-mode global-semantic-highlight-edits-mode)))
 '(show-paren-mode t)
 '(size-indication-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-default-highlight-face ((t (:background "DarkOliveGreen4"))))
 '(hl-line ((t (:inherit highlight :background "dark slate gray"))))
 '(semantic-highlight-func-current-tag-face ((t (:background "gray10")))))
