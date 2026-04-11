;; secret.elが存在する場合だけメール設定する
(defvar my-secret-file (expand-file-name "secret.el" emacs-config-dir))
(when (file-exists-p my-secret-file)
  (load my-secret-file)

  (leaf wanderlust
    :ensure t
    :bind (("C-c m" . wl))  ;; C-c m でWanderlustを起動

    :config
    ;; Wanderlustの内部データ（~/.elmo）をキャッシュディレクトリに移動
    ;; ※emacs-cache-dir は init.el で定義した定数
    (setq elmo-msgdb-directory (expand-file-name "elmo" emacs-cache-dir))
    ))
