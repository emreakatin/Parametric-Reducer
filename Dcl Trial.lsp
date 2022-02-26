(defun C:samp4 ()					;define function
 
  (setq dcl_id (load_dialog "samp4.dcl"))		;load dialog
 
  (if (not (new_dialog "samp4" dcl_id)			;test for dialog
 
      );not
 
    (exit)						;exit if no dialog
 
  );if
 
  (setq w (dimx_tile "im")				;get image tile width
        h (dimy_tile "im")				;get image tile height
 
);setq
 
  (start_image "im")					;start the image
  (fill_image 0 0 w h 5)				;fill it with blue
  (end_image)						;end image
 
  (action_tile "rb1" "(setq hole \"site\")")		;store hole type
  (action_tile "rb2" "(setq hole \"shop\")")		;store hole type
  (action_tile "rb3" "(setq hole \"hid\")")		;store hole type
  (action_tile "rb4" "(setq hole \"ctsk\")")		;store hole type
  (action_tile "rb5" "(setq hole \"elev\")")		;store hole type
  (action_tile "rb6" "(setq hole \"slot\")")		;store hole type
 
 
    (action_tile
    "cancel"						;if cancel button pressed
    "(done_dialog) (setq userclick nil)"		;close dialog, set flag
    );action_tile
 
  (action_tile
    "accept"						;if O.K. pressed
    " (done_dialog)(setq userclick T)"			;close dialog, set flag
  );action tile
 
  (start_dialog)					;start dialog
 
  (unload_dialog dcl_id)				;unload
 
(princ)
 
);defun C:samp
 
(princ)