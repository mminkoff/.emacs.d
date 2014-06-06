;;; zop-to-char.el --- A replacement of zap-to-char.
;; Version: 20140416.1015

;; Author: Thierry Volpiatto <thierry.volpiatto@gmail.com>
;; Copyright (C) 2010~2014 Thierry Volpiatto, all rights reserved.
;; X-URL: https://github.com/thierryvolpiatto/zop-to-char
;; Package-Requires: ((cl-lib "0.5"))

;; Compatibility: GNU Emacs 23.1+

;; This file is not part of GNU Emacs. 

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;; 
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;; 
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;; Install:

;; (require 'zop-to-char)
;; To replace `zap-to-char':
;; (global-set-key (kbd "M-z") 'zop-to-char)

;;; Code:

(require 'cl-lib)

;; Internal
(defvar zop-to-char--delete-up-to-char nil)

;;;###autoload
(defun zop-to-char (arg)
  "An enhanced version of `zap-to-char'."
  (interactive "p")
  (let* ((pos    (point))
         (ov     (make-overlay pos (1+ pos)))
         (char   "")
         (prompt (propertize "Zap to char: " 'face 'minibuffer-prompt))
         (doc    (propertize
                  "   [RET/C-k:kill, C-c:copy, C-f/right:next, C-b/left:prec, C-g:abort, C-q:quit, DEL:erase]"
                  'face 'minibuffer-prompt)))
    (overlay-put ov 'face 'region)
    (unwind-protect
         (while (let ((input (read-key (concat prompt char doc)))
                      (beg   (overlay-start ov))
                      (end   (overlay-end ov)))
                  (cl-case input
                    ((?\r ?\C-k)   ; Kill region.
                     (kill-region
                      beg (if zop-to-char--delete-up-to-char
                              (1- end) end)) nil)
                    (?\C-c         ; Copy region.
                     (copy-region-as-kill
                      beg (if zop-to-char--delete-up-to-char
                              (1- end) end))
                     (goto-char pos) nil)
                    ((right ?\C-f) ; Next occurence.
                     (setq arg 1) t)
                    ((left ?\C-b)  ; Prec occurence.
                     (setq arg -1) t)
                    ((?\d ?\C-d)   ; Erase input.
                     (setq char "") (goto-char pos) t)
                    (?\C-q nil)    ; Quit at point
                    ((?\C-g ?\e)   ; Quit at pos.
                     (goto-char pos) nil)
                    (t             ; Input string.
                     (when (characterp input)
                       (setq char (string input))))))
           (if (< arg 0)
               (search-backward char nil t (- arg))
               (forward-char 1)
               (search-forward char nil t arg)
               (forward-char -1))
           (if (< (point) pos)
               (move-overlay ov (1+ pos) (point))
               (move-overlay ov pos (1+ (point)))))
      (message nil)
      (delete-overlay ov))))

;;;###autoload
(defun zop-up-to-char (arg)
  "Same as `zop-to-char' but stop just before target.
Same as `zap-up-to-char'."
  (interactive "p")
  (let ((zop-to-char--delete-up-to-char t))
    (zop-to-char arg)))

(provide 'zop-to-char)

;;; zop-to-char.el ends here.
