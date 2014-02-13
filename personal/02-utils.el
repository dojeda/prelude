(require 'multi-term)

(if (eq system-type 'darwin)
    (setq multi-term-program "/bin/zsh")
  (setq multi-term-program "/usr/local/bin/zsh")
)

(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

(setq sml/theme 'dark)
(require 'smart-mode-line)
(sml/setup)


(helm-mode 1)
