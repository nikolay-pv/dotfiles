;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "User"
      user-mail-address "user@example.com")

;; maximize on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 12))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; imenu
;; (map! :leader
;;       (:prefix-map ("t" . "toggle")
;;                    (:desc "imenu-list" "i" #'lsp-ui-imenu)))

;; shortcuts
;; (map! "s-o"
;;       (:desc "find-other-file" #'lsp-clangd-find-otehr-file))
;; (map! :leader
;;       (:prefix-map ("c" . "code")
;;                    (:desc "find-other-file" "h" #'lsp-clangd-find-otehr-file)))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; make C-n C-p work in minibuffer
(define-key minibuffer-local-map (kbd "C-n") #'next-line-or-history-element)
(define-key minibuffer-local-map (kbd "C-p") #'previous-line-or-history-element)

;; Enable spellcheck because I need it
(setq flycheck-check-syntax-automatically '(save mode-enable))

;; style changes
(c-set-offset 'innamespace 0)


;; LSP
(after! lsp-mode
  (setq lsp-semantic-tokens-mode 't))

;; c++
(after! cc-mode
  (set-eglot-client! 'cc-mode '("clangd"
                                "--pch-storage=memory"
                                "-j=6"
                                "--background-index"
                                "--clang-tidy"
                                "--cross-file-rename"
                                "--query-driver=/urs/bin/clang++"
                                "--completion-style=detailed")))


;; blamer.el
(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                   :background nil
                   :height 100
                   :italic t)))
  :config
  (global-blamer-mode 1))


(use-package ellama
  :ensure t
  ;; :bind ("C-c e" . ellama-transient-main-menu)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init (setopt ellama-auto-scroll t)
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1)
  (require 'llm-ollama)
  (setopt ellama-provider
      (make-llm-ollama
       :chat-model "llama3.1:8b"
       :embedding-model "nomic-embed-text"
       :default-chat-non-standard-params '(("num_ctx" . 8192))))
  (setopt ellama-summarization-provider
      (make-llm-ollama
       :chat-model "llama3.1:8b"
       :embedding-model "nomic-embed-text"
       :default-chat-non-standard-params '(("num_ctx" . 32768))))
  (setopt ellama-coding-provider
      (make-llm-ollama
       :chat-model "qwen2.5-coder:7b"
       :embedding-model "nomic-embed-text"
       :default-chat-non-standard-params '(("num_ctx" . 32768))))
  )
