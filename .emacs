(setq frame-background-mode 'dark)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(eglot-java lsp-javacomp lsp-java jedi numpydoc blacken poetry hide-mode-line lsp-python-ms python-mode evil-smartparens smartparens flymake-jslint dap-mode helm-c-yasnippet flycheck-irony company-ctags helm-company ac-clang ac-helm avy-flycheck c-eldoc company company-c-headers company-irony company-irony-c-headers eldoc flycheck helm helm-flycheck helm-lsp irony-eldoc lsp-mode gnu-elpa-keyring-update))
 '(warning-suppress-log-types '((comp))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(load-theme 'misterioso t)

;;requires
(require 'use-package)
(require 'eglot)
(use-package eglot :ensure t)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(global-auto-revert-mode t)
;;c mode configs
(global-linum-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)(require 'use-package)
(require 'eglot)

;;c-cpp hooks
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'eglot-ensure)

;;python mode hooks
(add-hook 'python-mode-hook 'eglot-ensure)
(add-hook 'python-mode-hook 'hs-minor-mode)
(add-hook 'python-mode-hook 'lsp)


(add-hook 'after-init-hook 'global-company-mode)

;;c mode configs
(global-linum-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)(require 'use-package)
(require 'eglot)
(add-hook 'c++-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(setq c-basic-offset 4)
(add-hook 'c++-mode-hook 'c-toggle-hungry-state)

;;js mode
(add-hook 'js-mode-hook 'hs-minor-mode)

;;minibuf
(setq max-mini-window-height 3)

;;copy pase to clipboard
(setq x-select-enable-clipboard t)

;;lsp config
(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(setq lsp-signature-auto-activate nil)
(setq eglot-ignored-server-capabilites '(:documentHighlightProvider))


(which-key-mode)
(split-window-right)

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

;;helm config
;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for d>
(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)


;;ignore this keybind
(global-set-key (kbd "C-z") 'ignore)


;;custom functions
; func to toggle windows orientation
(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))

;;save sessions
;;(desktop-save-mode 1)
(desktop-save-mode 1)
(desktop-read)


;;html

;;js
(add-hook 'js-mode-hook 'eglot-ensure)


;;python
(use-package python
	:config
	;; remove guess indent message
	(setq python-indent-guess-offset-verbose nil)
)

(use-package python
  :config
  ;; Remove guess indent python message
  (setq python-indent-guess-indent-offset-verbose nil))

;; Hide the modeline for inferior python processes.  This is not a necessary
;; package but it's helpful to make better use of the screen real-estate at our
;; disposal. See: https://github.com/hlissner/emacs-hide-mode-line.

(use-package hide-mode-line
  :ensure t
  :defer t
  :hook (inferior-python-mode . hide-mode-line-mode))


;;<OPTIONAL> I use poetry (https://python-poetry.org/) to manage my python environments.
;; See: https://github.com/galaunay/poetry.el.
;; There are alternatives like https://github.com/jorgenschaefer/pyvenv.
(use-package poetry
  :ensure t
  :defer t
  :config
  ;; Checks for the correct virtualenv. Better strategy IMO because the default
  ;; one is quite slow.
  (setq poetry-tracking-strategy 'switch-buffer)
  :hook (python-mode . poetry-tracking-mode))

;; <OPTIONAL> Buffer formatting on save using black.
;; See: https://github.com/pythonic-emacs/blacken.
(use-package blacken
  :ensure t
  :defer t
  :custom
  (blacken-allow-py36 t)
  (blacken-skip-string-normalization t)
  :hook (python-mode-hook . blacken-mode))

;; <OPTIONAL> Numpy style docstring for Python.  See:
;; https://github.com/douglasdavis/numpydoc.el.  There are other packages
;; available for docstrings, see: https://github.com/naiquevin/sphinx-doc.el
(use-package numpydoc
  :ensure t
  :defer t
  :custom
  (numpydoc-insert-examples-block nil)
  (numpydoc-template-long nil)
  :bind (:map python-mode-map
              ("C-c C-n" . numpydoc-generate)))

;; Provide drop-down completion.
(use-package company
  :ensure t
  :defer t
  :custom
  ;; Search other buffers with the same modes for completion instead of
  ;; searching all other buffers.
  (company-dabbrev-other-buffers t)
  (company-dabbrev-code-other-buffers t)
  ;; M-<num> to select an option according to its number.
  (company-show-numbers t)
  ;; Only 2 letters required for completion to activate.
  (company-minimum-prefix-length 3)
  ;; Do not downcase completions by default.
  (company-dabbrev-downcase nil)
  ;; Even if I write something with the wrong case,
  ;; provide the correct casing.
  (company-dabbrev-ignore-case t)
  ;; company completion wait
  (company-idle-delay 0.2)
  ;; No company-mode in shell & eshell
  (company-global-modes '(not eshell-mode shell-mode))
  ;; Use company with text and programming modes.
    :hook ((text-mode . company-mode)
           (prog-mode . company-mode)))

(use-package eglot
  :ensure t
  :defer t
  :hook (python-mode . eglot-ensure))
(global-flycheck-mode)
(setq flycheck-check-syntax-automatically '(save mode-enabled))

;; set transparency
;;(set-frame-parameter (selected-frame) 'alpha '(85 85))
;;(add-to-list 'default-frame-alist '(alpha 85 85))
