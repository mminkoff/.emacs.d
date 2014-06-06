 Commands to zoom font size.

 A few commands are provided for zooming a frame or buffer, so that
 its font becomes larger or smaller.  For example, bind `zoom-in'
 and `zoom-out' to mouse wheel events to get the zooming effect you
 are used to in a Web browser.

 With Emacs 20, 21, and 22, you can zoom a frame.  Starting with
 Emacs 23, you can zoom either a frame (all buffers shown there) or
 a single buffer (in all frames where it is displayed).  User
 option `zoom-frame/buffer' determines which kind of zooming (frame
 or buffer) is done.  You can customize this option, but you can
 also toggle it just by providing a prefix arg (`C-u') to `zoom-in'
 or `zoom-out'.

 Note on saving changes made with the commands defined here:

   Some of the commands defined here change frame properties.  You
   can save any changes you have made, by using Customize.  To
   visit a Customize buffer of all unsaved changes you have made,
   use command `customize-customized'.

   Frame parameter changes, such as font size, can be saved for
   future use by all frames or all frames of a certain kind.  For
   that, you must change the frame parameters of the correponding
   frame-alist variable.

   There is no single variable for saving changes to parameters of
   the current frame.  Instead, there are several different
   frame-alist variables, which you can use to define different
   kinds of frames.  These include: `default-frame-alist',
   `initial-frame-alist', and `special-display-frame-alist'.  The
   complete list of such frame alist variables is available using
   function `frame-alist-var-names', defined in library
   `frame-cmds.el'.

   Example: Suppose you change the font size of a frame and want to
   make that the default font size for new frames in the future.
   You will need to update the value of variable
   `default-frame-alist' to use the `font' parameter setting of the
   changed frame.

   You can easily copy one or all parameter values from any given
   frame to any frame alist (such as `default-frame-alist'), by
   using the commands `set-frame-alist-parameter-from-frame' and
   `set-all-frame-alist-parameters-from-frame'.  Those commands are
   defined in library `frame-cmds.el'.


 Commands defined here:

   `toggle-zoom-frame', `zoom-frm-in', `zoom-frm-out',
   `zoom-frm-unzoom', `zoom-in', `zoom-out'.


 User options (variables) defined here:

   `frame-zoom-font-difference', `zoom-frame/buffer' (Emacs 23+).


 Put this in your init file (`~/.emacs'): (require 'zoom-frm)

 Suggested key bindings:

 (global-set-key (if (boundp 'mouse-wheel-down-event) ; Emacs 22+
                     (vector (list 'control mouse-wheel-down-event))
                   [C-mouse-wheel])    ; Emacs 20, 21
                 'zoom-in)
 (when (boundp 'mouse-wheel-up-event) ; Emacs 22+
   (global-set-key (vector (list 'control mouse-wheel-up-event))
                   'zoom-out))

 (global-set-key [S-mouse-1]    'zoom-in)
 (global-set-key [C-S-mouse-1]  'zoom-out)
 ;; Get rid of `mouse-set-font' or `mouse-appearance-menu':
 (global-set-key [S-down-mouse-1] nil)

 The first two of these mean that in Emacs 22 or later you can hold
 the Control key and rotate the wheel to zoom in and out, just as
 you do in your Web browser.  In Emacs 20 and 21, however, Control
 plus wheeling zooms in, but to zoom out you need to use `C--'
 before wheeling with Control.  This is because Emacs 20 and 21 do
 not have separate events for the mouse wheel directions, and it is
 the prefix arg, not the wheel direction, that determines the
 effect.

 Note: You can bind the zooming commands to keyboard events, as
 well as to mouse events.  You could do this, for instance:

 (global-set-key [(control shift ?z)]  'zoom-in)  ; `C-S-z'
 (global-set-key [(control ?z)]        'zoom-out) ; `C-z'


 See also these files for other frame commands:

    `autofit-frame.el' - Automatically fit each frame to its
                         selected window.  Uses `fit-frame.el'.

    `fit-frame.el'     - 1) Fit a frame to its selected window.
                         2) Incrementally resize a frame.

    `doremi-frm.el'    - Incrementally adjust frame properties
                         using arrow keys and/or mouse wheel.

    `frame-cmds.el'    - Miscellaneous frame and window commands.

    `thumb-frm.el'     - Shrink frames to a thumbnail size and
                         restore them again.
