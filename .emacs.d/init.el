;; for geordi
(tool-bar-mode 0)
;; (menu-bar-mode 0)
(global-set-key "\M-g" 'goto-line)  ;; MAJORLY CONVENIENT
(global-set-key "\M-i" 'fill-paragraph)
(setq-default indent-tabs-mode t)
(setq-default menu-bar-mode nil)
(setq redisplay-dont-pause t)
(set-frame-parameter (selected-frame) 'alpha '(98 98))
(add-to-list 'default-frame-alist '(alpha 98 98))


(add-to-list 'load-path "~/.emacs.d") (require 'cycle-buffer)

(defun dos-to-unix () (replace-string "\r" "") "I'm done, master")
(setq font-lock-maximum-decoration t)
(find-file "~/mac/todo")

 (setq-default tab-width 4) ; or any other preferred value
    (setq cua-auto-tabify-rectangles nil)
    (defadvice align (around smart-tabs activate)
      (let ((indent-tabs-mode nil)) ad-do-it))
    (defadvice align-regexp (around smart-tabs activate)
      (let ((indent-tabs-mode nil)) ad-do-it))
    (defadvice indent-relative (around smart-tabs activate)
      (let ((indent-tabs-mode nil)) ad-do-it))
    (defadvice indent-according-to-mode (around smart-tabs activate)
      (let ((indent-tabs-mode indent-tabs-mode))
        (if (memq indent-line-function
                  '(indent-relative
                    indent-relative-maybe))
            (setq indent-tabs-mode nil))
        ad-do-it))
    (defmacro smart-tabs-advice (function offset)
      `(progn
         (defvaralias ',offset 'tab-width)
         (defadvice ,function (around smart-tabs activate)
           (cond
            (indent-tabs-mode
             (save-excursion
               (beginning-of-line)
               (while (looking-at "\t*\\( +\\)\t+")
                 (replace-match "" nil nil nil 1)))
             (setq tab-width tab-width)
             (let ((tab-width fill-column)
                   (,offset fill-column)
                   (wstart (window-start)))
               (unwind-protect
                   (progn ad-do-it)
                 (set-window-start (selected-window) wstart))))
            (t
             ad-do-it)))))
    (smart-tabs-advice c-indent-line c-basic-offset)
    (smart-tabs-advice c-indent-region c-basic-offset)

(smart-tabs-advice js2-indent-line js2-basic-offset)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes (quote ("f5e56ac232ff858afb08294fc3a519652ce8a165272e3c65165c42d6fe0262a0" default)))
 '(help-at-pt-display-when-idle (quote (flymake-overlay)) nil (help-at-pt))
 '(help-at-pt-timer-delay 0.01)
 '(indent-tabs-mode t)
 '(menu-bar-mode nil)
 '(smart-tabs-advice js2-indent-line)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting "cycle-buffer" "Toggle if this buffer will be considered." t)
; (global-set-key [(f9)]        'cycle-buffer-backward)
(global-set-key (kbd "C-M-j")        'cycle-buffer-backward)
(global-set-key (kbd "C-M-k")       'cycle-buffer)
(global-set-key [(shift f9)]  'cycle-buffer-backward-permissive)
(global-set-key [(shift f10)] 'cycle-buffer-permissive)



;; autocomplete ;; kind of cool i guess
(add-to-list 'load-path "~/.emacs.d/auto-complete-1.3.1")
; Load the default configuration
(require 'auto-complete-config)
; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/emacs.d/auto-complete-1.3.1/dict")
; Use dictionaries by default
(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)


;; syntax checking
(add-to-list 'load-path "~/.emacs.d/lintnode")
(require 'flymake-jslint)
;; Make sure we can find the lintnode executable
(setq lintnode-location "~/.emacs.d/lintnode")
;; JSLint can be... opinionated
(setq lintnode-jslint-excludes (list 'nomen 'onevar 'white))
(setq lintnode-jslint-includes (list 'vars))
;; Start the server when we first open a js file and start checking
(add-hook 'js-mode-hook  (lambda () (lintnode-hook)))

;; (add-to-list 'load-path "~/.emacs.d/flymake-cursor.el")
;; (require 'flymake-cursor)



;; code folding
(add-hook 'js-mode-hook (lambda () (imenu-add-menubar-index) (hs-minor-mode t)))

;; 
(global-set-key (kbd "C-M-u") 'hs-hide-block)
(global-set-key (kbd "C-M-i") 'hs-show-block)
(global-set-key (kbd "C-M-o") 'hs-show-all)
(global-set-key (kbd "C-M-y") 'hs-hide-all)

;; 
(global-set-key (kbd "C-M-+") 'text-scale-increase)
(global-set-key (kbd "C-M-=") 'text-scale-increase)
(global-set-key (kbd "C-M--") 'text-scale-decrease)
(global-set-key (kbd "C-M-_") 'text-scale-decrease)

(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (load-theme 'zenburn)


(defun unfill-region (beg end)
      "Unfill the region, joining text paragraphs into a single
    logical line.  This is useful, e.g., for use with
    `visual-line-mode'."
      (interactive "*r")
      (let ((fill-column (point-max)))
        (fill-region beg end)))
    
    ;; Handy key definition
    (define-key global-map "\C-\M-Q" 'unfill-region)
