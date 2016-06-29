(if (eq system-type 'windows-nt)
    (progn
      	(let ((default-directory "~/.emacs.d/"))
	(normal-top-level-add-subdirs-to-load-path))
	(add-to-list 'backup-directory-alist  '("." . "~/Work/emacs_backup/backup/"))
	(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves" t)))
	(setq default-directory "~/Work/Notes_Planning/")
	(add-to-list 'exec-path "~/Softwares/Aspell/bin/")
	(setq ispell-dictionary "~/Softwares/Aspell/dict/")
	(setq myprojectfile "~/Work/Notes_Planning/Projects_2016.org")
	(load-file "~/.emacs.d/init_proxy.el")
	)
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
;With the above apsell config for mac os, i also edited /usr/local/etc/aspell.conf to change the string after "dict-dir" to "/Library/Application Support/cocoAspell/aspell6-en-6.0-0". Flyspell mode now works fine.
    ))
  
	

(require 'package)




;; Avoid multiple initialization of installed packages.
(setq package-enable-at-startup nil)
;; Add Melpa to the list of package archives.
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

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


(require 'benchmark-init)



(use-package bookmark
  :ensure t
  :config
  (progn
    (define-key global-map (kbd "<f1>") 'bookmark-set)
    (define-key global-map (kbd "<f2>") 'bookmark-jump)
    (define-key global-map (kbd "M-L") 'bookmark-bmenu-list)
    ))
  


(global-set-key (kbd "C-x g") 'magit-status)
(use-package magit
  :defer t
  :ensure t
)

(use-package which-key
  :ensure t
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

  
(use-package helm
  :diminish helm
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
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
    ;; follow mode in helm
   
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
         ("M-h SPC" . helm-all-mark-rings)
	 ("M-h b" . helm-bookmarks)
	 ("M-h j" . ace-jump-helm-line)))
(global-set-key (kbd "C-x C-b") 'buffer-menu) ; this is my preferred buffer list behavior over helm. this is actually what i had been using before helm. not list-buffers in fact, was buffer-menu
(use-package helm-descbinds
  :defer t
  :bind (("C-h b" . helm-descbinds)
         ("C-h w" . helm-descbinds)))


(use-package color-theme
  :init (color-theme-initialize)
  :config (color-theme-vim-colors)
  )

;; (use-package avy
;;   :ensure t
;;   :config
;;   (progn
;;     (global-set-key (kbd "M-s") 'avy-goto-char)
;;     (global-set-key (kbd "S-SPC") 'avy-goto-line)))

(use-package ace-jump-mode
  :ensure t
  :config
  (progn
    (global-set-key (kbd "M-s") 'ace-jump-char-mode)
    (global-set-key (kbd "S-SPC") 'ace-jump-line-mode)
    ))


(use-package ace-window
  :ensure t
  :config (global-set-key (kbd "M-p") 'ace-window))

(use-package ido
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
    (setq ido-file-extensions-order '(".org" ".c" ".tex" ".py" ".emacs" ".el" ".ini" ".cfg" ".cnf"))
    (add-to-list 'ido-ignore-files "appspec.yml")))


  
 
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

(use-package guide-key
  :defer t
  :diminish guide-key-mode
  :config
  (progn
  (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c"))
  (guide-key-mode 1)))  ; Enable guide-key-mode

;; (use-package ein
;;   :ensure t
;;   :defer t)

(use-package python
  :defer t
  :ensure t)

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
     ;(setq elpy-rpc-backend "jedi")
     ))
(add-hook 'python-mode-hook 'elpy-mode)

;; if windows redefine M-TAB to F5 since M-TAB is used for switching applications
(if (eq system-type 'windows-nt)
    (progn
      (add-hook 'elpy-mode-hook
		(lambda ()
		  (local-unset-key (kbd "M-TAB"))
		  (define-key elpy-mode-map (kbd "<f5>") 'elpy-company-backend)))))
(use-package company
  :ensure t
  :config
  (progn
  (add-hook 'after-init-hook 'global-company-mode)
  ;(global-set-key "\t" 'company-complete-common)
  (setq company-backends
      '((company-files          ; files & directory
         company-keywords       ; keywords
         company-capf
         )
        (company-abbrev company-dabbrev)
        ))
  ))

 ;; (use-package auto-complete
 ;;   :init
 ;;   (progn
 ;;     (auto-complete-mode t))
 ;;   :bind (("C-n" . ac-next)
 ;; 	  ("C-p" . ac-previous))
 ;;   :config
 ;;   (progn
 ;;     (use-package auto-complete-config)
 ;;     (ac-config-default))
 ;;   )



;; (define-globalized-minor-mode real-global-auto-complete-mode
;;   auto-complete-mode (lambda ()
;;                        (if (not (minibufferp (current-buffer)))
;;                          (auto-complete-mode 1))
;;                        ))
;; (real-global-auto-complete-mode t)


  




;;(require 'ispell)
(use-package ispell
  :ensure t
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

;(require 'desktop)
(require 'recentf)
(require 'calendar)

(use-package iedit
  :ensure t
  :defer t

  ) ;; iedit can edit multiple occurrence at the same time.
(global-set-key  (kbd "C-`") 'iedit-mode)


(use-package imenu
  :ensure t
  :config
  (progn
    (setq imenu-auto-rescan t)
    (global-set-key (kbd "C-c i") 'imenu)
    (defun try-to-add-imenu ()
      (condition-case nil (imenu-add-to-menubar "iMenu") (error nil)))
    (add-hook 'font-lock-mode-hook 'try-to-add-imenu)
    ))

(which-function-mode 1)
(global-linum-mode 1)
(semantic-mode 1);keeps parsing repeatedly for large c files. 


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C Programming
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cc-mode
  :defer t
  :config
  (progn
    (use-package google-c-style
      :ensure t
      :init
      (progn
	(add-hook 'c-mode-common-hook
		  (lambda ()
		    (google-set-c-style)
		    (google-make-newline-indent))))
      :config
      (c-set-offset 'statement-case-open 0))))
;; Some bindings for hi-lock mode that will be very convenient for C code reading
(global-set-key (kbd "C-.") 'highlight-symbol-at-point)
(global-set-key (kbd "C->") 'highlight-phrase)
 
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

;(use-package cedet
;  :defer t
;  :ensure t)

(require 'smart-compile)

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







;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org Mode Setting;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(org-agenda-to-appt)

(setq org-latex-create-formula-image-program 'dvipng)
(setq default-major-mode 'org-mode)

(setq org-use-speed-commands 1)


(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")
;(setq org-combined-agenda-icalendar-file "C:/Users/yliu193/Work/Notes_Planning/combined_calendar_export.ics")
(setq org-startup-indented 1)
(setq org-tags-column -100)
(setq org-icalendar-include-todo t) 

(setq org-todo-keywords
    '((sequence "TODO(t)" "WAITING(w@)"  "REPORT(r)" "NEXTACTION(n)"  "INPROGRESS(p)" "TOFILE(f)"  "|" "DONE(d!)" "CANCELED(c@/i)" "MEMO(m)" )
   ))
	 
(setq org-todo-keyword-faces
    '(("TODO" . org-warning) ("INPROGRESS" . "orange") ("MEMO" . "blue") ("TOFILE" . org-warning) ("REPORT" . "cyan") ("NEXTACTION" . org-warning)
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

(setq org-log-done 'time)

(setq org-refile-targets 
	'((nil :maxlevel . 6 )
	))


(defun open-notes ()
   (interactive)
   (find-file "C:/Users/yliu193/Work/Notes_Planning/Notes.org")
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
	     ("m" todo "MEMO")
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
   
;; (require 'ox-latex)
;; (add-to-list 'org-latex-classes
;;              '("beamer"
;;                "\\documentclass\[presentation\]\{beamer\}"
;;                ("\\section\{%s\}" . "\\section*\{%s\}")
;;                ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
;;                ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

(use-package ox-latex
  :defer t
  :config
  (add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
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
;(setq-default TeX-master nil)

;(load "auctex.el" nil t t)
;(load "preview-latex.el" nil t t)



(eval-after-load "tex"
  '(add-to-list 'TeX-command-list
                         '("ps2pdf" "ps2pdf %f" TeX-run-command nil t) t))
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

;(setq preview-image-type 'dvipng)
 ;; (add-hook 'latex-mode-hook
 ;;           #'(lambda ()
 ;;               (set (make-local-variable 'autopair-handle-action-fns)
 ;;                    (list #'autopair-default-handle-action
 ;;                         #'autopair-latex-mode-paired-delimiter-action))))


;(require 'font-latex)

;; (defun font-latex-jit-lock-force-redisplay (buf start end)
;;   "Compatibility for Emacsen not offering `jit-lock-force-redisplay'."
;;     ;; The following block is an expansion of `jit-lock-force-redisplay'
;;     ;; and involved macros taken from CVS Emacs on 2007-04-28.
;;     (with-current-buffer buf
;;       (let ((modified (buffer-modified-p)))
;;     (unwind-protect
;;         (let ((buffer-undo-list t)
;;           (inhibit-read-only t)
;;           (inhibit-point-motion-hooks t)
;;           (inhibit-modification-hooks t)
;;           deactivate-mark
;;           buffer-file-name
;;           buffer-file-truename)
;;           (put-text-property start end 'fontified t))
;;       (unless modified
;;         (restore-buffer-modified-p nil))))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Matlab setting
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (eq system-type 'windows-nt)
      (eval-after-load 'matlab
	'(progn
	   (add-to-list
	    'auto-mode-alist
	    '("\\.m$" . matlab-mode))
	   (setq matlab-indent-function t)
	   (setq matlab-shell-command "matlab")
	  ; (add-hook 'matlab-mode 'auto-complete-mode)
	   (add-hook 'matlab-mode-hook 'ace-jump-mode)
	   (define-key matlab-mode-map (kbd "M-s") nil)
	   ))
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
    (define-key org-mode-map (kbd "M-h") nil)
	;;F1
	(define-key org-mode-map (kbd "C-<f1>") 'org-back-to-top-level-heading)
	;;F5
	(define-key org-mode-map (kbd "<f5> n") 'mark-nextaction)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)	
	(define-key org-mode-map (kbd "<f5> f") 'mark-tofile)
	(define-key org-mode-map (kbd "<f5> t") 'mark-todo)
	(define-key org-mode-map (kbd "<f5> d") 'mark-done)
	(define-key org-mode-map (kbd "<f5> m") 'mark-memo)
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
	(define-key org-mode-map (kbd "C-<f8>") 'org-narrow-to-subtree)
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

(global-set-key (kbd "S-<f8>") 'widen)


;;;;;;;;;
;; F9
;;;;;;;;




;;;;;;;;
;; F10
;;;;;;;;

(global-set-key (kbd "<f10>") 'smart-compile)
;(global-set-key (kbd "M-<f10>") 'org-copy-special)
;(global-set-key (kbd "S-<f10>") 'org-paste-special)

;(global-set-key (kbd "<f10>") 'org-clock-in)
;(global-set-key (kbd "C-<f10>") 'org-clock-out)
;(global-set-key (kbd "C-S-<f10>") 'org-clock-cancel)
;(global-set-key (kbd "M-<f10>") 'org-clock-jump-to-current-clock)
;(global-set-key (kbd "S-<f10>") 'org-clock-display)


;;;;;;;;
;; F11
;;;;;;;;

(global-set-key (kbd "<f11>") 'replace-regexp)


;;;;;;;;
;; F12
;;;;;;;;

(global-set-key (kbd "<f12>") 'apply-macro-to-region-lines)





;;;;;;;;
;; Others
;;;;;;;;
(global-set-key (kbd "C-c r") 'org-capture)
(global-set-key "\C-cc" 'org-capture)
(global-set-key (kbd "C-x z") 'repeat-complex-command)
(global-set-key (kbd "C-z")  'set-mark-command)
;(global-set-key "\C-x\C-b" 'buffer-menu)
(global-set-key (kbd "C-<backspace>") 'backward-kill-word)
(global-set-key (kbd "C-/") 'flyspell-check-previous-highlighted-word)
(global-set-key (kbd "C-1") 'jump-back-local-mark) ;jump back mark in local mark ring
(global-set-key (kbd "C-2") 'pop-global-mark) ; jump back to global mark ring
(global-set-key (kbd "C-+") (kbd "C-u C-_")) ; redo
(global-set-key (kbd "C-c o") 'occur)


(global-set-key (kbd "C-M-m") 'delete-minibuffer-contents)




(setq recentf-max-saved-items 200
      recentf-max-menu-items 15)
(recentf-mode)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Varibles
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-follow-mode-persistent t)
 '(org-agenda-files (quote ("~/Work/Notes_Planning/Projects_2016.org")))
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "LOGBOOK" "RESULTS" "NOTE")))
 '(org-indent-mode-turns-on-hiding-stars t)
 '(org-special-ctrl-a/e t)
 '(org-special-ctrl-k t)
 '(org-stuck-projects
   (quote
    ("+LEVEL=2/-DONE-MEMO-CANCELED"
     ("TODO" "NEXT" "NEXTACTION")
     nil ""))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.

(put 'upcase-region 'disabled nil)


(put 'narrow-to-region 'disabled nil)


(defun save-macro (name)
    "save a macro. Take a name as argument
     and save the last defined macro under
     this name at the end of your .emacs"
     (interactive "Name of the macro :")  ; ask for the name of the macro
     (kmacro-name-last-macro name)         ; use this name for the macro
     (find-file user-init-file)            ; open ~/.emacs or other user init file
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer


(defun ridm ()
  "Remove intrusive CTRL-Ms from the buffer"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (replace-string "\C-m\C-j" "\C-j")))
