;; (setq user-emacs-directory "~/.emacs.d/") ;; emacsのディレクトリを設定（いらんと思うけど）
(custom-set-faces) ;; 警告抑制

;;--------------------------------------------------------------------------------------
;; システム系設定
;;(menu-bar-mode 0)               ;; ここは慣れたら消す
;;(tool-bar-mode 0)               ;; ここは慣れたら消す
(setq inhibit-startup-message t)  ;; ウェルカムページを消す
(setq initial-scratch-message "") ;; スクラッチページのコメントを消す
(setq make-backup-files nil)      ;; *.~ とかのバックアップファイルを作らない
(setq auto-save-default nil)      ;; .#* とかのバックアップファイルを作らない
(setq default-frame-alist         ;; 起動時のフレームの大きさを設定
    (append (list
             '(width . 120)
             '(height . 40)
             '(top . 0)
             '(left . 0)
             )
            default-frame-alist))

;; 言語・フォント設定
(set-frame-parameter nil 'alpha 92)
(set-frame-font "JetBrainsMono NF 10")
(set-language-environment 'Japanese)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)


;;--------------------------------------------------------------------------------------
;; コーディング設定
(setq scroll-conservatively 35)           ; スクロールを一行ずつにする
(setq scroll-margin 0)
(setq scroll-step 1)
(electric-indent-mode t)                  ; 改行時にインデントを保つ
(global-auto-revert-mode t)               ; バッファーを自動的に最新に保つ
(global-display-line-numbers-mode t)      ; 行番号表示

;; 移動のキーはvimっぽくしたい。C-M-の場合に高速移動、M-のときは行頭・行末、ファイル先頭・末尾
(global-set-key (kbd "C-h") 'backward-char)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-M-h") 'backward-word)
(global-set-key (kbd "C-M-j") '(lambda () (interactive) (next-line 5)))
(global-set-key (kbd "C-M-k") '(lambda () (interactive) (previous-line 5)))
(global-set-key (kbd "C-M-l") 'forward-word)
(global-set-key (kbd "M-h") 'move-beginning-of-line)
(global-set-key (kbd "M-j") 'end-of-buffer)
(global-set-key (kbd "M-k") 'beginning-of-buffer)
(global-set-key (kbd "M-l") 'move-end-of-line)


;;--------------------------------------------------------------------------------------
;; パッケージの設定
(load "$XDG_CONFIG_HOME/emacs/lisp/00_leaf_conf.el")
(load "$XDG_CONFIG_HOME/emacs/lisp/01_leaf_packages.el")

;; Org modeの設定
(setq org-directory "$XDG_CONFIG_HOME/emacs/org")     ;; ファイルの場所
(setq org-default-notes-file "notes.org")

(global-hl-line-mode t)                   ; 現在行をハイライト
(custom-set-faces '(hl-line ((t (:background "DeepPink4"))))) ; ハイライトのカスタマイズ
(show-paren-mode t)                       ; 対応する括弧をハイライト
(setq show-paren-style 'mixed)            ; 括弧のハイライトの設定 (parenthesis/expression/mixed)
(transient-mark-mode t)                   ; 選択範囲をハイライト

(provide 'init)
