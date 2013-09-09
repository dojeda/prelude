(when (eq system-type 'darwin)
  (normal-erase-is-backspace-mode t)
  ;;(setq mac-transparency-alpha 84)
  (setq-default scroll-conservatively 1000) ;scroll 1 line at a time
  (setq scroll-step 1)                      ;scroll 1 line at a time
  (setq font-lock-maximum-decoration t)
  (global-set-key [home] 'beginning-of-line)
  (global-set-key [end] 'end-of-line)
  (global-set-key [del] 'delete-char)
  
  (require 'prelude-osx)
  (prelude-swap-meta-and-super)
  
  (defun dojeda/maximize-frame ()
    (interactive)
    (set-frame-position (selected-frame) 50 0)
    (set-frame-size (selected-frame) 262 68)))
