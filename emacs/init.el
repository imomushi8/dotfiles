(defconst emacs-config-dir (expand-file-name "emacs" (or (getenv "XDG_CONFIG_HOME") "~/.config"))
    "Directory to store Emacs config files.")
(defconst emacs-cache-dir (expand-file-name "emacs" (or (getenv "XDG_CACHE_HOME") "~/.cache"))
    "Directory to store Emacs cache files.")

(setq user-emacs-directory emacs-config-dir) ;; emacsのディレクトリを設定
(custom-set-faces) ;; 警告抑制

;--------------------------------------------------------------------------------------
; システム系設定
(menu-bar-mode 0)                 ;; メニューバーを消す
(tool-bar-mode 0)                 ;; ツールバーを消す
(setq inhibit-startup-message t)  ;; ウェルカムページを消す
(setq initial-scratch-message "") ;; スクラッチページのコメントを消す
(setq make-backup-files nil)      ;; *.~ とかのバックアップファイルを作らない
(setq auto-save-default nil)      ;; .#* とかのバックアップファイルを作らない
(setq auto-save-list-file-prefix (expand-file-name "auto-save-list/.saves-" emacs-cache-dir)) ;; auto-save-listをXDG_CACHE_HOMEに移動
(setq server-auth-dir (expand-file-name "server/" emacs-cache-dir)) ;; serverフォルダをXDG_CACHE_HOMEに移動

(setq default-frame-alist         ;; 起動時のフレームの大きさを設定
    (append (list
        '(width . 120)
        '(height . 40)
        '(top . 0)
        '(left . 0)
    ) default-frame-alist))

; 言語・フォント設定
(set-frame-parameter nil 'alpha 92)
(set-frame-font "JetBrainsMono NF 10")
(set-language-environment 'Japanese)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)

; コーディング設定
(setq scroll-conservatively 35)           ; スクロールを一行ずつにする
(setq scroll-margin 0)
(setq scroll-step 1)
(electric-indent-mode t)                  ; 改行時にインデントを保つ
(global-auto-revert-mode t)               ; バッファーを自動的に最新に保つ
(global-display-line-numbers-mode t)      ; 行番号表示

;--------------------------------------------------------------------------------------
; キーバインドの設定
(load "$XDG_CONFIG_HOME/emacs/lisp/01_keybinds.el")

;--------------------------------------------------------------------------------------
; パッケージの設定
(load "$XDG_CONFIG_HOME/emacs/lisp/02_leaf_conf.el")
(load "$XDG_CONFIG_HOME/emacs/lisp/03_leaf_packages.el")
(load "$XDG_CONFIG_HOME/emacs/lisp/99.wanderlust.el")


;--------------------------------------------------------------------------------------
; Org modeの設定
(setq org-directory "$XDG_CONFIG_HOME/emacs/org") ; ファイルの場所
(setq org-default-notes-file "notes.org")

(global-hl-line-mode t)        ; 現在行をハイライト
(show-paren-mode t)            ; 対応する括弧をハイライト
(setq show-paren-style 'mixed) ; 括弧のハイライトの設定 (parenthesis/expression/mixed)
(transient-mark-mode t)        ; 選択範囲をハイライト

(provide 'init)
