;;; 03-programming.el --- personal programming configuration
;;; Commentary:
;;;
;;; Code:

;; FIXME: this is not working. The modes are being set by the customized
;; variables in custom.el
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
(require 'semantic)
;;(semantic-mode 1)

;; (require 'semantic/bovine/c)
;; (require 'semantic/bovine/gcc)

;; (require 'cedet-files)

;; loading contrib...
;;(require 'eassist) ;; PUT THIS BACK ON WHEN INSTALLING CEDET

;;(add-hook 'prog-mode-hook 'turn-off-guru-mode t)
(add-hook 'prog-mode-hook 'turn-off-flyspell t)
(add-hook 'prog-mode-hook 'whitespace-turn-off t)

(require 'project-explorer)

(require 'jedi)

(require 'auto-complete)
(require 'auto-complete-clang)
(require 'auto-complete-config)
(require 'yasnippet)
(yas/reload-all)

(setq ac-auto-start nil)
(setq ac-quick-help-delay 0.5)
;; (ac-set-trigger-key "TAB")
;; (define-key ac-mode-map  [(control tab)] 'auto-complete)
;;(define-key ac-mode-map  [(control tab)] 'auto-complete)
(defun my-ac-config ()
  (message "Running my-ac-config")
  (setq ac-clang-flags
        (append '("-std=c++11") (mapcar (lambda (item)(concat "-I" item))
                                        (split-string
                                         "
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/c++/v1
  /usr/local/include
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/../lib/clang/5.0/include
  /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/include
  /usr/include
  /usr/local/include
"
                                         ))))
  (setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
  ;; (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
  (add-hook 'css-mode-hook 'ac-css-mode-setup)
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (setq flycheck-clang-language-standard "c++11")
  (global-auto-complete-mode t)
)
(defun my-ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources)))
(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
;; ac-source-gtags
(my-ac-config)

;; /Users/david/PostDoc/devel/VNSModel/src/c++
;; /Users/david/PostDoc/devel/VNSModel/M2SL/src/c++

;; (ac-config-default)
;; (setq ac-auto-start 3)     ;; start after 3 characters were typed
;; (setq ac-auto-show-menu t) ;; show menu immediately...
;; explicit call to auto-complete
(define-key ac-mode-map [(meta return)] 'auto-complete)

;; (global-auto-complete-mode)

;;(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; ;; cambiar entre fuente y header en C/C++
(defvar c++-default-header-ext "h")
(defvar c++-default-source-ext "cpp")
(defvar c++-header-ext-regexp "\\.\\(hpp\\|hxx\\|h\\|\hh\\|H\\)$")
(defvar c++-source-ext-regexp "\\.\\(cpp\\|cxx\\|c\\|\cc\\|C\\)$")
(defvar c++-source-extension-list '("c" "cc" "C" "cpp" "cxx" "c++"))
(defvar c++-header-extension-list '("h" "hh" "H" "hpp" "hxx"))(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

(defun toggle-source-header()
  "Switches to the source buffer if currently in the header buffer and vice versa."
  (interactive)
  (let ((buf (current-buffer))
        (name (file-name-nondirectory (buffer-file-name)))
        file
        offs)
    (setq offs (string-match c++-header-ext-regexp name))
    (if offs
        (let ((lst c++-source-extension-list)
              (ok nil)
              ext)
          (setq file (substring name 0 offs))
          (while (and lst (not ok))
            (setq ext (car lst))
            (if (file-exists-p (concat file "." ext))
                  (setq ok t))
            (setq lst (cdr lst)))
          (if ok
              (find-file (concat file "." ext))))
      (let ()
        (setq offs (string-match c++-source-ext-regexp name))
        (if offs
            (let ((lst c++-header-extension-list)
                  (ok nil)
                  ext)
              (setq file (substring name 0 offs))
              (while (and lst (not ok))
                (setq ext (car lst))
                (if (file-exists-p (concat file "." ext))
                    (setq ok t))
                (setq lst (cdr lst)))
              (if ok
                  (find-file (concat file "." ext)))))))))
;; (global-set-key [f9] 'toggle-source-header)

(defun my-c-hook ()
  ;; PUT ALL THESE BACK ON WHEN INSTALLED CEDET
  (local-set-key (kbd "C-c C-c") 'compile)
  ;;(local-set-key [f9] 'eassist-switch-h-cpp)
  ;;(local-set-key [f9] 'ff-find-related-file)
  (local-set-key [f9] 'toggle-source-header)
  ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  ;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;; ;;
  ;; (local-set-key "\C-c>" 'semantic-comsemantic-ia-complete-symbolplete-analyze-inline)
  ;; (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  ;; (local-set-key "\C-cq" 'semantic-ia-show-doc)
  ;; (local-set-key "\C-cs" 'semantic-ia-show-summary)
  ;; (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;; (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  ;; (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)
  ;; (local-set-key) "\C-ce" 'eassist-list-methods
  ;; (local-set-key "\C-c\C-r" 'semantic-symref)
  ;; (semantic-mode t)
  (yas-minor-mode-on)
  ;;(auto-complete-mode 1)
  (nlinum-mode 1) ; numero de linea a la izquierda
  (subword-mode 1) ;sub-word mode
  ;;(fci-mode 1) ;show fill-column mode
  (setq c-basic-offset 4)
  ;;(setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))
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

;; ;; EDE
;; (global-ede-mode 1)
;; (ede-enable-generic-projects)

;; ;; QT and CEDET
;; (when (eq system-type 'darwin)
;;   (add-to-list 'auto-mode-alist '("/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers" . c++-mode))
;;   (semantic-add-system-include "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers" 'c++-mode)
;;   (add-to-list 'auto-mode-alist '("/opt/local/Library/Frameworks/QtGui.framework/Versions/4/Headers" . c++-mode))
;;   (semantic-add-system-include "/opt/local/Library/Frameworks/QtGui.framework/Versions/4/Headers" 'c++-mode)
;;   (add-to-list 'auto-mode-alist '("/opt/local/include/qwt" . c++-mode))
;;   (semantic-add-system-include "/opt/local/include/qwt" 'c++-mode)

;;   (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;                "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers/qconfig.h")
;;   (add-to-list 'semantic-lex-c-preprocessor-symbol-file
;;                "/opt/local/Library/Frameworks/QtCore.framework/Versions/4/Headers/qconfig-dist.h"))

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

;; cpputils
;; (add-to-list 'load-path "~/apps/cpputils-cmake" )
(require 'cpputils-cmake)
(add-hook 'c-mode-hook (lambda () (cppcm-reload-all)))
(add-hook 'c++-mode-hook (lambda () (cppcm-reload-all)))
;; ;; OPTIONAL, somebody reported that they can use this package with Fortran
;; (add-hook 'c90-mode-hook (lambda () (cppcm-reload-all)))
;; ;; OPTIONAL, avoid typing full path when starting gdb
;; (global-set-key (kbd "C-c C-g")
;;                 '(lambda ()(interactive) (gud-gdb (concat "gdb --fullname " (cppcm-get-exe-path-current-buffer)))))


;; iedit-mode
(define-key global-map (kbd "C-c ;") 'iedit-mode)

;;;
