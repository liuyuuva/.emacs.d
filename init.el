(if (eq system-type 'windows-nt)
    (progn
      	(let ((default-directory "~/.emacs.d/"))
	(normal-top-level-add-subdirs-to-load-path))
	(add-to-list 'backup-directory-alist  '("." . "~/.emacs.d/backup/"))
	(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves" t)))
	(setq default-directory "~/")
	(add-to-list 'exec-path "~/Softwares/Aspell/bin/")
	(setq ispell-dictionary "~/Softwares/Aspell/dict/")
	(setq myprojectfile "~/Notes/Projects_2017.org")
	(load-file "~/.emacs.d/init_proxy.el")
;;	(add-to-list 'exec-path "c:/cygwin64/bin") ;; Added for ediff function
	(add-to-list 'exec-path "c:/msys64/mingw64/bin");; added for clang
	(setq preview-gs-command "gswin64c")
	(setq doc-view-ghostscript-program "gswin64c")
	)
	)
  

(if (eq system-type 'darwin)
  (progn
    (let ((default-directory "~/.emacs.d/"))
      (normal-top-level-add-subdirs-to-load-path))
    (add-to-list 'backup-directory-alist  '("." . "~/.emacs.d/backup/"))
    (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
    (setq ispell-program-name "aspell"
      ispell-dictionary "english"
      ispell-dictionary-alist
      (let ((default '("[A-Za-z]" "[^A-Za-z]" "[']" nil
                       ("-B" "-d" "english" "--dict-dir"
                        "/Library/Application Support/cocoAspell/aspell6-en-6.0-0")
                       nil iso-8859-1)))
        `((nil ,@default)
          ("english" ,@default))))
;With the above apsell config for mac os, i also edited
;/usr/local/etc/aspell.conf to change the string after "dict-dir" to
;"/Library/Application Support/cocoAspell/aspell6-en-6.0-0". Flyspell
;mode now works fine.
    )
  )

(if (eq system-type 'gnu/linux)
    (progn
      (let ((default-directory "~/.emacs.d/"))
	  (normal-top-level-add-subdirs-to-load-path))
    (add-to-list 'backup-directory-alist  '("." . "~/.emacs.d/backup/"))
    (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
    )
  )

(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Instant Access to Init File
(defun load-init ()
  "Edit the init file in another window."
  (interactive)
  (find-file-other-window user-init-file))
(global-set-key (kbd "C-c I") 'load-init)
  

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)



(setq-default tab-width 4) ; or any other preferred value
;(defvaralias 'c-basic-offset 'tab-width)

;(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(require 'package)
;; Avoid multiple initialization of installed packages.
(setq package-enable-at-startup nil)
;; Add Melpa to the list of package archives.
;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))

(add-to-list 'load-path "~/.emacs.d/elpa/pyvenv-1.9")
;; Do package initiazation.
(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))


;; Install use-package.  It is the only one explicitly installed, all the others
;; are automatically installed using the :ensure property of use-package.
(unless   (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(if (eq system-type 'windows-nt)
    (require 'benchmark-init)
  )

(defalias 'yes-or-no-p 'y-or-n-p)
;; open recent directory, requires ivy (part of swiper)
;; borrows from http://stackoverflow.com/questions/23328037/in-emacs-how-to-maintain-a-list-of-recent-directories
(defun bjm/ivy-dired-recent-dirs ()
  "Present a list of recently used directories and open the selected one in dired"
  (interactive)
  (let ((recent-dirs
         (delete-dups
          (mapcar (lambda (file)
                    (if (file-directory-p file) file (file-name-directory file)))
                  recentf-list))))

    (let ((dir (ivy-read "Directory: "
                         recent-dirs
                         :re-builder #'ivy--regex
                         :sort nil
                         :initial-input nil)))
      (dired dir))))

(global-set-key (kbd "C-x M-r") 'bjm/ivy-dired-recent-dirs)



;; remember cursor position
(if (version< emacs-version "25.0")
    (progn
      (use-package saveplace
	:config (setq-default save-place t))
      (setq-default save-place t))
  (save-place-mode 1))

;(run-at-time (current-time) 300 'recentf-save-list)

(use-package bookmark
  :ensure t
  :config
  (progn
    (global-unset-key (kbd "<C-f1>"))
    (define-key global-map (kbd "<C-f1>") 'bookmark-set)
    (define-key global-map (kbd "<f1>") 'bookmark-jump)
    (define-key global-map (kbd "M-L") 'bookmark-bmenu-list)
    ))

(use-package bm
  :ensure t
  :config
  (progn
    (global-set-key (kbd "<C-f2>") 'bm-toggle)
    (global-set-key (kbd "<f2>")   'bm-next)
    (global-set-key (kbd "<S-f2>") 'bm-previous)
    )
  )

(use-package vlf
  :ensure t
  :config (progn
            (require 'vlf-setup)))

(use-package neotree
  :ensure t
  :defer t
  :config
  (progn
    (global-set-key (kbd "<C-f12>") 'neotree-toggle)
    )

 )

(use-package markdown-mode
  :ensure t
  :defer t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "pandoc")
  :config
  (progn
	(setq markdown-split-window-direction 'right)
	(setq markdown-enable-math t)
        (defun my-mmm-markdown-auto-class (lang &optional submode)
  "Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
If SUBMODE is not provided, use `LANG-mode' by default."
  (let ((class (intern (concat "markdown-" lang)))
        (submode (or submode (intern (concat lang "-mode"))))
        (front (concat "^```" lang "[\n\r]+"))
        (back "^```"))
    (mmm-add-classes (list (list class :submode submode :front front :back back)))
    (mmm-add-mode-ext-class 'markdown-mode nil class)))

;; Mode names that derive directly from the language name
    (mapc 'my-mmm-markdown-auto-class
      '("awk" "bibtex" "c" "cpp" "css" "html" "latex" "lisp" "makefile"
        "markdown" "python" "r" "ruby" "sql" "stata" "xml")
      )
    (defun my-mmm-gfm-auto-class (lang &optional submode)
  "Define a mmm-mode class for LANG in `gfm-mode' using SUBMODE.
If SUBMODE is not provided, use `LANG-mode' by default."
  (let ((class (intern (concat "gfm-" lang)))
        (submode (or submode (intern (concat lang "-mode"))))
        (front (concat "^```" lang "[\n\r]+"))
        (back "^```"))
    (mmm-add-classes (list (list class :submode submode :front front :back back)))
    (mmm-add-mode-ext-class 'gfm-mode nil class)))

;; Mode names that derive directly from the language name
    (mapc 'my-mmm-gfm-auto-class
      '("awk" "bibtex" "c" "cpp" "css" "html" "latex" "lisp" "makefile"
        "markdown" "python" "r" "ruby" "sql" "stata" "xml")
      )
    )

  )


(use-package mmm-mode
  :ensure t
  :config
  (progn
    (setq mmm-global-mode 'maybe)
    (setq mmm-parse-when-idle 't)
    )
  )

;; (use-package rainbow-delimiters
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
;;   )

(use-package magit
  :defer t
  :ensure t
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  )

(use-package pandoc-mode
  :ensure t
  :defer t
  :config
  (progn
    (add-hook 'markdown-mode-hook 'pandoc-mode)
    )
  )


(use-package which-key
  :ensure t
  :defer t
  :init
  (which-key-mode)
  :config
  (progn
    (setq which-key-popup-type 'side-window)
    (which-key-setup-side-window-right-bottom)
    ))


(use-package highlight-symbol
  :ensure t
  :config
  (progn
    (define-key global-map (kbd "M-H") 'highlight-symbol-at-point)
    (define-key global-map (kbd "M-N") 'highlight-symbol-next)
    (define-key global-map (kbd "M-P") 'highlight-symbol-prev)
    )
  )

(use-package ivy
  :defer t
  :ensure t
  :init
  (progn
	(ivy-mode 1)
	(global-unset-key (kbd "M-i"))
	(setq ivy-use-virtual-buffers t)
	(setq enable-recursive-minibuffers t)
	)
  :bind (("M-i s" . swiper)
		 ("M-i r" . ivy-resume)
		 ("M-i x" . counsel-M-x)
		 ("M-i f" . counsel-find-file)
		 ("M-i g" . counsel-git)
		 ("M-i l" . counsel-locate)
		 )
  )
				

(use-package helm
  :diminish helm
  :defer t
  :ensure t
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.1 ;0.01  ; this actually updates things
                                        ; reeeelatively quickly.
		  helm-cycle-resume-delay 2
		  helm-follow-input-idle-delay 1
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (global-unset-key (kbd "M-h"))
    (helm-mode)
    (define-key helm-map (kbd "C-r") 'helm-follow-action-backward)
    (define-key helm-map (kbd "C-s") 'helm-follow-action-forward)
    (define-key helm-map (kbd "C-'") 'ace-jump-helm-line)
    ;; When doing isearch, hand the word over to helm-swoop
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

    (custom-set-variables
     '(helm-follow-mode-persistent t))
     )
  :bind  (("M-h m" . helm-mini)
         ("M-h a" . helm-apropos)
;         ("C-x C-b" . helm-buffers-list)
         ("C-x b" . helm-buffers-list)
         ("M-y" . helm-show-kill-ring)
         ("M-x" . helm-M-x)
         ("M-h o" . helm-occur)
         ("M-h s" . helm-swoop)
         ("M-h y" . helm-yas-complete)
         ("M-h Y" . helm-yas-create-snippet-on-region)
         ("M-h M" . helm-all-mark-rings)
	 ("M-h b" . helm-bookmarks)
	 ("M-h j" . ace-jump-helm-line)
	 ("M-h i" . helm-imenu)
	 ("M-h e" . helm-semantic-or-imenu)
	 ("M-h f" . helm-find-files)
	 ("M-h p" . helm-projectile)
	 ("M-h q" . helm-swoop-back-to-last-point)
	 ("M-h g" . rgrep)
	 ("M-h d" . helm-do-ag)
	 ("M-h r" . helm-resume)
	 )
  )


(use-package helm-ag
  :ensure t
  :config
  (progn
	(setq helm-ag-fuzzy-match t
		  helm-ag-use-temp-buffer t
		  )
	)
  )
	
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; this is my preferred buffer list behavior over helm. this is actually what i had been using before helm. not list-buffers in fact, was buffer-menu

(defun whack-whitespace (arg)
      "Delete all white space from point to the next word.  With prefix ARG
    delete across newlines as well.  The only danger in this is that you
    don't have to actually be at the end of a word to make it work.  It
    skips over to the next whitespace and then whacks it all to the next
    word."
      (interactive "P")
      (let ((regexp (if arg "[ \t\n]+" "[ \t]+")))
        (re-search-forward regexp nil t)
        (replace-match "" nil nil)))
(global-set-key (kbd "M-h SPC") 'whack-whitespace)


(use-package helm-descbinds
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds)))

(use-package projectile
  :ensure t
  :config
  (progn
    (projectile-mode)
    )
  )

(use-package helm-projectile
  :ensure t
  :config
  (progn
    (helm-projectile-on)
    )
  )


;; (use-package color-theme
;;    :init (color-theme-initialize)
;;    :config (color-theme-vim-colors)
;;    )

 (use-package avy
   :ensure t

   :config
   (progn
     (global-set-key (kbd "M-g c") 'avy-goto-char)
     (global-set-key (kbd "S-SPC") 'avy-goto-line)
	 (global-set-key (kbd "M-s") 'avy-goto-char-timer)
	 (global-set-key (kbd "M-g w") 'avy-goto-word-1)
	 )
   )


;; (use-package ace-jump-mode
;;   :ensure t

;;   :config
;;   (progn
;;     (global-set-key (kbd "M-s") 'ace-jump-char-mode)
;;     (global-set-key (kbd "S-SPC") 'ace-jump-line-mode)
;;     ))


;; (use-package ace-window
;;   :ensure t
;;   :defer t
;;   :config (global-set-key (kbd "M-p") 'ace-window))


(use-package evil
  :ensure t
  :defer t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    (setq evil-toggle-key "C-`")
	(evil-mode 1)
	;; leader shortcuts

    ;; This has to be before we invoke evil-mode due to:
    ;; https://github.com/cofi/evil-leader/issues/10
    ;; (use-package evil-leader
    ;;   :config
    ;;   (progn
    ;;     (setq evil-leader/in-all-states t)
    ;;     (setq evil-leader/set-leader "<SPC>")
    ;;     ;; keyboard shortcuts
    ;;     (evil-leader/set-key
	;;   "b" 'helm-buffer-list
	;;   "eb" 'eval-buffer
	;;   "f" 'ido-find-file
	;;   "g" 'magit-status
	;;   "j" 'ace-jump-char-mode
	;;   "k" 'kill-buffer
	;;   "K" 'kill-this-buffer
	;;   "o" 'helm-occur
	;;   "r" 'recentf-open-files
	;;   "s" 'helm-swoop
	;;   "w" 'save-buffer
	;;   "y" 'helm-show-kill-ring
	;;   "<SPC>" 'ace-jump-line-mode
    ;;   "e"   'flycheck-list-errors

	;;  )
	;;)
     ;; )

    ;; boot evil by default
    ;;(evil-mode 1))
	)
  :config
  (progn
    (setq evil-emacs-state-cursor '("red" box))
    (setq evil-normal-state-cursor '("green" box))
    (setq evil-visual-state-cursor '("orange" box))
    (setq evil-insert-state-cursor '("red" bar))
    (setq evil-replace-state-cursor '("red" bar))
    (setq evil-operator-state-cursor '("red" hollow))
    ;; use ido to open files
    (define-key evil-ex-map "e " 'ido-find-file)
    (define-key evil-ex-map "b " 'ido-switch-buffer)

    (setq
     ;; h/l wrap around to next lines
     evil-cross-lines t
     ;; Training wheels: start evil-mode in emacs mode
     evil-default-state 'emacs)

    ;; esc should always quit: http://stackoverflow.com/a/10166400/61435
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
    (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)

    ;; modes to map to different default states
    (dolist (mode-map '((comint-mode . emacs)
                        (term-mode . emacs)
                        (eshell-mode . emacs)
                        (help-mode . emacs)
                        (fundamental-mode . emacs)))
      (evil-set-initial-state `,(car mode-map) `,(cdr mode-map))
      )
    (evil-define-key 'normal flycheck-mode-map (kbd "]e") 'flycheck-next-error)
    (evil-define-key 'normal flycheck-mode-map (kbd "[e") 'flycheck-previous-error)
    

    )
  )

(use-package ido
  :ensure t
  :defer t
  :init (progn (ido-mode 1)
               (ido-everywhere 1))
  :config
  (progn
    (setq ido-case-fold t)
    (setq ido-everywhere t)
    (setq ido-enable-prefix nil)
    (setq ido-enable-flex-matching t)
    (setq ido-create-new-buffer 'prompt)
    (setq ido-max-prospects 10)
    (setq ido-use-faces nil)
	(setq ido-auto-merge-work-directories-length -1)
    (setq ido-file-extensions-order '(".org" ".c" ".tex" ".py" ".emacs" ".el" ".ini" ".cfg" ".cnf"))
    (add-to-list 'ido-ignore-files "appspec.yml")))

(use-package anzu
  :defer t
  :commands (isearch-foward isearch-backward)
  :config
  (progn
    (global-anzu-mode)
    (global-set-key [remap query-replace] 'anzu-query-replace)
    (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp)
    (global-set-key [remap isearch-query-replace] 'anzu-isearch-query-replace)
    (global-set-key [remap isearch-query-replace-regexp] 'anzu-isearch-query-replace-regexp)
    
    )
  :bind
  (
   ("M-%" . anzu-query-replace)
   ("C-M-%" . anzu-query-replace-regexp)
   )
  )

(use-package breadcrumb
  ;:commands bc-set bc-previous bc-next bc-list bc-local-next bc-local-previous
  :bind (("C-c m" . bc-set)
	 ("M-j" . bc-previous)
	 ("S-M-j" . bc-next)
	 ("M-<up>" . bc-local-previous)
	 ("M-<down>" . bc-local-next)
	 ("C-c C-l" . bc-list)))

 (use-package undo-tree
   :defer t
   :diminish undo-tree-mode
   :config
   (progn
     (global-undo-tree-mode)
     (setq undo-tree-visualizer-timestamps t)
     (setq undo-tree-visualizer-diff t)))

;; (use-package guide-key
;;   :ensure t
;;   :defer t
;;   :diminish guide-key-mode
;;   :config
;;   (progn
;;   (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c"))
;;   (guide-key-mode 1)))  ; Enable guide-key-mode


(use-package python
   :defer t
   :ensure t
   :init
   (progn
     (setq python-shell-completion-native-enable nil)
     (setq-default py-split-windows-on-execute-function 'split-window-horizontally)
     (custom-set-variables
      '(py-shell-switch-buffers-on-execute nil))
     (add-hook 'python-mode-hook 'elpy-mode)
     (defun my/python-mode-hook ()
       (add-to-list 'company-backends 'company-jedi)
       )
     (add-hook 'python-mode-hook 'my/python-mode-hook)

     )
   )

 (use-package elpy
   :ensure t
    :defer t
    :config
    (progn
      (when (require 'flycheck nil t)
       (remove-hook 'elpy-modules 'elpy-module-flymake)
       (remove-hook 'elpy-modules 'elpy-module-yasnippet)
       (remove-hook 'elpy-mode-hook 'elpy-module-highlight-indentation)
       (add-hook 'elpy-mode-hook 'flycheck-mode))
      (diminish 'elpy-mode "elpy")
      (elpy-enable)
      (elpy-use-ipython)
      (setq elpy-rpc-backend "jedi")
      ))

 ;;if windows redefine M-TAB to TAB since M-TAB is used for switching applications
 (if (eq system-type 'windows-nt)
     (progn
       (add-hook 'elpy-mode-hook
 		(lambda ()
 		  (local-unset-key (kbd "M-TAB"))
 		  (define-key elpy-mode-map (kbd "<F5>") 'elpy-company-backend)))))

(use-package pyvenv
  :ensure t
  :defer t
  )


(use-package yasnippet
  :ensure t

  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-global-mode 1)
  )

(defun company-yasnippet-or-completion ()
  "Solve company yasnippet conflicts."
  (interactive)
  (let ((yas-fallback-behavior
         (apply 'company-complete-common nil)))
    (yas-expand)))

(add-hook 'company-mode-hook
          (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
	     company-active-map)))
;; above code works perfectly!!

 (defun indent-buffer ()
      (interactive)
      (save-excursion
        (indent-region (point-min) (point-max) nil)))
    (global-set-key [f12] 'indent-buffer)

(global-set-key "\C-x\\" 'indent-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cc-mode
  :ensure t
  :config
  (progn
	(setq c-default-style "bsd" c-basic-offset 4)
	)
  )

	 
;; Some bindings for hi-lock mode that will be very convenient for C code reading
(global-set-key (kbd "C-.") 'highlight-symbol-at-point)
(global-set-key (kbd "C->") 'highlight-phrase)
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c o") 'ff-find-other-file)
		
	    )
	  )
;; in addition to cmake to obtain compile_commands.json, should also
;; manually get a .clang_complete file in root folder of project include
;; "-I/.../" where /.../ is the folder structure, such as /src/,
;; /include/, /header/, etc. there could be multiple. This way the irony I/O
;; error will be gone, and function prototype can be auto completed 
(use-package irony
	:ensure t
	:init
	(progn
	  (add-hook 'c++-mode-hook 'irony-mode)
	  (add-hook 'c-mode-hook 'irony-mode)
	    )
	  )

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
	
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
	 
	 

(use-package company
  :ensure t

  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    
    (setq company-idle-delay nil
	  company-show-numbers t
	  company-async-timeout 50)
    (setq company-backends
	  '(company-irony
		company-gtags
	    )
	  )
    
    (setq company-backends (delete 'company-semantic company-backends))

  
;    (define-key company-active-map 'company-complete-common nil)
;    (define-key company-active-map "C-'" 'company-complete-common)
;    (define-key c-mode-map  [kbd "F5"] 'company-complete-common)
;    (define-key cmode-map  [kbd "F5"] 'company-complete-common)
  
    )
  )



(define-key c-mode-map  [(tab)] 'company-complete)
(define-key c++-mode-map  [(tab)] 'company-complete)
;;(eval-after-load 'company
;;  '(add-to-list 'company-backends 'company-irony))
(global-set-key (kbd "C-'") 'company-complete-common)


(use-package company-irony
  :ensure t
	   )

(use-package company-c-headers
  :ensure t
  :defer t
  :config
  (progn
    
    (add-to-list 'company-backends 'company-c-headers)
    )
  )

(use-package flycheck
	   :ensure t
       :bind (
              ("M-g M-n" . flycheck-next-error)
              ("M-g M-p" . flycheck-previous-error)
              ("M-g M-l" . flycheck-list-errors)
              )
       :init
       (require 'flycheck)
       (setq flycheck-indication-mode 'right-fringe
             flycheck-check-syntax-automatically '(save mode-enabled))
       :config
       (progn    

		 (add-hook 'c++-mode-hook 'flycheck-mode)
		 (add-hook 'c-mode-hook 'flycheck-mode)

       )
       )

(define-key flycheck-mode-map (kbd "<F7>") #'flycheck-list-errors)
(define-key flycheck-mode-map (kbd "<F8>")  #'flycheck-previous-error)
(define-key flycheck-mode-map (kbd "<F9>") #'flycheck-next-error)
        

(use-package helm-flycheck
  :ensure t
  :defer t
  :config
  (eval-after-load 'flycheck
    '(define-key flycheck-mode-map (kbd "M-h c") 'helm-flycheck)))

;; (defun setup-c-clang-options ()
;; 	(setq irony-additional-clang-options (quote ("-std=c11"))))

;; (defun setup-cpp-clang-options ()
;; (setq irony-additional-clang-options (quote ("-std=c++14" "-stdlib=libc++")))
;; )
	 

(use-package flycheck-irony
  :ensure t
  :defer t
	:config
	(eval-after-load 'flycheck
	  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup)
	  )
	)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
    ;; ;; irony-mode's buffers by irony-mode's asynchronous function
    ;; (defun my-irony-mode-hook ()
    ;;   (define-key irony-mode-map [remap completion-at-point]
    ;;     'irony-completion-at-point-async)
    ;;   (define-key irony-mode-map [remap complete-symbol]
    ;;     'irony-completion-at-point-async))
    ;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)

;; company-irony


;;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  

(use-package company-quickhelp
  :ensure t

  :config
  (company-quickhelp-mode 1)
  ;;(define-key company-quickhelp-mode-map (kbd "M-h") nil) ;unset this key in company-quickhelp-mode so that it does not conflict with helm mode
  )


  
(use-package company-jedi

  :ensure t)


;; ;; ;
;;  (use-package auto-complete
;;    :init
;;    (progn
;;      (auto-complete-mode t))
;;    :bind (("C-n" . ac-next)
;;  	  ("C-p" . ac-previous))
;;    :config
;;    (progn
;;      (use-package auto-complete-config)
;;      (ac-config-default))
;;    )

(use-package auto-complete
  :ensure t
  :init
  (progn
	(auto-complete-mode t))
  :config
  (progn
	(use-package auto-complete-config)
	(ac-config-default))
   
  )

(defun my-org-ac-hook ()
  (auto-complete-mode 1))

(add-hook 'org-mode-hook 'my-org-ac-hook)
  

;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                          (auto-complete-mode 1))
;;                        ))
;; (real-global-auto-complete-mode t)


  




(use-package ispell
  :ensure t
  :defer t
  :config
  (progn
    (setq-default ispell-program-name "aspell")
    (setq-default ispell-local-dictionary "american")
    (add-hook 'org-mode-hook 'flyspell-mode)
    
    (add-hook 'latex-mode-hook 'flyspell-mode)
    (add-hook 'tex-mode-hook 'flyspell-mode)
    (add-hook 'bibtex-mode-hook 'flyspell-mode)))

(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

(use-package org-bullets
  :defer t
  :config (setcdr org-bullets-bullet-map nil)
  )

(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))    


(require 'recentf)
(require 'calendar)

(use-package iedit
  :ensure t
  :defer t
  :init
  (global-set-key  (kbd "C-;") 'iedit-mode)
  ) ;; iedit can edit multiple occurrence at the same time.



(use-package imenu
  :ensure t
  :defer t
  :config
  (progn
    (setq imenu-auto-rescan t)
    (global-set-key (kbd "C-c i") 'imenu)
    (defun try-to-add-imenu ()
      (condition-case nil (imenu-add-to-menubar "iMenu") (error nil)))
    (add-hook 'font-lock-mode-hook 'try-to-add-imenu)
    ))

(which-function-mode 1)

(use-package linum
  :ensure t

  :config
  (progn
    (global-linum-mode 1)
    )
  )

(defun nolinum()
      (interactive)
      (message "Deactivated linum mode")
      (global-linum-mode 0)
      (linum-mode 0)
      )
    

;;(semantic-mode 1);keeps parsing repeatedly for large c files. 

 
(use-package helm-gtags
  :ensure t
  :init
  (progn
    (setq
     helm-gtags-ignore-case t
     helm-gtags-auto-update t
     helm-gtags-use-input-at-cursor t
     helm-gtags-pulse-at-cursor t
     helm-gtags-prefix-key "\C-cg"
     helm-gtags-suggested-key-mapping t
     ))
  :config
  (progn
    (add-hook 'dired-mode-hook 'helm-gtags-mode)
    (add-hook 'eshell-mode-hook 'helm-gtags-mode)
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)
    
    (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
    (define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
    (define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
    (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
    (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
    (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
    ))

(use-package cedet
  :defer t
  :ensure t)

;(require 'smart-compile)
(use-package smart-compile
  :ensure t
  :defer t
    
  )

; sementic seems to make the computer very slow
;; (use-package sementic
;;   :config
;;   (progn
;;     (global-semanticdb-minor-mode 1)
;;     (global-semantic-idle-scheduler-mode 1)
;;     (semantic-mode 1)
;; ))

;(use-package function-args;
;	:init 
;	(fa-config-default))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files t)

(setq version-control t ;; Use version numbers for backups
	 kept-new-versions 100 ;; Number of newest versions to keep
	 kept-old-versions 100 ;; Number of oldest versions to keep
	 delete-old-versions t ;; Ask to delete excess backup versions?
	)
	
	  
(defun force-backup-of-buffer ()
     (let ((buffer-backed-up nil))
       (backup-buffer)))
   (add-hook 'before-save-hook  'force-backup-of-buffer)
(setq initial-scratch-message "") ;; Uh, I know what Scratch is for
	

(when (window-system)
  (tool-bar-mode 0)               ;; Toolbars were only cool with XEmacs
  (when (fboundp 'horizontal-scroll-bar-mode)
    (horizontal-scroll-bar-mode -1))
  (scroll-bar-mode -1))            ;; Scrollbars are waste screen estate

 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key (kbd "<f12> h") ;; open Emacs home directory
;;   (lambda ()
;;     (interactive)
;;     (dired "~/")))

;; (global-set-key (kbd "<f12> w") ;; open Work directory
;;   (lambda ()
;;     (interactive)
;;     (dired "C:/Users/yliu193/Work")))

;; (global-set-key (kbd "<f12> n") ;; open Notes_Planning 
;;   (lambda ()
;;     (interactive)
;;     (dired "C:/Users/yliu193/Work/Notes_Planning")))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General Setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column most-positive-fixnum))
    (fill-paragraph)))

(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column most-positive-fixnum))
    (fill-region start end)))

(setq sentence-end-double-space nil)

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(global-set-key (kbd "C-c q") 'auto-fill-mode)
(setq stack-trace-on-error t)
(global-font-lock-mode t)
(show-paren-mode 1)
(setq auto-save-interal 50)
(setq auto-save-timeout 60)
(setq global-visual-line-mode t)
(setq visible-bell t)
(setq inhibit-startup-message t)

(setq show-paren-style 'parenthesis)
(setq blink-matching-paren t)

(setq column-number-mode t)
(setq line-number-mode t)


(setq kill-ring-max 200)
(mouse-avoidance-mode 'animate)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(transient-mark-mode t)

(setq default-fill-column 72)

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(display-time)



(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)

(setq-default mode-line-format
              '("  " mode-line-modified
                (list 'line-number-mode "  ")
                (:eval (when line-number-mode
                         (let ((str "L%l"))
                           (when (and (not (buffer-modified-p)) my-mode-line-buffer-line-count)
                             (setq str (concat str "/" my-mode-line-buffer-line-count)))
                           str)))
                "  %p"
                (list 'column-number-mode "  C%c")
                "  " mode-line-buffer-identification
                "  " mode-line-modes))

(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode Setting;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(org-agenda-to-appt)

(use-package org-journal
  :defer t
  :ensure t
  :init
  (setq org-journal-dir "~/work_journal")
  )


(setq org-latex-create-formula-image-program 'dvipng)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq default-major-mode 'org-mode)

(setq org-highlight-latex-and-related '(latex script entities))

(setq org-use-speed-commands 1)


(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")
(setq org-startup-indented 1)
(setq org-tags-column -100)
(setq org-icalendar-include-todo t) 

(setq org-todo-keywords
	  '((sequence "TODO(t)" "WAITING(w@)"  "REPORT(r)" "NEXTACTION(n)"  "INPROGRESS(p)" "TOFILE(f)"  "|" "DONE(d!)" "CANCELED(c@/i)" "MEMO(m)" "LOG(l)" )
		))

(setq org-todo-keyword-faces
	  '(("TODO" . org-warning) ("INPROGRESS" . "orange") ("MEMO" . "blue") ("LOG" . "blue") ("TOFILE" . org-warning) ("REPORT" . "cyan") ("NEXTACTION" . org-warning)
		("CANCELED" . (:foreground "blue" :weight bold))
		("DONE" . org-done) ("WAITING" . org-warning)))



(add-to-list 'org-emphasis-alist
			 '("*"  (:foreground "red")
			   ))

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

										;(add-hook 'org-mode-hook 'toggle_truncate_lines)


;;;;Org Capture
(setq org-capture-templates
      '(("t" "Todo" entry (file myprojectfile )
		 "* TODO %?\n  ")
        ("n" "Notes" entry (file myprojectfile)
		 "* %?\nEntered on %U\n  "))
	  )

										;(use-package org-ref
;;   :ensure t
;;   :config
;;   (progn
;; ;	(add-hook 'org-mode-hook 'org-ref)
;; 	(setq org-ref-notes-directory "~/References"
;; 		  org-ref-bibliography-notes "~/References/index.org"
;; 		  org-ref-default-bibliography '("~/References/index.bib")
;; 		  org-ref-pdf-directory "~/References/pdfs/"
;; 		 )
;; 	)
;;  )

;; (use-package helm-bibtex
;;   :ensure t
;;   :config
;;   (progn

;; 	(setq helm-bibtex-bibliography "~/References/index.bib" ;; where your references are stored
;; 		  helm-bibtex-library-path "~/References/lib/" ;; where your pdfs etc are stored
;; 	  helm-bibtex-notes-path "~/References/index.org" ;; where your notes are stored
;; 		  bibtex-completion-bibliography "~/References/index.bib" ;; writing completion
;; 		  bibtex-completion-notes-path "~/References/index.org"
;; 		  bibtex-completion-library-path "~/References/lib"
;; 		  )

;; 	)
;;   )



										;Org Clock 
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)
(setq org-clock-out-remove-zero-time-clocks t)


(setq org-agenda-skip-additonal-timestamps nil)
;; remove the \emsp symbols in the clock report table

(setq org-clock-history-length 23)
(setq org-clock-in-resume t)
										;(setq org-clock-persist t)
(setq org-clock-persist-query-resume t)
(setq org-clock-auto-clock-resolution #'when-no-clock-is-running)
(setq org-clock-report-include-clocking-task t)
(setq org-pretty-entities nil)

(setq org-clock-modeline-total #'current)


(defun my-org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str " "))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "--")))
      (concat str "-"))))

(advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)

(use-package org-pomodoro
  :ensure t
  :commands (org-pomodoro)
  :config
  (setq alert-user-configuration (quote ((((:category . "org-pomodoro")) libnotify nil)))))

(setq org-agenda-clockreport-parameter-plist 
	  '(:fileskip0 t :link t :maxlevel 2 :formula "$5=($3+$4)*(60/25);t"))


(setq org-log-done 'time)

(setq org-refile-targets 
	  '((nil :maxlevel . 6 )
		))


(defun open-notes ()
  (interactive)
  (find-file "C:/Users/yliu193/Notes/Notes.org")
  )

(defun open-projects ()
  (interactive)
  (find-file myprojectfile)
  )


(defun open-notes-projects ()
  (interactive)
  (split-window-horizontally)
  (open-projects)
  (other-window 1)
  (open-notes)
  )

(defun mark-tofile ()
  (interactive)
  (org-todo "TOFILE")
  )

(defun mark-nextaction ()
  (interactive)
  (org-todo "NEXTACTION")
  )

(defun mark-todo ()
  (interactive)
  (org-todo "TODO")
  )

(defun mark-done ()
  (interactive)
  (org-todo "DONE")
  )


(defun mark-memo ()
  (interactive)
  (org-todo "MEMO")
  )

(defun mark-log ()
  (interactive)
  (org-todo "LOG")
  )


(defun mark-waiting ()
  (interactive)
  (org-todo "WAITING")
  )

(defun mark-canceled ()
  (interactive)
  (org-todo "CANCELED")
  )

(defun mark-report ()
  (interactive)
  (org-todo "REPORT")
  )

(defun mark-inprogress ()
  (interactive)
  (org-todo "INPROGRESS")
  )
(defun show-nextaction ()
  (interactive)
  (setq current-prefix-arg 4)
  (call-interactively 'org-show-todo-tree))

(defun org-set-line-checkbox (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- [ ] ")
      (forward-line))
    (beginning-of-line)))

(defun org-back-to-top-level-heading ()
  "Go back to the current top level heading."
  (interactive)
  (or (re-search-backward "^\* " nil t)
      (goto-char (point-min))))

										;(defun show-nextaction-agenda ()
										;  (interactive)
										;  (setq 
										;  (org-agenda "N")
										;)

;; (defun show-nextaction 
;;       (let ((case-fold-search nil)
;;        (kwd-re  "\\<EXTACTION\\>"))
;;    (message "%d NEXTACTION entries found"
;;            (org-occur (concat "^" outline-regexp " +" kwd-re )))))


(defun show-done ()
  (interactive)
  (setq current-prefix-arg 7)
  (call-interactively 'org-show-todo-tree))

(defun show-report ()
  (interactive)
  (setq current-prefix-arg 3)
  (call-interactively 'org-show-todo-tree))

(defun show-inprogress ()
  (interactive)
  (setq current-prefix-arg 5)
  (call-interactively 'org-show-todo-tree))

(defun show-memo ()
  (interactive)
  (setq current-prefix-arg 9)
  (call-interactively 'org-show-todo-tree))

(defun show-log()
  (interactive)
  (setq current-prefix-arg 10)
  (call-interactively 'org-show-todo-tree))

(defun show-waiting ()
  (interactive)
  (setq current-prefix-arg 2)
  (call-interactively 'org-show-todo-tree))

(defun show-canceled ()
  (interactive)
  (setq current-prefix-arg 8)
  (call-interactively 'org-show-todo-tree))

(defun show-todo-keyword ()
  (interactive)
  (setq current-prefix-arg 1)
  (call-interactively 'org-show-todo-tree))

(defun run-infinite-macro ()
  (interactive)
  (setq current-prefix-arg 0)
  (call-interactively 'kmacro-end-and-call-macro))

(defun add-sublevel-todo ()
  (interactive)
  (org-insert-heading-respect-content)
  (org-do-demote)
  (mark-todo))

(defun add-sublevel-plainitem ()
  (interactive)
  (org-insert-heading-respect-content)
  (org-do-demote)
  )

(defun jtc-org-tasks-closed-in-month (&optional month year match-string)
  "Produces an org agenda tags view list of the tasks completed 
in the specified month and year. Month parameter expects a number 
from 1 to 12. Year parameter expects a four digit number. Defaults 
to the current month when arguments are not provided. Additional search
criteria can be provided via the optional match-string argument "
  (interactive)
  (let* ((today (calendar-current-date))
         (for-month (or month (calendar-extract-month today)))
         (for-year  (or year  (calendar-extract-year today))))
    (org-tags-view nil 
				   (concat
					match-string
					(format "+CLOSED>=\"[%d-%02d-01]\"" 
							for-year for-month)
					(format "+CLOSED<=\"[%d-%02d-%02d]\"" 
							for-year for-month 
							(calendar-last-day-of-month for-month for-year))))))

(defun jtc-tasks-last-month ()
  "Produces an org agenda tags view list of all the tasks completed
last month."
  (interactive)
  (let* ((today (calendar-current-date))
         (for-month (calendar-extract-month today))
         (for-year  (calendar-extract-year today)))
	(calendar-increment-month for-month for-year -1)
	(jtc-org-tasks-closed-in-month 
	 for-month for-year "TODO=\"DONE\"")))

(setq org-agenda-custom-commands
	  '(("w" todo "WAITING")
		("o" todo "MEMO")
		("l" todo "LOG")
		("n" todo "NEXTACTION")
		("t" todo "TODO")
		("i" todo "INPROGRESS")
		("F" "Tasks CLOSED Last Week" tags  (concat "CLOSED>=\"<-1w>\""))
		("f" "Tasks DONE Last Week" tags (concat "TODO=\"DONE\"" "+CLOSED>=\"<-1w>\""))
		("S" "Tasks CLOSED Last Month" tags (concat "CLOSED>=\"<-1m>\"")) ))

(setq org-agenda-start-with-follow-mode 1)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)
   (emacs-lisp . t)
   (C . t)
   (dot . t)
   (latex . t)
   (lisp . t)
   (sh . t)
   (matlab . t)
   ))

 (use-package ox-latex
   :ensure nil
   )

 ;;   (add-to-list 'org-latex-classes
 ;; 			   '("beamer"
 ;; 				 "\\documentclass\[presentation\]\{beamer\}"
 ;; 				 ("\\section\{%s\}" . "\\section*\{%s\}")
 ;; 				 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
 ;; 				 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}"))))


 (use-package ox-beamer
   :ensure nil
   :config
   (add-to-list 'org-latex-classes
  			   '("beamer"
  				 "\\documentclass\[dvipdfmx,presentation\]\{beamer\}"
  				 ("\\section\{%s\}" . "\\section*\{%s\}")
  				 ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
  				 ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}"))))

   
;; End of org setting

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LaTeX Setting (Windows)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq TeX-auto-save t)
(setq TeX-parse-self t)

(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
				'("ps2pdf" "ps2pdf %f" TeX-run-command nil t) t)
  )

(use-package preview
  :ensure auctex
  :commands LaTeX-preview-setup
  :defer t
  :config
  (progn
    (define-key LaTeX-mode-map (kbd "<f12>") 'preview-buffer)
    (set-default 'preview-scale-function 1.4)
    )
  )

;(add-hook 'LaTeX-mode-hook 'latex-preview-pane-mode) ;;enable preview pane with all latex files
;(add-hook 'auto-save-hook 'latex-preview-pane-update)

(setq TeX-source-specials-mode 1)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)

(autoload 'cdlatex-mode "cdlatex" "CDLaTeX Mode" t)
(autoload 'turn-on-cdlatex "cdlatex" "CDLaTeX Mode" nil)
(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)   ; with AUCTeX LaTeX mode

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-start-server t)
;;(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-method 'source-specials)
;;(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'reftex-mode) 

(setq reftex-ref-macro-prompt nil)
(setq reftex-insert-label-flags '("s" "sfte"))
(defvar my-LaTeX-no-autofill-environments
  '("equation" "equation*")
  "A list of LaTeX environment names in which `auto-fill-mode' should be inhibited.")

(defun my-LaTeX-auto-fill-function ()
  "This function checks whether point is currently inside one of
the LaTeX environments listed in
`my-LaTeX-no-autofill-environments'. If so, it inhibits automatic
filling of the current paragraph."
  (let ((do-auto-fill t)
        (current-environment "")
        (level 0))
    (while (and do-auto-fill (not (string= current-environment "document")))
      (setq level (1+ level)
            current-environment (LaTeX-current-environment level)
            do-auto-fill (not (member current-environment my-LaTeX-no-autofill-environments))))
    (when do-auto-fill
      (do-auto-fill))))

(defun my-LaTeX-setup-auto-fill ()
  "This function turns on auto-fill-mode and sets the function
used to fill a paragraph to `my-LaTeX-auto-fill-function'."
  (auto-fill-mode)
  (setq auto-fill-function 'my-LaTeX-auto-fill-function))

(add-hook 'LaTeX-mode-hook 'my-LaTeX-setup-auto-fill)
(add-hook 'LaTeX-mode-hook
		  (lambda () (local-set-key (quote [f9]) #'LaTeX-indent-line)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matlab setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (if (eq system-type 'windows-nt)
;; 	(eval-after-load 'matlab
;; 	  '(progn
;; 		 (add-to-list
;; 		  'auto-mode-alist
;; 		  '("\\.m$" . matlab-mode))
;; 		 (setq matlab-indent-function t)

;; 										; (add-hook 'matlab-mode 'auto-complete-mode)
;; 		 (add-hook 'matlab-mode-hook 'ace-jump-mode)
;; 		 (define-key matlab-mode-map (kbd "M-s") nil)
;; 		 (setq matlab-shell-command "c:\matlabshell\matlabshell.cmd")
;; 		 (setq matlab-shell-command-switches '())
;; 		 (setq matlab-shell-echoes nil)
;; 		 ))
;;   )
										;
;; Octave Mode

(use-package octave
  :ensure t
  :config
  (progn
	(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
	(setq octave-auto-indent t)
	(setq octave-auto-newline t)
	(setq octave-blink-matching-block t)
	(setq octave-block-offset 4)
	(setq octave-continuation-offset 4)
	(setq octave-continuation-string "\\")
	(setq octave-mode-startup-message t)
	(setq octave-send-echo-input t)
	(setq octave-send-line-auto-forward t)
	(setq octave-send-show-buffer t)
	

			)
		  )
(add-hook 'octave-mode-hook
		  (lambda ()
			(auto-complete-mode 1)
			(setq comment-start "% ")
			)
		  )

  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Key bindings;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun jump-back-local-mark ()
  (interactive)
  (setq current-prefix-arg 1)
  (call-interactively 'set-mark-command)
  )

(defun jump-to-today-report ()
  "call jump to bookmark function to go to today's clock table"
  (interactive)
  (bookmark-maybe-load-default-file)
  
  (bookmark-jump "ClockReportToday")
  (message "Went to today's clock report."))

(with-eval-after-load "org"
  (progn
	;; (add-hook 'org-mode-hook 'nolinum)
	(add-hook 'org-mode-hook #'visual-line-mode)
    (define-key org-mode-map (kbd "<C-f1>") nil)
    (define-key org-mode-map (kbd "M-h") nil)
	;;F1
	;;(define-key org-mode-map (kbd "C-<f1>") 'org-back-to-top-level-heading)
	;;F5
	(define-key org-mode-map (kbd "<f5> n") 'mark-nextaction)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)	
	(define-key org-mode-map (kbd "<f5> f") 'mark-tofile)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)
	(define-key org-mode-map (kbd "<f5> d") 'mark-done)
	(define-key org-mode-map (kbd "<f5> m") 'mark-memo)
	(define-key org-mode-map (kbd "<f5> l") 'mark-log)
	(define-key org-mode-map (kbd "<f5> w") 'mark-waiting)
	(define-key org-mode-map (kbd "<f5> c") 'mark-canceled)
	(define-key org-mode-map (kbd "<f5> p") 'mark-inprogress)
	(define-key org-mode-map (kbd "<f5> i") 'mark-inprogress)
	(define-key org-mode-map (kbd "<f5> r") 'mark-report)
	(define-key org-mode-map (kbd "C-<f5>") 'org-time-stamp-inactive)
	;; F6
	(define-key org-mode-map (kbd "<f6> n") 'show-nextaction)
	(define-key org-mode-map (kbd "<f6> p") 'show-inprogress)
	(define-key org-mode-map (kbd "<f6> i") 'show-inprogress)
	(define-key org-mode-map (kbd "<f6> m") 'show-memo)
		(define-key org-mode-map (kbd "<f6> l") 'show-log)
	(define-key org-mode-map (kbd "<f6> w") 'show-waiting)
	(define-key org-mode-map (kbd "<f6> c") 'show-canceled)
	(define-key org-mode-map (kbd "<f6> d") 'show-done)
	(define-key org-mode-map (kbd "<f6> r") 'show-report)
	(define-key org-mode-map (kbd "<f6> t") 'show-todo-keyword)
	(define-key org-mode-map (kbd "M-<f6>") (kbd "C-c a n"))
	(define-key org-mode-map (kbd "<f6> L") 'jtc-tasks-last-month)
	;;F7
	(define-key org-mode-map (kbd "<f7>") 'org-cut-special)
	(define-key org-mode-map (kbd "S-<f7>") 'org-insert-drawer)
	(define-key org-mode-map (kbd "C-<f7>") 'org-archive-subtree)
	(define-key org-mode-map (kbd "M-<f7>") 'org-toggle-archive-tag)
	;;F8
	(define-key org-mode-map (kbd "<f8>") 'add-sublevel-plainitem);'add-sublevel-todo)

	;;F9
	(define-key org-mode-map (kbd "<f9> i") 'org-clock-in)
	(define-key org-mode-map (kbd "<f9> o") 'org-clock-out)
	(define-key org-mode-map (kbd "<f9> j") 'org-clock-goto)
	(define-key org-mode-map (kbd "<f9> q") 'org-clock-cancel)
	(define-key org-mode-map (kbd "<f9> d") 'org-clock-display)
	(define-key org-mode-map (kbd "<f9> r") 'org-clock-report)
	(define-key org-mode-map (kbd "<f9> l") 'org-clock-in-last)
	(define-key org-mode-map (kbd "<f9> x") 'org-clock-select-task)
	(define-key org-mode-map (kbd "<f9> s") 'org-resolve-clocks)
	(define-key org-mode-map (kbd "<f9> a") 'org-update-all-dblocks)

	(define-key org-mode-map (kbd "<f9> p") 'org-pomodoro)
	(define-key org-mode-map (kbd "<f9> k")	'org-pomodoro-kill)

	
	(define-key org-mode-map (kbd "C-<f12>") 'org-overview)
	(define-key org-mode-map (kbd "M-<f12>") 'org-forward-same-level)
	(define-key org-mode-map (kbd "S-<f12>") 'outline-next-visible-heading )
	(define-key org-mode-map (kbd "C-<f11>") 'org-copy)
	(define-key org-mode-map (kbd "M-<f11>") 'org-backward-same-level)
	(define-key org-mode-map (kbd "S-<f11>") 'outline-previous-visible-heading)
	(define-key org-mode-map (kbd "C-c a") 'org-agenda)
	(define-key org-mode-map (kbd "C-c b") 'org-iswitchb)
	(define-key org-mode-map (kbd "C-c l") 'org-store-link)
	(define-key org-mode-map (kbd "C-S-n") 'outline-next-visible-heading )
	(define-key org-mode-map (kbd "C-S-p") 'outline-previous-visible-heading )
	(define-key org-mode-map (kbd "C-S-b") 'org-backward-same-level )
	(define-key org-mode-map (kbd "C-S-f") 'org-forward-same-level )
	(define-key org-mode-map (kbd "C-S-w") 'org-cut-subtree)
	(define-key org-mode-map (kbd "C-S-u") 'outline-up-heading)
	(define-key org-mode-map (kbd "S-<f9>") 'org-shiftmetaup)
	(define-key org-mode-map (kbd "M-<f9>") 'org-shiftmetadown)
	(define-key org-mode-map (kbd "<f9> t") 'jump-to-today-report)
	
	) )
(add-hook 'org-agenda-mode-hook
      (lambda()
        (define-key org-agenda-mode-map
          (kbd "RET") (lambda () (interactive) (org-agenda-switch-to t)))))
(setq org-hide-emphasis-markers t)
;;Global Key Bindings;;

;;;;;;;
;; F1
;;;;;;;


;;;;;;;
;; F2
;;;;;;;


;;;;;;;
;; F3
;;;;;;;
(defmacro defkbalias (old new)
  `(define-key (current-global-map) ,new
     (lookup-key (current-global-map) ,old)))

;; now "C-x -" equals to "C-x 2"
;;(defkbalias (kbd "C-x 2") (kbd "C-x -"))
(defkbalias (kbd "C-x C-k") (kbd "C-<f3>")) ; use C-F3 as kmacro pefix


;;;;;;;
;; F4
;;;;;;;

(global-set-key (kbd "M-<f4>") 'apply-macro-to-region-lines)
(global-set-key (kbd "S-<f4>") 'run-infinite-macro)



;;;;;;;
;; F5
;;;;;;;



;;;;;;;
;; F6
;;;;;;;


;;;;;;;;
;; F7
;;;;;;;;


;;;;;;;;;
;; F8
;;;;;;;;
(global-set-key (kbd "C-<f8>") 'narrow-to-region)
(global-set-key (kbd "S-<f8>") 'widen)
(global-set-key (kbd "M-<f8>") 'narrow-to-defun)

;;;;;;;;;
;; F9
;;;;;;;;

;;;;;;;;
;; F10
;;;;;;;;

(global-set-key (kbd "<f10>") 'nolinum)

;;;;;;;;
;; F11
;;;;;;;;

(global-set-key (kbd "<f11>") 'replace-regexp)


;;;;;;;;
;; F12
;;;;;;;;

(global-set-key (kbd "<f12>") 'smart-compile)

;;;;;;;;
;; Others
;;;;;;;;

(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-x z") 'repeat-complex-command)
(global-set-key (kbd "C-z")  'set-mark-command)
;(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)


(global-set-key (kbd "M-<backspace>") (lambda ()
								(interactive)
								(kill-line 0)
								(indent-according-to-mode)))



(global-set-key (kbd "C-/") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "C-1") 'jump-back-local-mark) ;jump back mark in local mark ring
(global-set-key (kbd "C-2") 'pop-global-mark) ; jump back to global mark ring



(defun unpop-to-mark-command ()
  "Unpop off mark ring. Does nothing if mark ring is empty."
  (interactive)
  (when mark-ring
	(let ((pos (marker-position (car (last mark-ring)))))
	  (if (not (= (point) pos))
		  (goto-char pos)
		(setq mark-ring (cons (copy-marker (mark-marker)) mark-ring))
		(set-marker (mark-marker) pos)
		(setq mark-ring (nbutlast mark-ring))
		(goto-char (marker-position (car (last mark-ring))))))))

(global-set-key (kbd "C-3") 'unpop-to-mark-command)
(global-set-key (kbd "C-0") (lambda () (interactive) (push-mark-command nil nil)));

;(global-set-key (kbd "C-0") (lambda() (interactive) (push-mark nil nil 1)))
(global-set-key (kbd "C-+") (kbd "C-u C-_")) ; redo
(global-set-key (kbd "C-c o") 'occur)

(global-set-key (kbd "C-M-m") 'delete-minibuffer-contents)

(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(put 'upcase-region 'disabled nil)

(put 'narrow-to-region 'disabled nil)

(defun ridm ()
  "Remove intrusive CTRL-Ms from the buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-string "\C-m\C-j" "\C-j")))

