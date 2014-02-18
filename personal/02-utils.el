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

;; (require 'fill-column-indicator)
;; (turn-on-fci-mode)

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

(require 'git-messenger)
(global-set-key (kbd "C-x v p") 'git-messenger:popup-message)

(require 'guide-key)
(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x 5" "C-c p"))
(guide-key-mode 1)  ; Enable guide-key-mode
