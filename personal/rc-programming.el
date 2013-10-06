;;;
;;; Code:
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-unmatched-syntax-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-show-parser-state-mode)

;; Activate semantic
(semantic-mode 1)

(require 'semantic/bovine/c)
(require 'semantic/bovine/gcc)

(require 'cedet-files)

;; loading contrib...
;;(require 'eassist) ;; PUT THIS BACK ON WHEN INSTALLING CEDET

;;(add-hook 'prog-mode-hook 'turn-off-guru-mode t)
(add-hook 'prog-mode-hook 'turn-off-flyspell t)
(add-hook 'prog-mode-hook 'whitespace-turn-off t)

;; ;; cambiar entre fuente y header en C/C++
(defvar c++-default-header-ext "h")
(defvar c++-default-source-ext "cpp")
(defvar c++-header-ext-regexp "\\.\\(hpp\\|hxx\\|h\\|\hh\\|H\\)$")
(defvar c++-source-ext-regexp "\\.\\(cpp\\|cxx\\|c\\|\cc\\|C\\)$")
(defvar c++-source-extension-list '("c" "cc" "C" "cpp" "cxx" "c++"))
(defvar c++-header-extension-list '("h" "hh" "H" "hpp" "hxx"))(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; (defun toggle-source-header()
;;   "Switches to the source buffer if currently in the header buffer and vice versa."
;;   (interactive)
;;   (let ((buf (current-buffer))
;;         (name (file-name-nondirectory (buffer-file-name)))
;;         file
;;         offs)
;;     (setq offs (string-match c++-header-ext-regexp name))
;;     (if offs
;;         (let ((lst c++-source-extension-list)
;;               (ok nil)
;;               ext)
;;           (setq file (substring name 0 offs))
;;           (while (and lst (not ok))
;;             (setq ext (car lst))
;;             (if (file-exists-p (concat file "." ext))
;;                   (setq ok t))
;;             (setq lst (cdr lst)))
;;           (if ok
;;               (find-file (concat file "." ext))))
;;       (let ()
;;         (setq offs (string-match c++-source-ext-regexp name))
;;         (if offs
;;             (let ((lst c++-header-extension-list)
;;                   (ok nil)
;;                   ext)
;;               (setq file (substring name 0 offs))
;;               (while (and lst (not ok))
;;                 (setq ext (car lst))
;;                 (if (file-exists-p (concat file "." ext))
;;                     (setq ok t))
;;                 (setq lst (cdr lst)))
;;               (if ok
;;                   (find-file (concat file "." ext)))))))))
;; (global-set-key [f9] 'toggle-source-header)

(defun my-c-hook ()
  ;; PUT ALL THESE BACK ON WHEN INSTALLED CEDET
  ;; (local-set-key (kbd "C-c C-c") 'compile)
  ;; (local-set-key [f9] 'eassist-switch-h-cpp)
  ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  ;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;; ;;
  ;; (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)
  ;; (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  ;; (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  ;; (local-set-key "\C-cq" 'semantic-ia-show-doc)
  ;; (local-set-key "\C-cs" 'semantic-ia-show-summary)
  ;; (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;; (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;; (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)
  ;; (local-set-key) "\C-ce" 'eassist-list-methods
  ;; (local-set-key "\C-c\C-r" 'semantic-symref)

  (nlinum-mode 1) ; numero de linea a la izquierda
  (subword-mode 1) ;sub-word mode
  ;;(fci-mode 1) ;show fill-column mode
  (setq c-basic-offset 4)
  )

(add-hook 'c-mode-hook 'my-c-hook)
(add-hook 'c++-mode-hook 'my-c-hook)
;; (require 'google-c-style)    ;; PUT THIS BACK ON WHEN INSTALLED GOOGLE-C-STYLE THROUGH ELGET
;; (add-hook 'c-mode-common-hook 'google-set-c-style)


(defun my-python-hook ()
  (nlinum-mode 1)
  (subword-mode 1) ;sub-word mode
  )

(add-hook 'python-mode-hook 'my-python-hook)

;; EDE
(global-ede-mode 1)
(ede-enable-generic-projects)

;; QT and CEDET
(when (eq system-type 'darwin)
  (add-to-list 'auto-mode-alist '("/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers" . c++-mode))
  (semantic-add-system-include "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers" 'c++-mode)
  (add-to-list 'auto-mode-alist '("/opt/local/Library/Frameworks/QtGui.framework/Versions/4/Headers" . c++-mode))
  (semantic-add-system-include "/opt/local/Library/Frameworks/QtGui.framework/Versions/4/Headers" 'c++-mode)
  (add-to-list 'auto-mode-alist '("/opt/local/include/qwt" . c++-mode))
  (semantic-add-system-include "/opt/local/include/qwt" 'c++-mode)

  (add-to-list 'semantic-lex-c-preprocessor-symbol-file
               "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers/qconfig.h")
  (add-to-list 'semantic-lex-c-preprocessor-symbol-file
               "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers/qconfig-dist.h"))

;; cmake
(require 'cmake-mode)
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

;; spice mode
(autoload 'spice-mode "spice-mode" "Spice/Layla Editing Mode" t)
(add-to-list 'auto-mode-alist '("\\.cir$"          . spice-mode))
;; (add-to-list 'auto-mode-alist '("\\.ckt$"          . spice-mode))
;; (add-to-list 'auto-mode-alist '("\\.inp$"          . spice-mode))
;; (add-to-list 'auto-mode-alist '("\\.spout$"        . spice-mode));hspice out
;; (add-to-list 'auto-mode-alist '("\\.pdir$"         . spice-mode))

;; modelica mode
(add-to-list 'auto-mode-alist '("\\.mdc$"          . modelica-mode))
(add-to-list 'auto-mode-alist '("\\.mo$"           . modelica-mode))


;; eshell stuff
(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))
