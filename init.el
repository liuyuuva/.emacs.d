(require 'package)
;; Avoid multiple initialization of installed packages.

(setq package-enable-at-startup nil)
;; Add Melpa to the list of package archives.
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "https://jorgenschaefer.github.io/packages/"))
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/"))

(add-to-list 'load-path "~/.emacs.d/elpa/pyvenv-1.9")
;; Do package initiazation.
(package-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(if (eq system-type 'windows-nt)
    (progn
;;      	(let ((default-directory "C:/Users/523452/Work/"))
;;		  (normal-top-level-add-subdirs-to-load-path))
		(add-to-list 'backup-directory-alist  '("." . "~/.emacs.d/backup/"))
		(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
		(setq default-directory "C:/Users/523452/Work/")
		(add-to-list 'exec-path "c:/msys64/mingw64/bin/") ; have to use hunspell as emacs 26 cannot support aspell < v6, but aspell v6 for w64 is nowhere to find.
										;(setq ispell-dictionary "C:/bin//Aspell/dict/")
;		(add-to-list 'exec-path "~/.emacs.d/ccls/")
		(setq my_org_main_file "C:/Users/523452/Work/org/main.org")
		(setq my_org_capture_file "C:/Users/523452/Work/org/main.org")
        (setq my_org_memo_file "C:/Users/523452/Work/org/memo.org")
		;;(setq my_org_journal_file "~/Dropbox/0_Journal/journal.org")
		(setq my_org_meeting_notes_file "c:/Users/523452/Work/org/main.org")
		(setq org_directory "c:/Users/523452/Work/org/")
		(setq my_python_command "c:/Users/523452/bin/Anaconda3/python.exe")
        (setq my_ipython_path "c:/Users/523452/bin/Anaconda3/Scripts/ipython.exe")
		;;	(add-to-list 'exec-path "c:/cygwin64/bin") ;; Added for ediff function
		(add-to-list 'exec-path "c:/msys64/mingw64/bin");; added for clang
		(add-to-list 'exec-path "c:/msys64/usr/bin");;added for find.exe and grep.exe
		;;(add-to-list 'exec-path "c:/bin/glo656wb/bin");; for global.exe
		;;(add-to-list 'exec-path "C:/Users/523452/bin/Anaconda3/Scripts")
		(setq preview-gs-command "gswin64c")
		(setq doc-view-ghostscript-program "gswin64c")
		(set-fontset-font t 'han (font-spec :family "Microsoft Yahei" :size 12))
		(setq face-font-rescale-alist '(("Microsoft Yahei" . 1.2) ("WenQuanYi Zen Hei" . 1.2)))
		(prefer-coding-system 'utf-8-unix)
		;(pdf-tools-install)
		)
  )

(if (eq system-type 'darwin)
  (progn
    (let ((default-directory "~/"))
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
			  ("english" ,@default)
			  )
			)
		  )
	(setq my_org_main_file "~/Dropbox/org/personal_main.org")
	(setq my_org_capture_file "~/Dropbox/org/personal_capture.org")
	(setq my_org_memo_file "~/Dropbox/org/personal_memo.org")
	(setq my_org_journal_file "~/Dropbox/org/personal_journal.org")
	(setq my_org_meeting_notes_file "~/Dropbox/org/personal_meeting_notes.org")
	(setq org_directory "~/Dropbox/org/")
	)
;With the above apsell config for mac os, i also edited
;/usr/local/etc/aspell.conf to change the string after "dict-dir" to
;"/Library/Application Support/cocoAspell/aspell6-en-6.0-0". Flyspell
;mode now works fine.
    )
  

(if (eq system-type 'gnu/linux)
    (progn
      (let ((default-directory "~/"))
	  (normal-top-level-add-subdirs-to-load-path))
    (add-to-list 'backup-directory-alist  '("." . "~/.emacs.d/backup/"))
    (setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
	(setq my_org_main_file "~/Dropbox/org/personal_main.org")
	(setq my_org_capture_file "~/Dropbox/org/personal_capture.org")
	(setq my_org_memo_file "~/Dropbox/org/personal_memo.org")
	(setq my_org_journal_file "~/Dropbox/org/personal_journal.org")
	(setq my_org_meeting_notes_file "~/Dropbox/org/personal_meeting_notes.org")
	(setq org_directory "~/Dropbox/org/")
	(setq my_ipython_path "/usr/local/bin/ipython")
	;;(pdf-tools-install)
	;;(setq-default ispell-program-name "aspell")
	;;(setq-default ispell-local-dictionary "american")
    )
  )


(set-language-environment "UTF-8")
(global-set-key (kbd "C-M-!") 'save-buffers-kill-emacs)
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
;;(winner-mode 1) ;save window configuration



;; Install use-package.  It is the only one explicitly installed, all the others
;; are automatically installed using the :ensure property of use-package.
(unless   (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;(if (eq system-type 'windows-nt)
;    (require 'benchmark-init)
;  )


(setq use-package-verbose nil)
(defalias 'yes-or-no-p 'y-or-n-p)
;; open recent directory, requires ivy (part of swiper)
;; borrows from http://stackoverflow.com/questions/23328037/in-emacs-how-to-maintain-a-list-of-recent-directories


 (use-package benchmark-init
   :ensure t
   :config
    (add-hook 'after-init-hook 'benchmark-init/deactivate))

(use-package winner
  :defer t
  )

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

(save-place-mode 1)

;; (use-package bookmark
;;   :ensure t
;;   :defer t
;;   :config
;;   (progn
;;     (global-unset-key (kbd "<C-f1>"))
;;     (define-key global-map (kbd "<C-f1>") 'bookmark-set)
;;     (define-key global-map (kbd "<M-f1>") 'bookmark-jump)
;;     (define-key global-map (kbd "<S-f1>") 'bookmark-bmenu-list)
;;     ))

(use-package bm
  :ensure t
  :demand
  :init
  (setq bm-restore-repository-on-load t)
  (setq bm-repository-file "~/.emacs.d/.bm-repository")
  :bind
  ("<f2>" . hydra-bm/body)
  ("M-<f2>" . bm-next)
  ("C-<f2>" . bm-toggle)
  ("S-<f2>" . bm-previous)
  :config
  (progn
	(setq bm-cycle-all-buffers t)
	
	(setq-default bm-buffer-persistence t)
	(add-hook 'after-init-hook 'bm-repository-load)
	(add-hook 'find-file-hooks 'bm-buffer-restore)
	(add-hook 'kill-buffer-hook #'bm-buffer-save)
	(add-hook 'kill-emacs-hook #'(lambda nil
								   (bm-buffer-save-all)
								   (bm-repository-save)))
	;; (add-hook 'after-save-hook #'(lambda nil  ;; every time it autosaves, this will be run? comment out for now 
	;; 							   (bm-buffer-save)
	;; 							   (bm-repository-save)))
	
	(add-hook 'find-file-hooks   #'bm-buffer-restore)
	(add-hook 'after-revert-hook #'bm-buffer-restore)


	(defhydra hydra-bm (:color red :columns 4)
	  "bm mode"
	  ("s" bm-toggle "Set")
	  ("n" bm-next "Next")
	  ("p" bm-previous "Prev")
	  ("l" bm-show-all "list")
	  ("d" bm-remove-all-current-buffer "remove all")
	  ("q" nil "quit")
	  )
   )
  )

;; (use-package vlf
;;   :ensure t
;;   :defer t
;;   :config (progn
;;             (require 'vlf-setup)))

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
  :defer t
  :config
  (progn
    (setq mmm-global-mode 'maybe)
    (setq mmm-parse-when-idle 't)
    )
  )

(use-package magit
  :ensure t
  :defer t
  :bind
  ("C-x g" . magit-status)
   
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
	;;ido style folder navigation
	(define-key ivy-minibuffer-map (kbd "C-j") #'ivy-immediate-done)
	(define-key ivy-minibuffer-map (kbd "RET") #'ivy-alt-done)
	)
  :bind (("M-i s" . swiper)
		 ("M-i r" . ivy-resume)
		 ("M-i x" . counsel-M-x)
		 ("M-i f" . counsel-find-file)
		 ("M-i g" . counsel-git)
		 ("M-i l" . counsel-locate)
		 ("M-i a" . counsel-ag)
		 ("M-i m" . counsel-minibuffer-history)
		 )
  )

(use-package projectile
  :ensure t
  :defer t
  :diminish pjt
  :config
  (progn
    (projectile-mode)
    )
  )

(use-package helm-projectile
  :ensure t
  :defer t
  :config
  (progn
    (helm-projectile-on)
    )
  )


(defhydra hydra-projectile-other-window (:color teal)
  "projectile-other-window"
  ("f"  projectile-find-file-other-window        "file")
  ("g"  projectile-find-file-dwim-other-window   "file dwim")
  ("d"  projectile-find-dir-other-window         "dir")
  ("b"  projectile-switch-to-buffer-other-window "buffer")
  ("q"  nil                                      "cancel" :color blue))

(defhydra hydra-projectile (:color teal
                            :hint nil)
  "
     PROJECTILE: %(projectile-project-root)

     Find File            Search/Tags          Buffers                Cache
------------------------------------------------------------------------------------------
_f_: find file            _a_: ag                _i_: Ibuffer           _c_: cache clear
 _ef_: file dwim             _b_: switch to buffer  _x_: remove known project
 _hf_: file curr dir   _o_: multi-occur       _X_: cleanup non-existing
  _r_: recent file                                               ^^^^_z_: cache current
  _d_: dir

"
  ("a"   projectile-ag)
  ("b"   projectile-switch-to-buffer)
  ("c"   projectile-invalidate-cache)
  ("d"   projectile-find-dir)
  ("f" projectile-find-file)
  ("ef"  projectile-find-file-dwim)
  ("hf"  projectile-find-file-in-directory)
  ("i"   projectile-ibuffer)
  ("K"   projectile-kill-buffers)
  ("m"   projectile-multi-occur)
  ("o"   projectile-multi-occur)
  ("s"   projectile-switch-project)
  ("r"   projectile-recentf)
  ("x"   projectile-remove-known-project)
  ("X"   projectile-cleanup-known-projects)
  ("z"   projectile-cache-current-file)
  ("`"   hydra-projectile-other-window/body "other window")
  ("q"   nil "cancel" :color blue))

(defhydra elpy-nav-errors (:color red)
  "
  Navigate errors
  "
  ("n" next-error "next error")
  ("p" previous-error "previous error")
  ("s" (progn
         (switch-to-buffer-other-window "*compilation*")
         (goto-char (point-max))) "switch to compilation buffer" :color blue)
;  ("w" (venv-workon) "Workon venv…")
  ("q" nil "quit")
  ("Q" (kill-buffer "*compilation*") "quit and kill compilation buffer" :color blue)
)

(defhydra elpy-hydra (:color red)
 ; "
  ;Elpy in venv: %`venv-current-name
  ;"
  ("d" (progn (call-interactively 'elpy-test-django-runner) (elpy-nav-errors/body)) "current test, Django runner" :color blue)
  ("t" (progn (call-interactively 'elpy-test-pytest-runner) (elpy-nav-errors/body)) "current test, pytest runner" :color blue)
  ;("w" (venv-workon) "workon venv…")
  ("q" nil "quit")
  ("Q" (kill-buffer "*compilation*") "quit and kill compilation buffer" :color blue)
  )


(use-package helm
  :ensure t
  :defer t

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
    (define-key helm-map (kbd "C-'") 'ace--helm-line)
    ;; When doing isearch, hand the word over to helm-swoop
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

    (custom-set-variables
     '(helm-follow-mode-persistent t))

	(defun fu/helm-find-files-navigate-forward (orig-fun &rest args)
	  (if (and (equal "Find Files" (assoc-default 'name (helm-get-current-source)))
			   (equal args nil)
			   (stringp (helm-get-selection))
			   (not (file-directory-p (helm-get-selection))))
		  (helm-maybe-exit-minibuffer)
		(apply orig-fun args)))
	
	(advice-add 'helm-execute-persistent-action :around #'fu/helm-find-files-navigate-forward)
	(define-key helm-find-files-map (kbd "<return>") 'helm-execute-persistent-action)
	(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
	(defun fu/helm-find-files-navigate-back (orig-fun &rest args)
	  (if (= (length helm-pattern) (length (helm-find-files-initial-input)))
		  (helm-find-files-up-one-level 1)
		(apply orig-fun args)))
	(advice-add 'helm-ff-delete-char-backward :around #'fu/helm-find-files-navigate-back)
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
	 ("M-h d" . rg-dwim)
	 ("M-h r" . helm-resume)
     ("M-h c" . helm-flycheck)
	 ("M-h l" . helm-recentf)
	 ("M-h M-h" . helm-org-in-buffer-headings)
	 ("M-h t" . elpy-hydra/body)
	 ("M-h v" . rifle-hydra/body)
	 ("M-h u" . helm-multi-swoop-all)
	 ("M-h ." . rg)
	 ("M-h g" . helm-do-ag)
	 ("M-h n" . helm-org-in-buffer-headings)
	 )
  )

(global-set-key (kbd "C-x C-f") 'helm-find-files)
(use-package helm-org-rifle
  :defer t
  :ensure t)

(defhydra rifle-hydra (:exit t)
  "Org Rifle"
  ("r" helm-org-rifle "helm org rifle")
  ("b" helm-org-rifle-current-buffer "current buffer")
  ("d" helm-org-rifle-directories "diretories")
  ("f" helm-org-rifle-files "show results from files")
  ("h" helm-org-rifle-org-directory "show results from org-directory")
  ("a" helm-org-rifle-agenda-files "show results from agenda files")
  )

(use-package helm-swoop
  :ensure t
  :defer t
  )

(use-package helm-org
  :ensure t
  :defer t
  )

(use-package helm-ag
  :ensure t
  :defer t
  :config
  (progn
	(setq helm-ag-fuzzy-match t
		  helm-ag-use-temp-buffer t
		  )
	)
  )
	

(global-set-key (kbd "C-x C-b") 'ibuffer); trying ibuffer instead of buffer-menu

(use-package ibuffer
  :ensure t
  :config
  (progn
	(setq ibuffer-expert t) ; turn off prompt for killing every single time
	(setq ibuffer-show-empty-filter-groups nil)
	(define-ibuffer-column size-h
	  (:name "Size" :inline t)
	  (cond
	   ((> (buffer-size) 1000000) (format "%7.1fM" (/ (buffer-size) 1000000.0)))
	   ((> (buffer-size) 100000) (format "%7.0fk" (/ (buffer-size) 1000.0)))
	   ((> (buffer-size) 1000) (format "%7.1fk" (/ (buffer-size) 1000.0)))
	   (t (format "%8d" (buffer-size)))))
	
	;; Modify the default ibuffer-formats
	(setq ibuffer-formats
		  '((mark modified read-only " "
				  (name 18 18 :left :elide)
				  " "
				  (size-h 9 -1 :right)
				  " "
				  (mode 16 16 :left :elide)
				  " "
				  filename-and-process)))	
	(setq mp/ibuffer-collapsed-groups (list "Helm" "*Internal*"))

	(setq ibuffer-saved-filter-groups
		  (quote (("default"
				   ("dired" (mode . dired-mode))
				   ("org" (mode . org-mode))

				   ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
				   ("mu4e" (name . "\*mu4e\*"))
				   ("programming" (or
								   (mode . emacs-lisp-mode)
								   (mode . elisp-mode)
								   (mode . octave-mode)
								   (mode . cc-mode)
								   (mode . c-mode)
								   (mode . python-mode)
								   (mode . c++-mode)
								   (mode . rust-mode)
								   (name . "^\\*Compile-Log\\*$")
								   ))
				   ("emacs" (or
							 (name . "^\\*scratch\\*$")
							 (name . "^\\*Messages\\*$")
							 ))
					("Magit"  (or (name . "\\*magit-.*\\*")
								  (mode . magit-mode)))
					("Help" (or (name . "\*Help\*")
								(name . "\*Apropos\*")
								(name . "\*info\*")
								)
					 )
					 ("latex" (or (mode . latex-mode)
                      (mode . LaTeX-mode)
                      (mode . bibtex-mode)
                      (mode . reftex-mode)))
					)
				   )))

	(add-hook 'ibuffer-mode-hook
			  (lambda ()
				(ibuffer-auto-mode 1)
				(ibuffer-switch-to-saved-filter-groups "default")))


(setq ibuffer-show-empty-filter-groups nil)

	
	(defadvice ibuffer (after collapse-helm)
	  (dolist (group mp/ibuffer-collapsed-groups)
		(progn
		  (goto-char 1)
		  (when (search-forward (concat "[ " group " ]") (point-max) t)
			(progn
			  (move-beginning-of-line nil)
			  (ibuffer-toggle-filter-group)
			  )
			)
		  )
		)
	  (goto-char 1)
	  (search-forward "[ " (point-max) t)
	  )

	(ad-activate 'ibuffer)
	)
  
  )



(defhydra hydra-ibuffer-main (:color pink :hint nil)
  "
^Mark^         ^Actions^         ^View^          ^Select^              ^Navigation^
_m_: mark      _D_: delete       _g_: refresh    _q_: quit             _k_:   ↑    _h_
_u_: unmark    _s_: save marked  _S_: sort       _TAB_: toggle         _RET_: visit
_*_: specific  _a_: all actions  _/_: filter     _o_: other window     _j_:   ↓    _l_
_t_: toggle    _._: toggle hydra _H_: help       C-o other win no-select
"
  ("m" ibuffer-mark-forward)
  ("u" ibuffer-unmark-forward)
  ("*" hydra-ibuffer-mark/body :color blue)
  ("t" ibuffer-toggle-marks)

  ("D" ibuffer-do-delete)
  ("s" ibuffer-do-save)
  ("a" hydra-ibuffer-action/body :color blue)

  ("g" ibuffer-update)
  ("S" hydra-ibuffer-sort/body :color blue)
  ("/" hydra-ibuffer-filter/body :color blue)
  ("H" describe-mode :color blue)

  ("h" ibuffer-backward-filter-group)
  ("k" ibuffer-backward-line)
  ("l" ibuffer-forward-filter-group)
  ("j" ibuffer-forward-line)
  ("RET" ibuffer-visit-buffer :color blue)

  ("TAB" ibuffer-toggle-filter-group)

  ("o" ibuffer-visit-buffer-other-window :color blue)
  ("q" quit-window :color blue)
  ("." nil :color blue))

(defhydra hydra-ibuffer-mark (:color teal :columns 5
                              :after-exit (hydra-ibuffer-main/body))
  "Mark"
  ("*" ibuffer-unmark-all "unmark all")
  ("M" ibuffer-mark-by-mode "mode")
  ("m" ibuffer-mark-modified-buffers "modified")
  ("u" ibuffer-mark-unsaved-buffers "unsaved")
  ("s" ibuffer-mark-special-buffers "special")
  ("r" ibuffer-mark-read-only-buffers "read-only")
  ("/" ibuffer-mark-dired-buffers "dired")
  ("e" ibuffer-mark-dissociated-buffers "dissociated")
  ("h" ibuffer-mark-help-buffers "help")
  ("z" ibuffer-mark-compressed-file-buffers "compressed")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-action (:color teal :columns 4
                                :after-exit
                                (if (eq major-mode 'ibuffer-mode)
                                    (hydra-ibuffer-main/body)))
  "Action"
  ("A" ibuffer-do-view "view")
  ("E" ibuffer-do-eval "eval")
  ("F" ibuffer-do-shell-command-file "shell-command-file")
  ("I" ibuffer-do-query-replace-regexp "query-replace-regexp")
  ("H" ibuffer-do-view-other-frame "view-other-frame")
  ("N" ibuffer-do-shell-command-pipe-replace "shell-cmd-pipe-replace")
  ("M" ibuffer-do-toggle-modified "toggle-modified")
  ("O" ibuffer-do-occur "occur")
  ("P" ibuffer-do-print "print")
  ("Q" ibuffer-do-query-replace "query-replace")
  ("R" ibuffer-do-rename-uniquely "rename-uniquely")
  ("T" ibuffer-do-toggle-read-only "toggle-read-only")
  ("U" ibuffer-do-replace-regexp "replace-regexp")
  ("V" ibuffer-do-revert "revert")
  ("W" ibuffer-do-view-and-eval "view-and-eval")
  ("X" ibuffer-do-shell-command-pipe "shell-command-pipe")
  ("b" nil "back"))

(defhydra hydra-ibuffer-sort (:color amaranth :columns 3)
  "Sort"
  ("i" ibuffer-invert-sorting "invert")
  ("a" ibuffer-do-sort-by-alphabetic "alphabetic")
  ("v" ibuffer-do-sort-by-recency "recently used")
  ("s" ibuffer-do-sort-by-size "size")
  ("f" ibuffer-do-sort-by-filename/process "filename")
  ("m" ibuffer-do-sort-by-major-mode "mode")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(defhydra hydra-ibuffer-filter (:color amaranth :columns 4)
  "Filter"
  ("m" ibuffer-filter-by-used-mode "mode")
  ("M" ibuffer-filter-by-derived-mode "derived mode")
  ("n" ibuffer-filter-by-name "name")
  ("c" ibuffer-filter-by-content "content")
  ("e" ibuffer-filter-by-predicate "predicate")
  ("f" ibuffer-filter-by-filename "filename")
  (">" ibuffer-filter-by-size-gt "size")
  ("<" ibuffer-filter-by-size-lt "size")
  ("/" ibuffer-filter-disable "disable")
  ("b" hydra-ibuffer-main/body "back" :color blue))

(define-key ibuffer-mode-map "." 'hydra-ibuffer-main/body)

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
  :ensure t
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds)))



 (use-package avy
   :ensure t
   :config
   (progn
     (global-set-key (kbd "C-S-j") 'avy-goto-line)
	 (global-set-key (kbd "M-s") 'avy-goto-char-timer)
	 (global-set-key (kbd "C-/") 'avy-goto-char-timer)
	 (global-set-key (kbd "M-K") 'avy-goto-char-timer)
	 
	 )
   )

(defun yl/setup-key-chord ()
  (interactive)
  (use-package key-chord
	:ensure t
	:init
	(setq key-chord-two-keys-delay 0.2)
	(setq key-chord-one-key-delay 0.2)
	(key-chord-mode 1)
	:config
	(key-chord-define-local "jj" 'avy-goto-char-timer)
	(key-chord-define-local "hh" 'avy-goto-char-timer)
	(key-chord-define-local "ww" 'helm-swoop)
	(key-chord-define-local "bb" 'helm-swoop-back-to-last-point)
	(key-chord-define-local "qq" 'keyboard-quit)
	(key-chord-define-local "dm" 'delete-minibuffer-contents)
	(key-chord-define-local ";;" 'end-of-line)
	(key-chord-define-local "aa" 'beginning-of-line)
	(key-chord-define-local "zz" 'set-mark-command)
	;(key-chord-define "kk" 'hydra-smartparens/body)
	)
  )

(add-hook 'c-mode-hook 'yl/setup-key-chord)
(add-hook 'c++-mode-hook 'yl/setup-key-chord)
;; (add-hook 'emacs-lisp-mode-hook 'yl/setup-key-chord)
(add-hook 'python-mode-hook 'yl/setup-key-chord)
(add-hook 'org-mode-hook 'yl/setup-key-chord)


(global-unset-key (kbd "C-M-z"))

(defhydra hydra-zoom (global-map "C-M-z")
  "zoom in and out"
  ("i" text-scale-increase "in")
  ("o" text-scale-decrease "out")
  )
;; This has to be before we invoke evil-mode due to:
    ;; https://github.com/cofi/evil-leader/issues/10

(use-package evil
  :ensure t
  :defer t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    (setq evil-toggle-key "C-M-`")

	(use-package evil-leader
      :ensure t
      :init
      (progn
        (global-evil-leader-mode)
        (setq evil-leader/leader "<SPC>")
        )
      :config
      (progn
        
        (setq evil-leader/in-all-states t)
        
        ;; keyboard shortcuts
	(evil-leader/set-key
	  "b" 'helm-buffers-list
	   "f" 'helm-find-files
	   "g" 'magit-status
	   "j" 'avy-goto-char-timer
	   "k" 'kill-buffer
	   "K" 'kill-this-buffer
	   "o" 'helm-occur
	   "r" 'recentf-open-files
	   "s" 'helm-swoop
	   "w" 'save-buffer
	   "y" 'helm-show-kill-ring
	   "<SPC>" 'avy-goto-line
       "e"   'flycheck-list-errors
	   
	   )
	)
  )


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
    (eval-after-load 'evil-maps
	  '(define-key evil-normal-state-map (kbd "M-.") nil)) ;release M-. for helm-gtags-dwim
    (evil-mode 1)
    )
  )


(use-package anzu
  :ensure t
  :commands (isearch-forward isearch-backward)
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
  :demand t
  :bind (("<f1>" . hydra-breadcrumb/body)
		 ;("C-c m" . bc-set)
	 ;("M-j" . bc-previous)
	 ;("S-M-j" . bc-next)
	 ("M-<up>" . bc-previous)
	 ("M-<down>" . bc-next)
	;("C-c C-l" . bc-list)
	 )
  :config
  (defhydra hydra-breadcrumb (:color red :columns 4)
	"Breadcrumb"
	("s" bc-set "Set")
	("p" bc-previous "Prev")
	("n" bc-next "Next")
	("<up>" bc-local-previous "Local Prev")
	("<down>" bc-local-next "Local Next")
	("l" bc-list "List")
	("c" bc-clear "Clear")
	("q" nil "quit")
	)
  )

 (use-package undo-tree
   :ensure t
   :diminish undo-tree-mode
   :config
   (progn
	 (unbind-key "C-/" undo-tree-map)
     (global-undo-tree-mode)
     (setq undo-tree-visualizer-timestamps t)
     (setq undo-tree-visualizer-diff t)))
;;(global-unset-key (kbd "C-/"))


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
  :diminish elpy
  :ensure t
  :config
  (progn
	(when (require 'flycheck nil t)
	  (remove-hook 'elpy-modules 'elpy-module-flymake)
	  (remove-hook 'elpy-modules 'elpy-module-yasnippet)
	  (remove-hook 'elpy-mode-hook 'elpy-module-highlight-indentation)
	  (add-hook 'elpy-mode-hook 'flycheck-mode))
	(elpy-enable)
	(setq elpy-rpc-backend "jedi")
	;;(elpy-use-ipython my_ipython_path)
	(setq python-shell-interpreter "ipython"
		  python-shell-interpreter-args "-i --simple-prompt")
	
	(add-to-list 'company-backends 'elpy-company-backend)
	))

(if (eq system-type 'gnu/linux)
	(progn
	  (setq elpy-rpc-python-command "python3")
	  )
  )

 ;;if windows redefine M-TAB to TAB since M-TAB is used for switching applications
 (if (eq system-type 'windows-nt)
     (progn
	   (setq elpy-rpc-python-command my_python_command)
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
  :defer t
  :config
  
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (yas-global-mode 1)

  (defun company-yasnippet-or-completion ()
	"Solve company yasnippet conflicts."
	(interactive)
	(let ((yas-fallback-behavior
           (apply 'company-complete-common nil)))
      (yas-expand)))

  (define-key yas-keymap [tab] 'tab-complete-or-next-field)
  (define-key yas-keymap (kbd "TAB") 'tab-complete-or-next-field)
  (define-key yas-keymap [(control tab)] 'yas-next-field)
  (define-key yas-keymap (kbd "C-g") 'abort-company-or-yas)


  )


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
    ;(global-set-key [f12] 'indent-buffer)

(global-set-key "\C-x\\" 'indent-buffer)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cc-mode
  :ensure t
  :defer t
  :config
  (progn
    (setq-default c-basic-offset 4)
	(setq c-default-style "linux" c-basic-offset 4)
	)
  )

;;(use-package 'google-c-style
;;  :ensure t
;;  :defer t
;;  )
;;(add-hook 'c-mode-common-hook 'google-set-c-style)

(setq indent-tabs-mode nil)

(use-package yasnippet-snippets
  :ensure t
  :defer t
  )

	 
;; Some bindings for hi-lock mode that will be very convenient for C code reading
;;(global-set-key (kbd "C-.") 'highlight-symbol-at-point)
(global-set-key (kbd "C->") 'highlight-phrase)
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c o") 'ff-find-other-file)
		
	    )
	  )

(use-package counsel
  :ensure t
  :defer t
  )
	
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
	 
	 

(use-package company
  :ensure t
  :defer t
  :init
  (progn
	(setq company-global-modes '(not org-mode))
	)
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (setq company-idle-delay 0)
	)
  )

    


;;(global-set-key (kbd "C-'") 'company-complete-common)
(global-set-key (kbd "C-'") 'avy-goto-char-timer)



(use-package company-c-headers
  :ensure t
  :defer t
  :config
  (progn
	(add-to-list 'company-backends 'company-c-headers)
    )
  )



(use-package ccls
  :ensure t
  :defer t
  :hook (
	   (c-mode c++-mode) .
	   (lambda () (require 'ccls) (lsp)))
  :init
  (progn
	(if (eq system-type 'windows-nt)
		(setq ccls-executable "c:/Users/523452/bin/ccls/ccls.exe")
	  )
	(if (eq system-type 'gnu/linux)
		(setq ccls-executable "/snap/bin/ccls")
	  )
	)
  
  )
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(use-package helm-xref
  :ensure t
  :defer t
  :init (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  )


(use-package lsp-mode
  :ensure t
  :defer t
  :commands lsp
  :config
  (progn
	(setq lsp-prefer-flymake nil)
	)
  )

(setq xref-prompt-for-identifier '(not xref-find-definitions
                                            xref-find-definitions-other-window
                                            xref-find-definitions-other-frame
                                            xref-find-references))
(use-package lsp-ui
  :ensure t
  :defer t
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
		lsp-ui-doc-use-childframe t
		lsp-ui-doc-position 'top
		lsp-ui-doc-include-signature t
		lsp-ui-flycheck-enable t
		lsp-ui-flycheck-list-position 'right
		lsp-ui-flycheck-live-reporting t
		lsp-ui-peek-enable t
		lsp-ui-peek-list-width 60
		lsp-ui-peek-peek-height 25)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))



(use-package company-lsp
  :ensure t
  :defer t
  :commands company-lsp)

(use-package flycheck
  :ensure t
  :defer t
       :bind (
			  
			  ("M-p" . flycheck-previous-error)
			  ("M-n" . flycheck-next-error)
              )
       :init
       (require 'flycheck)
       (setq flycheck-indication-mode 'right-fringe
             flycheck-check-syntax-automatically '(save mode-enabled))
       :config
       (progn    

         (add-hook 'c++-mode-hook 'flycheck-mode)
;;		 (add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))
		 
		 (add-hook 'c-mode-hook 'flycheck-mode)

       )
       )

(define-key flycheck-mode-map (kbd "<F7>") #'flycheck-list-errors)
(define-key flycheck-mode-map (kbd "<F8>")  #'flycheck-previous-error)
(define-key flycheck-mode-map (kbd "<F9>") #'flycheck-next-error)
;(add-hook 'c++-mode-hook (lambda () (setq flycheck-gcc-language-standard "c++11")))        

(use-package helm-flycheck
  :ensure t
  :defer t
  :config
  (eval-after-load 'flycheck
    '(define-key flycheck-mode-map (kbd "M-h c") 'helm-flycheck)))


  

(use-package company-quickhelp
  :ensure t
  :defer t
  :config
  (company-quickhelp-mode 1)
  ;;(define-key company-quickhelp-mode-map (kbd "M-h") nil) ;unset this key in company-quickhelp-mode so that it does not conflict with helm mode
  )


  
(use-package company-jedi

  :ensure t
  :defer t
  )



  



(use-package ispell
  :ensure t
  :defer t
  :config
  (progn
    (add-hook 'org-mode-hook 'flyspell-mode)
    (add-hook 'latex-mode-hook 'flyspell-mode)
    (add-hook 'tex-mode-hook 'flyspell-mode)
    (add-hook 'bibtex-mode-hook 'flyspell-mode)
	(setq ispell-program-name (locate-file "hunspell"
										   exec-path exec-suffixes 'file-executable-p))
	(setq ispell-dictionary "english")
	(add-to-list 'ispell-local-dictionary-alist '(("english"
												   "[[:alpha:]]"
												   "[^[:alpha:]]"
												   "[']"
												   t
												   ("-d" "en_US")
												   nil
												   utf-8)))
	(setq ispell-hunspell-dictionary-alist ispell-local-dictionary-alist)
	  )
  )

	  
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq flyspell-issue-welcome-flag nil) ;; fix flyspell problem

	


(require 'calendar)

(use-package iedit
  :ensure t
  :defer t
  :init
  (global-set-key  (kbd "C-:") 'iedit-mode)
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


(defun nolinum()
      (interactive)
      (message "Deactivated linum mode")
      (global-linum-mode 0)
      (linum-mode 0)
      )
    
(defun yl/setup-semantic-mode ()
   (interactive)
   
   (use-package semantic
	 :ensure t
	 :defer t
	 :init
	 (semantic-mode 1)
	 :config
	 (progn
	   (setq semantic-idle-scheduler-idle-time 30)
	   (setq semantic-idle-scheduler-work-idle-time 120)
	   ;(setq semantic-idle-scheduler-max-buffer-size 150000) ;do not parse really large file
	  (setq semantic-default-submodes
			'(
			  global-semantic-idle-scheduler-mode
			  global-semanticdb-minor-mode
			  global-semantic-idle-summary-mode
			  global-semantic-stickyfunc-mode
			  global-semantic-idle-breadcrumbs-mode
			  global-semantic-mru-bookmark-mode
			  )
			)
	  )
	;; :bind
	;; (	("M-g c" . semantic-ia-describe-class)
	;; 	("M-g g" . semantic-ia-fast-jump)
	;; 	("M-g t" . semantic-ia-complete-tip)
	;; 	("M-g m" . semantic-ia-complete-symbol-menu)
	;; 	("M-g s" . semantic-ia-show-summary)
	;; 	("M-g b" . semantic-mrub-switch-tags)
	;; 	("M-g f" . semantic-force-refresh)
	;; 	("M-g y" . semantic-complete-analyze-inline)
		
	;; 	)
	 )
   )

(add-hook 'c-mode-hook 'yl/setup-semantic-mode)
(add-hook 'c++-mode-hook 'yl/setup-semantic-mode)
(add-hook 'emacs-lisp-mode-hook 'yl/setup-semantic-mode)
(add-hook 'python-mode-hook 'yl/setup-semantic-mode)
;(add-hook 'prog-mode-hook 'yl/setup-semantic-mode)


(use-package function-args
  :ensure t
  :defer t
  :demand
;  :init
;  (add-hook 'prog-mode-hook 'function-args-mode)
  :bind
  ("M-g" . hydra-semantic-fa/body)
  ;; (
  ;;  ("M-g h" . fa-show)
  ;;  ("M-g j" . fa-jump)
  ;;  ("M-g o" . moo-complete)
  ;;  ("M-g v" . moo-propose-virtual)
  ;;  ("M-g r" . moo-propose-override)
  ;;  ("M-g p" . moo-jump-local)
  ;;  )
  )


(defhydra hydra-semantic-fa (:color blue :columns 4)
  "Semantic and FunctionArgs"
  ("c" semantic-ia-describe-class "descibe class")
  ("u" semantic-ia-fast-jump "fast jump")
  ("t" semantic-ia-complete-tip "tip")
  ("m" semantic-ia-complete-symbol-menu "symbol menu")
  ("s" semantic-ia-show-summary "show summary")
  ("b" semantic-mrub-switch-tags "switch tags")
  ("f" semantic-force-refresh "force refresh")
  ("y" semantic-complete-analyze-inline "analyze inline")
  ("h" fa-show "fa show")
  ("j" fa-jump "fa jump")
  ("o" moo-complete "moo complete")
  ("v" moo-propose-virtual "moo virtual")
  ("r" moo-propose-override "moo override")
  ("p" moo-jump-local "moo local jump")
  ("M-l" flycheck-list-errors "flycheck error list")
  ("M-g" goto-line "go to line")
  ("g" goto-line "go to line")
  ("q" nil "quit")
  )


(use-package hideshow
  :ensure t
  :defer t
  :bind
  ("C-," . hydra-hs/body)
  :config
  (defhydra hydra-hs (:color red :columns 4)
	"Hide Show"
	("h" hs-hide-all "hide all")
	("s" hs-show-all "show all")
	("l" hs-hide-level "hide level")
	("b" hs-hide-block "hide block")
	("o" hs-show-block "show block")
	("t" hs-toggle-hiding "toggle")
	("q" nil "quit")
	)
  )

(add-hook 'prog-mode-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(use-package try
  :ensure t
  :defer t
  )
(use-package expand-region
  :ensure t
  :defer t
  :commands er/expand-region
  :bind ("C-=" . er/expand-region))

(use-package multiple-cursors
  :ensure t
  :defer t
  :bind
  (("C-M-=" . hydra-mc/body))
  
  )

(defhydra hydra-mc (:hint nil)
  "
      ^Up^            ^Down^        ^All^                ^Lines^               ^Edit^                 ^Other^
----------------------------------------------------------------------------------------------------
[_p_]   Next    [_n_]   Next    [_a_] All like this  [_l_] Edit lines      [_i_] Insert numbers   [_t_] Tag pair
[_P_]   Skip    [_N_]   Skip    [_r_] All by regexp  [_L_] Edit line beg.  [_s_] Sort regions      ^ ^
[_M-p_] Unmark  [_M-n_] Unmark  [_d_] All DWIM        ^ ^                  [_R_] Reverse regions  [_q_] Quit
"
  ("p" mc/mark-previous-like-this)
  ("P" mc/skip-to-previous-like-this)
  ("M-p" mc/unmark-previous-like-this)

  ("n" mc/mark-next-like-this)
  ("N" mc/skip-to-next-like-this)
  ("M-n" mc/unmark-next-like-this)

  ("a" mc/mark-all-like-this :exit t)
  ("r" mc/mark-all-in-region-regexp :exit t)
  ("d" mc/mark-all-dwim :exit t)

  ("l" mc/edit-lines :exit t)
  ("L" mc/edit-beginnings-of-lines :exit t)

  ("i" mc/insert-numbers)
  ("s" mc/sort-regions)
  ("R" mc/reverse-regions)

  ("t" mc/mark-sgml-tag-pair)
  ("q" nil)

  ("<mouse-1>" mc/add-cursor-on-click)
  ("<down-mouse-1>" ignore)
  ("<drag-mouse-1>" ignore))




(use-package cedet
  :defer t
  :ensure t
    )

;(require 'smart-compile)
(use-package smart-compile
  :ensure t
  :defer t
    
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Backup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq make-backup-files t)

(setq version-control t ;; Use version numbers for backups
	 kept-new-versions 5000 ;; Number of newest versions to keep
	 kept-old-versions 5 ;; Number of oldest versions to keep
	 delete-old-versions t ;; Ask to delete excess backup versions?
	 backup-by-copying t
	 )
	
  (defun force-backup-of-buffer ()
    ;; Make a special "per session" backup at the first save of each
    ;; emacs session.
    (when (not buffer-backed-up)
      ;; Override the default parameters for per-session backups.
      (let ((backup-directory-alist '(("" . "~/.emacs.d/backup/per-session")))
            (kept-new-versions 50))
        (backup-buffer)))
    ;; Make a "per save" backup on each save.  The first save results in
    ;; both a per-session and a per-save backup, to keep the numbering
    ;; of per-save backups consistent.
    (let ((buffer-backed-up nil))
      (backup-buffer)))

;; (defun force-backup-of-buffer ()
;;   (let ((buffer-backed-up nil))
;; 	(backup-buffer)))


(add-hook 'before-save-hook  'force-backup-of-buffer)


(setq initial-scratch-message "") ;; Uh, I know what Scratch is for


;(when (window-system)
;  (progn
(tool-bar-mode -1)               ;; Toolbars were only cool with XEmacs
(setq default-frame-alist '((tool-bar-lines . 0))
	  )
;	)
(when (fboundp 'horizontal-scroll-bar-mode)
  (horizontal-scroll-bar-mode -1))
(scroll-bar-mode 1)            ;; Scrollbars are waste screen estate
;)
 



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
(setq show-paren-style 'expression)

(setq auto-save-interal 300)
(setq auto-save-timeout 10)
(setq global-visual-line-mode t)
(setq visible-bell t)
(setq inhibit-startup-message t)

(setq show-paren-style 'parenthesis)
(setq blink-matching-paren t)

(setq column-number-mode t)
(setq line-number-mode t)


(setq kill-ring-max 200)
;(mouse-avoidance-mode 'animate)

(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))
(transient-mark-mode t)

(setq default-fill-column 72)

;;(setq display-time-24hr-format t)
;;(setq display-time-day-and-date t)
;;(display-time)



(defvar my-mode-line-buffer-line-count nil)
(make-variable-buffer-local 'my-mode-line-buffer-line-count)


(defun my-mode-line-count-lines ()
  (setq my-mode-line-buffer-line-count (int-to-string (count-lines (point-min) (point-max)))))

(add-hook 'find-file-hook 'my-mode-line-count-lines)
(add-hook 'after-save-hook 'my-mode-line-count-lines)
(add-hook 'after-revert-hook 'my-mode-line-count-lines)
(add-hook 'dired-after-readin-hook 'my-mode-line-count-lines)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode Setting;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;(org-agenda-to-appt)
(use-package org
  :ensure t
  )
(setq org-M-RET-may-split-line '((default . nil)) )
(setq org-special-ctrl-a t)
(setq org-latex-create-formula-image-program 'dvipng)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq default-major-mode 'org-mode)

(setq org-highlight-latex-and-related '(latex script entities))

(setq org-use-speed-commands 1)

;;(setq org-src-fontify-natively t)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))
(setq org-archive-mark-done nil)
;; (setq org-archive-location "%s_archive::* Archived Tasks")
(setq org-archive-location "%s_archive::datetree/* Archived Tasks")
(defun my-org-archive-done-tasks ()
  (interactive)
  (org-map-entries 'org-archive-subtree "/DONE" 'file))


(setq org-startup-indented 1)
(setq org-tags-column -100)
(setq org-icalendar-include-todo t) 

(setq org-todo-keywords
	  '(
		(sequence  "TODO(t)"  "NEXTACTION(n)"  "DELAYED(y)"	 "INPROGRESS(i)" "FOLLOWUP(f@/i)" "DELEGATE(e@/i)" "|" "MEMO(m)" "CANCELED(c@/i)" "DONE(d!)"  )
		)
	  )


(setq org-todo-keyword-faces
	  '(("TODO" . org-warning) ("INPROGRESS" . "orange") ("MEMO" . "blue")   ("NEXTACTION" . org-warning) ("DELAYED" . org-warning) ("FOLLOWUP" . org-warning) ("DELEGATE" . org-warning)
		("CANCELED" . (:foreground "blue" :weight bold))
		("DONE" . org-done) ))



(add-to-list 'org-emphasis-alist
			 '("*"  (:foreground "red")
			   ))

(add-hook 'org-mode-hook 'turn-on-org-cdlatex)

										;
										;;(add-hook 'org-mode-hook 'toggle_truncate_lines)

(add-hook 'org-mode-hook (lambda ()
  "Beautify Org Checkbox Symbol"
  (push '("[ ]" .  "☐") prettify-symbols-alist)
  (push '("[X]" . "☑" ) prettify-symbols-alist)
  (push '("[-]" . "❍" ) prettify-symbols-alist)
  (prettify-symbols-mode)))
(defface org-checkbox-done-text
  '((t (:foreground "#71696A" :strike-through t)))
  "Face for the text part of a checked org-mode checkbox.")

(font-lock-add-keywords
 'org-mode
 `(("^[ \t]*\\(?:[-+*]\\|[0-9]+[).]\\)[ \t]+\\(\\(?:\\[@\\(?:start:\\)?[0-9]+\\][ \t]*\\)?\\[\\(?:X\\|\\([0-9]+\\)/\\2\\)\\][^\n]*\n\\)"
    1 'org-checkbox-done-text prepend))
 'append)
;;;;Org Capture

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline my_org_capture_file "Notes" )
		 "* TODO %?\n ")
        ("m" "MEMO" entry (file+headline my_org_capture_file "Notes" )
		 "* MEMO %?\n ")
        ("n" "Meeting Note" entry (file+headline my_org_capture_file "Notes")
         "* Meeting with %? on %U\n")
		 ("j" "Journal" entry (file+datetree my_org_journal_file)
		  "* %?\nEntered on %U\n %i\n ")
		 
        )
	  )

 (use-package helm-bibtex
   :ensure t
   :defer t
   :config
   (progn
	 bibtex-completion-bibliography "~/Dropbox/bibliography/references.bib"
	 bibtex-completion-notes-path "~/Dropbox/bibliography/paper_reading_notes.org"
	 bibtex-completion-library-path "~/Dropbox/bibliography/papers"  )
	)




;;Org Clock 
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

(setq org-clock-mode-line-total #'current)


(defun my-org-clocktable-indent-string (level)
  (if (= level 1)
      ""
    (let ((str " "))
      (while (> level 2)
        (setq level (1- level)
              str (concat str "--")))
      (concat str "-"))))

(advice-add 'org-clocktable-indent-string :override #'my-org-clocktable-indent-string)


(setq org-agenda-clockreport-parameter-plist 
	  '(:fileskip0 t :link t :maxlevel 2 :formula "$5=($3+$4)*(60/25);t"))
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)
(setq org-agenda-todo-ignore-scheduled 'future)
(setq org-agenda-tags-todo-honor-ignore-options t)
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
;;(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-deadline-warning-days 15)
(setq org-log-done 'time)

(setq org-refile-targets 
	  '((nil :maxlevel . 6)
		(my_org_main_file :maxlevel . 6 )
		(my_org_memo_file :maxlevel . 3)
        
		))
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes (quote confirm))

(defun mark-tofile ()
  (interactive)
  (org-todo "TOFILE")
  )

(defun mark-nextaction ()
  (interactive)
  (org-todo "NEXTACTION")
  )

(defun mark-delayed ()
  (interactive)
  (org-todo "DELAYED")
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

(defun mark-followup ()
  (interactive)
  (org-todo "FOLLOWUP")
  )
(defun mark-delegate ()
  (interactive)
  (org-todo "DELEGATE")
  )


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


(defun show-nextaction ()
  (interactive)
  (setq current-prefix-arg 2)
  (call-interactively 'org-show-todo-tree))

(defun show-done ()
  (interactive)
  (setq current-prefix-arg 9)
  (call-interactively 'org-show-todo-tree))


(defun show-inprogress ()
  (interactive)
  (setq current-prefix-arg 4)
  (call-interactively 'org-show-todo-tree))

(defun show-memo ()
  (interactive)
  (setq current-prefix-arg 7)
  (call-interactively 'org-show-todo-tree))


(defun show-canceled ()
  (interactive)
  (setq current-prefix-arg 8)
  (call-interactively 'org-show-todo-tree))

(defun show-todo-keyword ()
  (interactive)
  (setq current-prefix-arg 1)
  (call-interactively 'org-show-todo-tree))

(defun show-followup ()
  (interactive)
  (setq current-prefix-arg 5)
  (call-interactively 'org-show-todo-tree))

(defun show-delegate ()
  (interactive)
  (setq current-prefix-arg 6)
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
	  '(
		("q" "Tasks CLOSED Older Than A Month" tags (concat "CLOSED<=\"<-30d>\""))
		("C" "Tasks CLOSED Last Week" tags  (concat "CLOSED>=\"<-1w>\""))
		("D" "Tasks DONE Last Week" tags (concat "TODO=\"DONE\"" "+CLOSED>=\"<-1w>\""))
		("S" "Tasks CLOSED Last Month" tags (concat "CLOSED>=\"<-1m>\""))
		
		)
	  )

(setq org-agenda-start-with-follow-mode 1)
(setq org-confirm-babel-evaluate nil)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (C . t)
   (dot . t)
   (latex . t)
   (lisp . t)
   (shell . t)
   (matlab . t)
   (plantuml . t)
   ))
(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/plantuml.jar"))

 (use-package ox-latex
   :ensure nil
   :defer t
   :config
   (add-to-list 'org-latex-classes
				'("ieeeconf"
				  "\\documentclass{ieeeconf}"
				  ("\\section{%s}" . "\\section*{%s}")
				  ("\\subsection{%s}" . "\\subsection*{%s}")
				  ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
				  )
				)
   )



 (use-package ox-beamer
   :ensure nil
   :defer t
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
(setq TeX-source-correlate-method 'synctex)
;(setq TeX-source-correlate-method 'source-specials)
;;(setq TeX-PDF-mode t)

;; to use pdfview with auctex
 (setq TeX-view-program-selection '((output-pdf "PDF Tools"))
    TeX-view-program-list '(("PDF Tools" TeX-pdf-tools-sync-view))
    TeX-source-correlate-start-server t) ;; not sure if last line is neccessary

 ;; to have the buffer refresh after compilation
 (add-hook 'TeX-after-compilation-finished-functions
		   #'TeX-revert-document-buffer)

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
										;
;; ;; Octave Mode

;; (use-package octave
;;   :ensure t
;;   :config
;;   (progn
;; 	(setq auto-mode-alist
;;       (cons '("\\.m$" . octave-mode) auto-mode-alist))
;; 	(setq octave-auto-indent t)
;; 	(setq octave-auto-newline t)
;; 	(setq octave-blink-matching-block t)
;; 	(setq octave-block-offset 4)
;; 	(setq octave-continuation-offset 4)
;; 	(setq octave-continuation-string "\\")
;; 	(setq octave-mode-startup-message t)
;; 	(setq octave-send-echo-input t)
;; 	(setq octave-send-line-auto-forward t)
;; 	(setq octave-send-show-buffer t)
	

;; 			)
;; 		  )
;;  (add-hook 'octave-mode-hook
;;  		  (lambda ()
;;  			;(auto-complete-mode 1)
;;  			(setq comment-start "% ")
;;  			)
;;  		  )

  

(use-package hydra
  :ensure t
  :defer t
  :bind
  (
   ("C-M-g" . hydra-projectile/body)
   )
  ;;:config
  ;; (defhydra hydra-projectile (:color red :columns 4)
  ;;   "Projectile"
  ;;   ("a" counsel-git-grep "ag")
  ;;   ("b" projectile-switch-to-buffer "switch to buffer")
  ;;   ("d" projectile-find-dir "dir")
  ;;   ("i" projectile-ibuffer "Ibuffer")
  ;;   ("K" projectile-kill-buffers "Kill all buffers")
  ;;   ("p" projectile-switch-project "switch")
  ;;   ("r" projectile-run-async-shell-command-in-root "run shell command")
  ;;   ("x" projectile-remove-known-project "remove known")
  ;;   ("X" projectile-cleanup-known-projects "cleanup non-existing")
  ;;   ("z" projectile-cache-current-file "cache current")
  ;;   ("q" nil "cancel")
  ;;     )
	 )

(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)
  :bind
  (
;;   ("M-K" . hydra-smartparens/body)
   ("C-(" . hydra-smartparens/body)
   )
  :config
;;  (require 'smartparens-config)
  ;;(use-package smartparens-org
	;;:ensure t
	;;:defer t
	;;)
  (defhydra hydra-smartparens (:color red :hint nil)
  "
  _B_ backward-sexp            -----                                   -----        
  _F_ forward-sexp               _s_ splice-sexp                        _m_ sp-mark-sexp              
  _L_ backward-down-sexp         _df_ splice-sexp-killing-forward       
  _H_ backward-up-sexp           _db_ splice-sexp-killing-backward
^^------                         _da_ splice-sexp-killing-around
  _k_ down-sexp                -----
  _j_ up-sexp                    _C-s_ select-next-thing-exchange
-^^-----                         _C-p_ select-previous-thing
  _n_ next-sexp                  _C-n_ select-next-thing
  _p_ previous-sexp            -----
  _a_ beginning-of-sexp          _C-f_ forward-symbol
  _z_ end-of-sexp                _C-b_ backward-symbol
--^^-                          -----
  _t_ transpose-sexp             _c_ convolute-sexp
-^^--                            _g_ absorb-sexp
  _x_ delete-char                _q_ emit-sexp
  _dw_ kill-word               -----
  _dd_ kill-sexp                 _,b_ extract-before-sexp
-^^--                            _,a_ extract-after-sexp
  _S_ unwrap-sexp              -----
-^^--                            _AP_ add-to-previous-sexp
  _C-h_ forward-slurp-sexp       _AN_ add-to-next-sexp
  _C-l_ forward-barf-sexp      -----
  _C-S-h_ backward-slurp-sexp    _ join-sexp
  _C-S-l_ backward-barf-sexp     _|_ split-sexp
-^^--
  _q_  Quit
"
  ;; TODO: Use () and [] - + * | <space>
  ("B" sp-backward-sexp );; similiar to VIM b
  ("F" sp-forward-sexp );; similar to VIM f
  ;;
  ("L" sp-backward-down-sexp )
  ("H" sp-backward-up-sexp )
  ;;
  ("k" sp-down-sexp ) ; root - towards the root
  ("j" sp-up-sexp )
  ;;
  ("n" sp-next-sexp )
  ("p" sp-previous-sexp )
  ;; a..z
  ("a" sp-beginning-of-sexp )
  ("z" sp-end-of-sexp )
  ;;
  ("t" sp-transpose-sexp )
  ;;
  ("x" sp-delete-char )
  ("dw" sp-kill-word )
  ;;("ds" sp-kill-symbol ) ;; Prefer kill-sexp
  ("dd" sp-kill-sexp )
  ;;("yy" sp-copy-sexp ) ;; Don't like it. Pref visual selection
  ;;
  ("S" sp-unwrap-sexp ) ;; Strip!
  ;;("wh" sp-backward-unwrap-sexp ) ;; Too similar to above
  ;;
  ("C-h" sp-forward-slurp-sexp )
  ("C-l" sp-forward-barf-sexp )
  ("C-S-h" sp-backward-slurp-sexp )
  ("C-S-l" sp-backward-barf-sexp )
  ;;
  ;;("C-[" (bind (sp-wrap-with-pair "[")) ) ;;FIXME
  ;;("C-(" (bind (sp-wrap-with-pair "(")) )
  ;;
  ("s" sp-splice-sexp )
  ("df" sp-splice-sexp-killing-forward )
  ("db" sp-splice-sexp-killing-backward )
  ("da" sp-splice-sexp-killing-around )
  ;;
  ("C-s" sp-select-next-thing-exchange )
  ("C-p" sp-select-previous-thing )
  ("C-n" sp-select-next-thing )
  ;;
  ("C-f" sp-forward-symbol )
  ("C-b" sp-backward-symbol )
  ;;
  ;;("C-t" sp-prefix-tag-object)
  ;;("H-p" sp-prefix-pair-object)
  ("c" sp-convolute-sexp )
  ("g" sp-absorb-sexp )
  ("q" sp-emit-sexp )
  ;;
  (",b" sp-extract-before-sexp )
  (",a" sp-extract-after-sexp )
  ;;
  ("AP" sp-add-to-previous-sexp );; Difference to slurp?
  ("AN" sp-add-to-next-sexp )
  ;;
  ("_" sp-join-sexp ) ;;Good
  ("|" sp-split-sexp )
  ;;
  ("m" sp-mark-sexp)


  ;;
  ("q" nil)
  ) 

  )

(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x <right>"))
(global-unset-key (kbd "C-x <up>"))
(global-unset-key (kbd "C-x <down>"))
				  
(use-package windmove
  ;; :defer 4
  :ensure t
  :defer t
  :config
  (setq windmove-wrap-around t)
  (windmove-default-keybindings)
   :bind
   (
    ("C-x <left>" . windmove-left)
    ("C-x <right>" . windmove-right)
    ("C-x <up>" . windmove-up)
    ("C-x <down>" . windmove-down)
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

;; (defun jump-to-today-report ()
;;   "call jump to bookmark function to go to today's clock table"
;;   (interactive)
;;   (bookmark-maybe-load-default-file)
  
;;   (bookmark-jump "ClockReportToday")
;;   (message "Went to today's clock report."))

(with-eval-after-load "org"
  (progn
	;; (add-hook 'org-mode-hook 'nolinum)
	;;(let ((current-prefix-arg 1))
	  ;;(call-interactively 'org-reload)
	 ;; ) ;; remove the export issue 
	(add-hook 'org-mode-hook #'visual-line-mode)
	(add-hook 'org-mode-hook (lambda () (org-autolist-mode)))
	(add-hook 'org-mode-hook
			  '(lambda ()
				 (setq org-file-apps
					   (append '(
								 ("\\.png\\'" . default)
								 ("\\.jpg\\'" . default)
								 ("\\.gif\\'" . default)
								 ("\\.xlsx\\'" . default)
								 ("\\.pptx\\'" . default)
								 ("\\.ppt\\'" . default)
								 ("\\.docx\\'" . default)
								 ) org-file-apps )
					   )
				 )
			  )
	(add-hook 'org-mode-hook '(lambda ()
								(which-function-mode 0)))
	(add-hook 'org-mode-hook '(lambda ()
								(setq helm-swoop-pre-input-function
									  (lambda () "")
									  )
								)
			  )
	
	
	(define-key org-mode-map (kbd "M-a") nil) ;; reserve for ace-window

	(setq org-duration-format (quote h:mm))
	
	(defun org-insert-link-with-prefix ()
    (interactive)
    (let ((current-prefix-arg '(4))) (call-interactively 'org-insert-link))
)

	(defun my/org-agenda-list-current-buffer (&optional arg)
	  (interactive "P")
	  (org-agenda arg "a" t))
	
	(defun yl/insert-custom-clock-entry ()
	  (interactive)
	  (insert "CLOCK: ")
	  (org-time-stamp-inactive)
	  (insert "--")
	  ;; Inserts the current time by default.
	  ;; (let ((current-prefix-arg '(4))) (call-interactively 'org-time-stamp-inactive))
	  ;; (org-ctrl-c-ctrl-c))
	  (org-time-stamp-inactive)
	  (backward-char 1)
	  (insert " ")
	  )
	
    (define-key org-mode-map (kbd "<C-f1>") nil)
    (define-key org-mode-map (kbd "M-h") nil) ;; reserve for helm
	;;F1
	;;(define-key org-mode-map (kbd "C-<f1>") 'org-back-to-top-level-heading)
	;;F5
	(define-key org-mode-map (kbd "<f5> n") 'mark-nextaction)
	(define-key org-mode-map (kbd "<f5> a") 'org-agenda)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)	
	;(define-key org-mode-map (kbd "<f5> f") 'mark-tofile)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)
	(define-key org-mode-map (kbd "<f5> d") 'mark-done)
	(define-key org-mode-map (kbd "<f5> m") 'mark-memo)
	;(define-key org-mode-map (kbd "<f5> l") 'mark-log)
	;(define-key org-mode-map (kbd "<f5> w") 'mark-waiting)
	(define-key org-mode-map (kbd "<f5> c") 'mark-canceled)
	;(define-key org-mode-map (kbd "<f5> p") 'mark-inprogress)
	(define-key org-mode-map (kbd "<f5> i") 'mark-inprogress)
	;(define-key org-mode-map (kbd "<f5> r") 'mark-report)
	(define-key org-mode-map (kbd "<f5> f") 'mark-followup)
	(define-key org-mode-map (kbd "<f5> e") 'mark-delegate)
	(define-key org-mode-map (kbd "C-<f5>") 'org-time-stamp-inactive)
	;; F6
	(define-key org-mode-map (kbd "<f6> a") 'my/org-agenda-list-current-buffer)
	(define-key org-mode-map (kbd "<f6> n") 'show-nextaction)
	;(define-key org-mode-map (kbd "<f6> p") 'show-inprogress)
	(define-key org-mode-map (kbd "<f6> i") 'show-inprogress)
	(define-key org-mode-map (kbd "<f6> m") 'show-memo)
	;(define-key org-mode-map (kbd "<f6> l") 'show-log)
	;(define-key org-mode-map (kbd "<f6> w") 'show-waiting)
	(define-key org-mode-map (kbd "<f6> c") 'show-canceled)
	(define-key org-mode-map (kbd "<f6> d") 'show-done)
	;(define-key org-mode-map (kbd "<f6> r") 'show-report)
	(define-key org-mode-map (kbd "<f6> t") 'show-todo-keyword)
	(define-key org-mode-map (kbd "<f6> f") 'show-followup)
	(define-key org-mode-map (kbd "<f6> e") 'show-delegate)
	(define-key org-mode-map (kbd "M-<f6>") (kbd "C-c a n"))
	(define-key org-mode-map (kbd "<f6> L") 'jtc-tasks-last-month)
	;;F7
	(define-key org-mode-map (kbd "<f7>") 'hydra-org-edit-insert/body)
	;;F8
;	(define-key org-mode-map (kbd "<f8>") 'add-sublevel-plainitem);'add-sublevel-todo)
	(define-key org-mode-map (kbd "<f8>") 'hydra-org-structural-move-search/body);'add-sublevel-todo)
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
	(define-key org-mode-map (kbd "<f9> h") 'org-hide-block-all)
	(define-key org-mode-map (kbd "<f9> y") 'yl/insert-custom-clock-entry)

	(define-key org-mode-map (kbd "<f9> p") 'org-pomodoro)
	(define-key org-mode-map (kbd "<f9> k")	'org-pomodoro-kill)
	(define-key org-mode-map (kbd "<f9> t i") 'org-timer-item)
	(define-key org-mode-map (kbd "<f9> t p") 'org-timer-pause-or-continue)
	(define-key org-mode-map (kbd "<f9> t s") 'org-timer-stop)
	(define-key org-mode-map (kbd "<f9> t d") 'org-timer-set-timer)

;;    (define-key org-mode-map (kbd "<f10>") 'add-sublevel-plainitem)
	
	(define-key org-mode-map (kbd "C-<f12>") 'org-overview)
	(define-key org-mode-map (kbd "<f12>") 'ace-window)
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
	(define-key org-mode-map (kbd "C-a") 'org-beginning-of-line)
	(define-key org-mode-map (kbd "C-e") 'org-end-of-line)
	(define-key org-mode-map (kbd "C-k") 'org-kill-line)
	
	) )

;; (use-package org-habit)



(defhydra hydra-org-structural-move-search (:color red :columns 4 :exit t)
	"Org Structural Movement and Search"
	("s" org-sparse-tree "sparse-tree")
	("<up>" org-backward-heading-same-level "back same level")
	("<down>" org-forward-heading-same-level "forward same level")
	("u" outline-up-heading "up level")
	("n" org-narrow-to-subtree "narrow")
	("l" org-agenda-set-restriction-lock "lock agenda to subtree")
	("j" org-refile-goto-last-stored "goto last refiled headline")
	("r" org-agenda-remove-restriction-lock "remove agenda subtree lock")
	("w" widen "widen")
	("q" nil "quit")
	)

(defun yl-org-add-subheading ()
  (interactive)
  (end-of-line)
  (org-insert-heading-respect-content)
  (org-do-demote)
  )

(defhydra hydra-org-edit-insert (:color red :columns 4 :exit t)
  "Org Insert and Edit"
  ("d" org-insert-drawer "insert drawer")
  ("a" org-archive-subtree "archive subtree")
  ("s" add-sublevel-plainitem "new sub")
  ("@" org-mark-subtree "mark tree")
  ("<left>" org-promote-subtree "promote tree")
  ("<right>" org-demote-subtree "demote tree")
  ("M-<up>" org-move-subtree-up "move tree up")
  ("M-<down>" org-move-subtree-sown "move tree down")
  ("i" org-toggle-inline-images "toggle inline images")
  ("l" org-insert-link "insert link")
  ("f" org-insert-link-with-prefix "insert link to file")
  ("k" org-set-line-checkbox "change line to checkbox")
  ("m" org-mark-element "mark element")
  ("x" org-cut-subtree "cut tree")
  ("c" org-copy-subtree "copy tree")
  ("y" org-paste-subtree "yank tree (level adapt)")
  ("r" org-refile "refile")
  ("^" org-sort "sort")
  ("*" org-toggle-heading "toggle heading")
  ("p" org-set-property "property")
  ("u" org-priority "priority")
  ("P" yl-insert-project-template "insert project template")
  ("B" yl-insert-beamer-template "insert beamer template")
  ("t" org-toggle-latex-fragment "toggle latex fragment")
  
  ("q" nil "quit")
  )

(defun yl-insert-project-template ()
  (interactive)
  (insert-file-contents "~/.emacs.d/templates/org_project_template.org")
  (end-of-buffer)
  )

(defun yl-insert-beamer-template ()
  (interactive)
  (insert-file-contents "~/.emacs.d/templates/org_beamer_template.org")
  (end-of-buffer)
  )

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

(global-set-key (kbd "C-c n") 'nolinum)

;;;;;;;;
;; F11
;;;;;;;;
(defun my-gdb-other-frame ()
  (interactive)
  (select-frame (make-frame))
  (call-interactively 'gdb))
(setq gdb-many-windows t)
(setq gdb-show-main t)
(setq gdb-show-changed-values t)
(global-set-key (kbd "<f11>") 'my-gdb-other-frame)


;;;;;;;;
;; F12
;;;;;;;;

;;(global-set-key (kbd "<f12>") 'smart-compile)

;;;;;;;;
;; Others
;;;;;;;;

(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-x z") 'repeat-complex-command)
(global-set-key (kbd "C-z")  'set-mark-command)
;(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key [C-tab] 'other-window)
;(global-set-key [C-next] 'scroll-other-window)
;(global-set-key [C-prior] 'scroll-other-window-down)


(global-set-key (kbd "M-<backspace>") (lambda ()
								(interactive)
								(kill-line 0)
								(indent-according-to-mode)))

(defun remember-here ()
  "Remember current position."
  (interactive)
  (point-to-register 8)
  (message "Have remembered this position"))

(defun remember-jump ()
  "Jump to latest position."
  (interactive)
  (let ((tmp (point-marker)))
    (jump-to-register 8)
    (set-register 8 tmp))
  (message "Jumped back to remembered position"))

(global-set-key (kbd "C-M-/") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "C-1") 'remember-here) 
(global-set-key (kbd "C-2") 'remember-jump) 
(global-set-key (kbd "C-3") 'pop-global-mark)


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

(global-set-key (kbd "C-4") 'unpop-to-mark-command)
(global-set-key (kbd "C-0") (lambda () (interactive) (push-mark-command nil nil)));

;(global-set-key (kbd "C-0") (lambda() (interactive) (push-mark nil nil 1)))
(global-set-key (kbd "C-+") (kbd "C-u C-_")) ; redo
(global-set-key (kbd "C-c o") 'occur)

(global-set-key (kbd "C-M-m") 'delete-minibuffer-contents)

(use-package recentf
  :ensure t
  :config
  (progn
	(setq recentf-max-saved-items 20
		  recentf-max-menu-items 15)
	(recentf-mode 1)
	(global-set-key "\C-x\ \C-r" 'recentf-open-files)
	;(run-at-time (current-time) 600 'recentf-save-list)
	(add-to-list 'recentf-exclude (format "%s/\\.emacs\\.d/elpa/.*" (getenv "HOME")));ignore elpa install .el files
	(add-to-list 'recentf-exclude "\\.breadcrumb\\'")
	(add-to-list 'recentf-exclude "\\recentf\\'")
	(add-to-list 'recentf-exclude "/\\.emacs\\.d/")
	(add-to-list 'recentf-exclude "\\.log$")
	(add-to-list 'recentf-exclude "\\.toc")
	(add-to-list 'recentf-exclude "\\.org\\_archive")
	(add-to-list 'recentf-exclude "\\.pdfsync$")
	(add-to-list 'recentf-exclude "\\.aux$")
	(add-to-list 'recentf-exclude "\\.gz$")
	)
  )


(put 'upcase-region 'disabled nil)

(put 'narrow-to-region 'disabled nil)

(defun ridm ()
  "Remove intrusive CTRL-Ms from the buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-string "\C-m\C-j" "\C-j")))



(defun check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
    (backward-char 1)
    (if (looking-at "->") t nil)))))

(defun do-yas-expand ()
  (let ((yas/fallback-behavior 'return-nil))
    (yas/expand)))

 (defun tab-indent-or-complete ()
  (interactive)
  (cond
   ((minibufferp)
    (minibuffer-complete))
   (t
    (indent-for-tab-command)
    (if (or (not yas/minor-mode)
        (null (do-yas-expand)))
    (if (check-expansion)
        (progn
          (company-manual-begin)
          (if (null company-candidates)
          (progn
            (company-abort)
            (indent-for-tab-command)))))))))

(defun tab-complete-or-next-field ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand)))
      (if company-candidates
      (company-complete-selection)
    (if (check-expansion)
      (progn
        (company-manual-begin)
        (if (null company-candidates)
        (progn
          (company-abort)
          (yas-next-field))))
      (yas-next-field)))))

(defun expand-snippet-or-complete-selection ()
  (interactive)
  (if (or (not yas/minor-mode)
      (null (do-yas-expand))
      (company-abort))
      (company-complete-selection)))

(defun abort-company-or-yas ()
  (interactive)
  (if (null company-candidates)
      (yas-abort-snippet)
    (company-abort)))

;;(global-set-key [tab] 'tab-indent-or-complete)
;;(global-set-key (kbd "TAB") 'tab-indent-or-complete)
(global-set-key [(control return)] 'company-complete-common)

(define-key company-active-map [tab] 'expand-snippet-or-complete-selection)
(define-key company-active-map (kbd "TAB") 'expand-snippet-or-complete-selection)

;(define-key yas-minor-mode-map [tab] nil)
;(define-key yas-minor-mode-map (kbd "TAB") nil)


(defun my-mark-sexp ()
  "My own mark sexp fun"
  (interactive)
  (progn
	(backward-sexp)
	(mark-sexp)
	))
(global-set-key (kbd "C-M-;") 'my-mark-sexp)


(use-package afternoon-theme
  :ensure t)

(load-theme 'afternoon t)


;; (use-package doom-themes
;;   :ensure t
;;   :config
;;   ;; Global settings (defaults)
;;   (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;         doom-themes-enable-italic t) ; if nil, italics is universally disabled
;;   (load-theme 'doom-solarized-dark t)

;;   ;; Enable flashing mode-line on errors
;;   (doom-themes-visual-bell-config)
  
;;   ;; Enable custom neotree theme (all-the-icons must be installed!)
;;   (doom-themes-neotree-config)
;;   ;; or for treemacs users
;;   (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
;;   (doom-themes-treemacs-config)
  
;;   ;; Corrects (and improves) org-mode's native fontification.
;;   (doom-themes-org-config)
;;   )

(if (eq system-type 'windows-nt)
	(set-face-attribute 'mode-line nil :font "Courier New")
  )



  (defun ibuffer-advance-motion (direction)
        (forward-line direction)
        (beginning-of-line)
        (if (not (get-text-property (point) 'ibuffer-filter-group-name))
            t
          (ibuffer-skip-properties '(ibuffer-filter-group-name)
                                   direction)
          nil))
  (defun ibuffer-previous-line (&optional arg)
    "Move backwards ARG lines, wrapping around the list if necessary."
    (interactive "P")
    (or arg (setq arg 1))
    (let (err1 err2)
      (while (> arg 0)
        (cl-decf arg)
        (setq err1 (ibuffer-advance-motion -1)
              err2 (if (not (get-text-property (point) 'ibuffer-title)) 
                       t
                     (goto-char (point-max))
                     (beginning-of-line)
                     (ibuffer-skip-properties '(ibuffer-summary 
                                                ibuffer-filter-group-name) 
                                              -1)
                     nil)))
      (and err1 err2)))
  (defun ibuffer-next-line (&optional arg)
    "Move forward ARG lines, wrapping around the list if necessary."
    (interactive "P")
    (or arg (setq arg 1))
    (let (err1 err2)
      (while (> arg 0)
        (cl-decf arg)
        (setq err1 (ibuffer-advance-motion 1)
              err2 (if (not (get-text-property (point) 'ibuffer-summary)) 
                       t
                     (goto-char (point-min))
                     (beginning-of-line)
                     (ibuffer-skip-properties '(ibuffer-summary 
                                                ibuffer-filter-group-name
                                                ibuffer-title)
                                              1)
                     nil)))
      (and err1 err2)))
;; (defun brust/ibuffer-next-header ()
;;     (interactive)
;;     (while (ibuffer-next-line)))
;;   (defun brust/ibuffer-previous-header ()
;;     (interactive)
;;     (while (ibuffer-previous-line)))
 (define-key ibuffer-mode-map (kbd "<up>") 'ibuffer-previous-line)
  (define-key ibuffer-mode-map (kbd "<down>") 'ibuffer-next-line)
  ;; (define-key ibuffer-mode-map (kbd "<right>") 'ibuffer-previous-header)
  ;; (define-key ibuffer-mode-map (kbd "<left>") 'ibuffer-next-header)

(defun package-menu-find-marks ()
  "Find packages marked for action in *Packages*."
  (interactive)
  (occur "^[A-Z]"))

;; Only in Emacs 25.1+
(defun package-menu-filter-by-status (status)
  "Filter the *Packages* buffer by status."
  (interactive
   (list (completing-read
          "Status: " '("new" "installed" "dependency" "obsolete"))))
  (package-menu-filter (concat "status:" status)))

(define-key package-menu-mode-map "s" #'package-menu-filter-by-status)
(define-key package-menu-mode-map "a" #'package-menu-find-marks)


(use-package ace-window
   :ensure t
   :config
   (progn
	 (global-set-key (kbd "M-W") 'ace-window)
	 (global-set-key (kbd "C-`") 'ace-window)

	  )
	 )
   
   
(use-package free-keys
  :ensure t
  :defer t
  )

(use-package pdf-tools
  :ensure t
  :config
    (pdf-tools-install)
    (setq-default pdf-view-display-size 'fit-width)
    ;(define-pdf-cache-function outline)
    ;(pdf-cache-outline)
    (bind-keys :map pdf-view-mode-map
        ("t" . hydra-pdftools/body)
        ("<s-spc>" .  pdf-view-scroll-down-or-next-page)
        ("g"  . pdf-view-first-page)
        ("G"  . pdf-view-last-page)
        ("l"  . image-forward-hscroll)
        ("h"  . image-backward-hscroll)
        ("j"  . pdf-view-next-page)
        ("k"  . pdf-view-previous-page)
        ("e"  . pdf-view-goto-page)
        ("u"  . pdf-view-revert-buffer)
        ("al" . pdf-annot-list-annotations)
        ("ad" . pdf-annot-delete)
        ("aa" . pdf-annot-attachment-dired)
        ("am" . pdf-annot-add-markup-annotation)
        ("at" . pdf-annot-add-text-annotation)
		("ah" . pdf-annot-add-highlight-markup-annotation)
        ("y"  . pdf-view-kill-ring-save)
        ("i"  . pdf-misc-display-metadata)
        ("s"  . pdf-occur)
        ("b"  . pdf-view-set-slice-from-bounding-box)
        ("r"  . pdf-view-reset-slice)
		("D" . pdf-annot-delete)
		)
	)

	

(defhydra hydra-pdftools (:color blue :hint nil)
        "
                                                                      ╭───────────┐
       Move  History   Scale/Fit     Annotations  Search/Link    Do   │ PDF Tools │
   ╭──────────────────────────────────────────────────────────────────┴───────────╯
         ^^_g_^^      _B_    ^↧^    _+_    ^ ^     [_al_] list    [_s_] search    [_u_] revert buffer
         ^^^↑^^^      ^↑^    _H_    ^↑^  ↦ _W_ ↤   [_am_] markup  [_o_] outline   [_i_] info
         ^^_p_^^      ^ ^    ^↥^    _0_    ^ ^     [_at_] text    [_F_] link      [_d_] dark mode
         ^^^↑^^^      ^↓^  ╭─^─^─┐  ^↓^  ╭─^ ^─┐   [_ad_] delete  [_f_] search link
    _h_ ←pag_e_→ _l_  _N_  │ _P_ │  _-_    _b_     [_aa_] dired
         ^^^↓^^^      ^ ^  ╰─^─^─╯  ^ ^  ╰─^ ^─╯   [_y_]  yank
         ^^_n_^^      ^ ^  _r_eset slice box
         ^^^↓^^^
         ^^_G_^^
   --------------------------------------------------------------------------------
        "
        ("\\" hydra-master/body "back")
        ("<ESC>" nil "quit")
        ("al" pdf-annot-list-annotations)
        ("ad" pdf-annot-delete)
        ("aa" pdf-annot-attachment-dired)
        ("am" pdf-annot-add-markup-annotation)
        ("at" pdf-annot-add-text-annotation)
		("ah"  pdf-annot-add-highlight-markup-annotation)
        ("y"  pdf-view-kill-ring-save)
        ("+" pdf-view-enlarge :color red)
        ("-" pdf-view-shrink :color red)
        ("0" pdf-view-scale-reset)
        ("H" pdf-view-fit-height-to-window)
        ("W" pdf-view-fit-width-to-window)
        ("P" pdf-view-fit-page-to-window)
        ("n" pdf-view-next-page-command :color red)
        ("p" pdf-view-previous-page-command :color red)
        ("d" pdf-view-dark-minor-mode)
        ("b" pdf-view-set-slice-from-bounding-box)
        ("r" pdf-view-reset-slice)
        ("g" pdf-view-first-page)
        ("G" pdf-view-last-page)
        ("e" pdf-view-goto-page)
        ("o" pdf-outline)
        ("s" pdf-occur)
        ("i" pdf-misc-display-metadata)
        ("u" pdf-view-revert-buffer)
        ("F" pdf-links-action-perfom)
        ("f" pdf-links-isearch-link)
        ("B" pdf-history-backward :color red)
        ("N" pdf-history-forward :color red)
        ("l" image-forward-hscroll :color red)
        ("h" image-backward-hscroll :color red))

(use-package org-ref
  :ensure t
  :after org
  :init
  (progn
	(setq org-ref-show-broken-links nil)
;; see org-ref for use of these variables
	(setq org-ref-bibliography-notes '("~/Work/org/refs/paper_reading_notes.org"))
	(setq org-ref-default-bibliography '("~/Work/org/refs/refs.bib"))
	(setq org-ref-pdf-directory '("~/Work/org/refs/pdfs/"))
		  
	(setq reftex-default-bibliography '("~/Work/org/refs/refs.bib"))
	     
	)
  )

(use-package org-autolist
  :ensure t
  :defer t
  :after org

  )


;; (use-package org-pdfview
;;    :ensure t
;;    :after org
;;    )



(add-to-list 'org-file-apps 
              '("\\.pdf\\'" . emacs))

(defun toggle-window-dedicated ()
  "Control whether or not Emacs is allowed to display another
buffer in current window."
  (interactive)
  (message
   (if (let (window (get-buffer-window (current-buffer)))
         (set-window-dedicated-p window (not (window-dedicated-p window))))
       "%s: Can't touch this!"
     "%s is up for grabs.")
   (current-buffer)))

(global-set-key (kbd "C-c t") 'toggle-window-dedicated)

(setq auto-window-vscroll nil) ;;improve cursor movement speed

(use-package academic-phrases
  :ensure t
  :defer t
  )

;;(use-package super-save
;;  :ensure t
;;  :init
;;  (progn
;;	(setq super-save-auto-save-when-idle t)
	;; add integration with ace-window
;;	(add-to-list 'super-save-triggers 'ace-window)
;;	
	;; save on find-file
	;;(add-to-list 'super-save-hook-triggers 'find-file-hook)
	;;)
  ;;)


(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

(global-set-key (kbd "M-o") 'smart-open-line-above)

(use-package leetcode
  :ensure t
  :defer t
  :init
  (progn
	(setq leetcode-prefer-language "cpp")
	)
  )

(use-package rust-mode
  :ensure t
  :defer t
  :hook (rust-mode . lsp))

(use-package cargo
  :ensure t
  :defer t
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :ensure t
  :defer t
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  )

(use-package toml-mode
  :ensure t
  :defer t
  )

(use-package ein
  :ensure t
  :defer t
  )
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook
			(lambda () (org-bullets-mode 1))))

(use-package mermaid-mode
  :ensure t
  :defer t
  )

(use-package ob-mermaid
  :ensure t
  :defer t)

(use-package org-super-agenda
  :ensure t
  :config
  (org-super-agenda-mode)
   )
  
(add-to-list 'org-agenda-custom-commands
			 '("z" "Supger Agenda" agenda ""
			   ((org-super-agenda-groups
				 '((
					:name "High Priority"
						  :priority "A"
						  :order 1
						  )
				   (:name "In Progress"
						  :todo "INPROGRESS"
						  :order 2
						  )
				   (:name "Next Action"
						  :todo "NEXTACTION"
						  :order 3
						  )
				   (:name "Follow Up"
						  :todo "FOLLOWUP"
						  :order 4
						  )
				   (:name "Today"
						  :deadline today
						  :order 5)
				   (:name "Over Due"
						  :deadline past
						  :order 6)
				   (:name "Delegate"
						  :todo "DELEGATE"
						  :order 7)
				   )
				 )
				)
			   )
			 )
				

(set-face-attribute 'org-mode-line-clock nil
                    :weight 'bold :box '(:line-width 1 :color "#FFBB00") :foreground "white" :background "#FF4040")

(use-package rg
  :ensure t
  :defer t
;;  :config 
;;  (global-set-key (kbd "M-h g") 'rg)
  )

(use-package helm-rg
  :after helm
  :ensure t
  :defer t
;;  :config
;;  (global-set-key (kbd "M-h .") 'helm-rg)
  )

(use-package helm-ag
  :after helm
  :ensure t
  :defer t
  )

(use-package org-roam
  :ensure t
  :defer t
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory "~/org-roam/")
  :bind (
		 :map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph)

			   )
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

(defhydra hydra-org-roam (:color red :columns 4 :exit t)
  "Org Roam"
  ("r" org-roam "start org roam")
  ("f" org-roam-find-file  "find file")
  ("g" org-roam-graph "org-roam-graph")
  ("i" org-roam-insert "insert")
  ("I" org-roam-insert-immediate "insert immediate")
  ("t" org-roam-tag-add "add tags")
  ("d" org-roam-tag-delete "delete tags")

  )

;;(define-key org-mode-map (kbd "<f10>") 'hydra-org-roam/body)
(global-set-key (kbd "<f10>") 'hydra-org-roam/body)
(use-package org-roam-server
  :ensure t
  :defer t
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 7749
        org-roam-server-authenticate nil
        org-roam-server-export-inline-images t
        org-roam-server-serve-files nil
        org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
        org-roam-server-network-poll t
        org-roam-server-network-arrows nil
        org-roam-server-network-label-truncate t
        org-roam-server-network-label-truncate-length 60
        org-roam-server-network-label-wrap-length 20))

(use-package esup
  :ensure t
  :defer t
  :config
	     (setq esup-depth 0)
	     )

(use-package olivetti
  :ensure t
  :config
  (define-key olivetti-mode-map (kbd "C-c \\") nil)
  (add-hook 'text-mode-hook 'olivetti-mode)
   (add-hook 'org-mode-hook 'olivetti-mode)
   (add-hook 'olivetti-mode-hook (lambda () (interactive) (setq olivetti-body-width 110)))
  )

  
  
