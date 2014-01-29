(require 'multi-term)

(if (eq system-type 'darwin)
    (setq multi-term-program "/bin/zsh")
  (setq multi-term-program "/usr/local/bin/zsh")
)
