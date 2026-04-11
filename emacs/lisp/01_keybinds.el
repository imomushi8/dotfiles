;;; 02_keybinds.el --- カスタムキーバインド設定

; 移動のキーはvimっぽくしたい。C-M-の場合に高速移動、M-のときは行頭・行末、ファイル先頭・末尾
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

(provide '01_keybinds)
