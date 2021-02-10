;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "User"
      user-mail-address "user@example.com")

;; start in fullscreen
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 12))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; ===== imenu-list =====
(after! imenu-list
  (set-popup-rule! "^\\*Ilist"
    :side 'right :size 35 :quit nil :select nil :ttl 0)
  (setq imenu-list-focus-after-activation t))

(map! :leader
      (:prefix-map ("t" . "toggle")
       (:desc "imenu-list" "i" #'imenu-list-smart-toggle)))

;; ===== shortcuts =====
(map! :leader
      (:prefix-map ("c" . "code")
       (:desc "find-other-file" "h" #'ff-find-other-file)))

(map! :leader
      (:prefix-map ("t" . "toggle")
       (:desc "popup" "p" #'+popup/toggle)))

(map! :leader
      (:prefix-map ("b" . "buffer")
       (:desc "mark whole buffer" "h" #'mark-whole-buffer)))

(defun copy-current-line-position-to-clipboard ()
  "Copy current line in file to clipboard as '</path/to/file> <line-number>'"
  (interactive)
  (let ((path-with-line-number
         (concat (buffer-file-name) " " (number-to-string (line-number-at-pos)))))
    (x-select-text path-with-line-number)
    (message (concat path-with-line-number " copied to clipboard"))))

(map! :leader
      (:prefix-map ("c" . "code")
       (:desc "copy-file-line" "g" #'copy-current-line-position-to-clipboard)))

;; ===== org =====
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;; journal for personal use
(setq org-journal-dir "~/org/journal/")
(setq org-journal-file-type 'weekly)
;; set up publishing
(require 'ox-publish)
;; https://github.com/gongzhitaao/orgcss
(setq org-html-htmlize-output-type 'inline-css)
;; supress headlines numbering
(setq org-export-with-section-numbers nil)
;; shorter name for Table of Contents
(setq org-beamer-outline-frame-title "")
(setq org-publish-project-alist
      '(
      ("org-notes"
      :base-directory "~/org/"
      :base-extension "org"
      :publishing-directory "~/org_html/"
      :recursive t
      :publishing-function org-html-publish-to-html
      :headline-levels 4             ; Just the default for this project.
      :auto-preamble t
      )
      ("org-static"
      :base-directory "~/org/"
      :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
      :publishing-directory "~/org_html/"
      :recursive t
      :publishing-function org-publish-attachment
      )
      ("org" :components ("org-notes" "org-static"))
      ))

;; enable org-crypt
;; Specify :crypt: tag to encrypt only part of org file
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
;; GPG key to use for encryption
;; Either the Key ID or set to nil to use symmetric encryption.
(setq org-crypt-key nil)

;; add auto-export for ~/org
(defun auto-publish-org-files-hook ()
  "Auto publish org files on save to local html pages"
  ;; check if saved file is part of blog
  (if (org-publish-get-project-from-filename
       (buffer-file-name (buffer-base-buffer)) 'up)
      (save-excursion (org-publish-current-file)
                      (message "auto published org files") nil)))
;; Enable auto-publish when a org file when saved
(add-hook 'org-mode-hook
          (lambda ()
            (add-hook 'after-save-hook 'auto-publish-org-files-hook nil nil)))

;; set up deft
(setq deft-directory "~/org/")
;; set up roam
(setq org-roam-directory "~/org")

(setq org-roam-capture-templates
      '(
        ("d" "default" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_tags: private\n\n#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\"/>\n#+OPTIONS: author:nil date:nil toc:nil\n"
         :unnarrowed t)
        ("w" "work" plain (function org-roam--capture-get-point)
         "%?"
         :file-name "work/%<%Y%m%d%H%M%S>-${slug}"
         :head "#+title: ${title}\n#+roam_tags: work\n\n#+HTML_HEAD: <link rel=\"stylesheet\" type=\"text/css\" href=\"../css/style.css\"/>\n#+OPTIONS: author:nil date:nil toc:nil\n"
         :unnarrowed t)
))


;; ===== Elfeed =====
;; rss feed: auto update
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)
(setq-default elfeed-search-filter "@2-week-ago +unread ")

;; make C-n C-p work in minibuffer
(define-key minibuffer-local-map (kbd "C-n") #'next-line-or-history-element)
(define-key minibuffer-local-map (kbd "C-p") #'previous-line-or-history-element)

;; associate major-modes with extension
(add-to-list 'auto-mode-alist '("\\.ipp\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.xrc\\'" . nxml-mode))

;; force use of clangd
(after! lsp-clients
  (set-lsp-priority! 'clangd 1))  ; ccls has priority 0

(after! lsp-clients
  (setq lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--header-insertion=never"))
  (setq lsp-clients--clang-default-executable
        "~/Documents/tools/clang-llvm/build/bin/clangd"))


(set-docsets! 'cc-mode "C++" "C")
(set-docsets! 'py-mode "Python3" "Pandas" "NumPy")
(set-docsets! 'cmake-mode "CMake")

;; camelcase spellcheck
(setq-default ispell-extra-args '("--sug-mode=ultra"
                                  "--lang=en_US"
                                  "--camel-case"
                                  "--ignore=3")) ;; aspell ignores words <= 3

;; open urls in xwidgets
(setq +lookup-open-url-fn #'+lookup-xwidget-webkit-open-url-fn)

;; Enable spellcheck because I need it
(setq flycheck-check-syntax-automatically '(save mode-enable))
;; (after! org (add-hook 'org-mode-hook 'turn-on-flyspell))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; style changes
(c-set-offset 'innamespace 0)

;; completion Company
(setq company-lsp-cache-candidates 'auto)
(setq company-lsp-async t)
(setq company-lsp-enable-snippet t)
(setq company-lsp-enable-recompletion t)

(set-company-backend! '(c-mode c++-mode objc-mode)
      '(company-lsp :with company-yasnippet))


;; extensions
(defun +default/yank-buffer-filename-last-component ()
  "Copy the last component of the current buffer's path to the kill ring."
  (interactive)
  (if-let (filename (or buffer-file-name (bound-and-true-p list-buffers-directory)))
      (message (kill-new (file-name-nondirectory filename)))
    (error "Couldn't find filename in current buffer")))

(map! :leader
      (:prefix-map ("f" . "file")
       (:desc "yank filename only" "Y" #'+default/yank-buffer-filename-last-component)))
