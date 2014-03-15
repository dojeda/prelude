; configure marmalade
(require 'package)
(add-to-list 'package-archives
             '("marmalade" .
               "http://marmalade-repo.org/packages/"))
(package-initialize)

; This are the packages that I want automatically installed
(prelude-require-packages
 '(auctex
   auctex-latexmk
   nlinum
   cmake-mode
   auto-complete
   auto-complete-clang
   magit
   project-explorer
   cmake-mode
   jedi
   window-number
   smart-mode-line
   ido-vertical-mode
   color-identifiers-mode
   git-messenger
   guide-key
   multiple-cursors
   cpputils-cmake
   multi-term
   yasnippet
   iedit
))
