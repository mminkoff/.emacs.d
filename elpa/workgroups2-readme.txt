Workgroups2 is an Emacs session manager. It is based on the
experimental branch of the original "workgroups" extension.


Install
----------------------
See the README.md file at: https://github.com/pashinin/workgroups2
Add this lines to your .emacs configuration:

(require 'workgroups2)

Some settings:
(desktop-save-mode t)                ; save opened files
(setq wg-prefix-key (kbd "C-c z")
      wg-use-default-session-file nil ; turn off for "emacs --daemon"
      wg-default-session-file "~/.emacs_files/workgroups"
      wg-use-faces nil
      wg-morph-on nil)               ; animation off

Keyboard shortcuts - load, save, switch
(global-set-key (kbd "<pause>")     'wg-reload-session)
(global-set-key (kbd "C-S-<pause>") 'wg-save-session)
(global-set-key (kbd "s-z")         'wg-switch-to-workgroup)
(global-set-key (kbd "s-/")         'wg-switch-to-previous-workgroup)

(workgroups-mode 1)    ; Activate workgroups


Usage
----------------------
All commands start with prefix `wg-prefix-key' (see above).
<prefix>-<key>

<prefix>-c    - create workgroup
<prefix>-k    - kill workgroup
<prefix>-v    - switch to workgroup
<prefix>-C-z  - save session
<prefix>-C-f  - load session

Help
----------------------
Type "<prefix>-?" for more help
