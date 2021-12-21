(defun grinf ()
  (setq cp (getpoint "\nCENTER OF GEAR:"))
  (setq cc (list (+ (car cp) 50) (cadr cp) (caddr cp)))
  (setq teeth (getint "\nNUMBER OF TEETH: "))
   (while (< teeth 14)
    (setq teeth (getint "\nMUST BE AT LEAST 14 TEETH: "))
   )
)

(defun dtr (a)
  (* pi (/ a 180.0))
)
(defun grcalc ()
   (setq pc (polar cp 0 (distance cp cc)))
   (setq dptch
        (/ teeth (* 2.0 (distance cp pc))))
   (setq htooth
        (/ 0.32 dptch))
   (setq xtooth
        (/ 1.0 dptch))
   (setq side
        (* (/ 2.257 dptch) 1.0642))
)
(defun grdrw ()
   (command "PLINE"
     (polar pc 0 xtooth) "a" "ce" cp "l" htooth "l"
    (polar (getvar "lastpoint")
           (dtr 160)
           side)
    "A"
    "CE"
   cp
   "L"
   htooth
   ""
 )
 (command "MIRROR" "l" "" pc cp "n")
 (command "ARRAY"
    "c"
    (polar pc (dtr 135) side)
    (polar pc (dtr 315) side)
    ""
    "p"
    cp
    teeth
    ""
    "")
  ) ; End of GRDRW function






(defun grinf1 ()
  ;(setq cp1 (getpoint "\nCENTER OF GEAR:"))
  (setq cp1 (list (+ (car cp) 100) (cadr cp) (caddr cp)))
  (setq cc1 (list (+ (car cp1) 50) (cadr cp1) (caddr cp1)))
  (setq teeth1 (getint "\nNUMBER OF TEETH: "))
   (while (< teeth1 14)
    (setq teeth1 (getint "\nMUST BE AT LEAST 14 TEETH: "))
   )
)

(defun dtr1 (a)
  (* pi (/ a 180.0))
)
(defun grcalc1 ()
   (setq pc1 (polar cp1 0 (distance cp1 cc1)))
   (setq dptch1
        (/ teeth1 (* 2.0 (distance cp1 pc1))))
   (setq htooth1
        (/ 0.32 dptch1))
   (setq xtooth1
        (/ 1.0 dptch1))
   (setq side1
        (* (/ 2.257 dptch1) 1.0642))
)
(defun grdrw1 ()
   (command "PLINE"
     (polar pc1 0 xtooth1) "a" "ce" cp1 "l" htooth1 "l"
    (polar (getvar "lastpoint")
           (dtr1 160)
           side1)
    "A"
    "CE"
   cp1
   "L"
   htooth1
   ""
 )
 (command "MIRROR" "l" "" pc1 cp1 "n")
 (command "ARRAY"
    "c"
    (polar pc1 (dtr1 135) side1)
    (polar pc1 (dtr1 315) side1)
    ""
    "p"
    cp1
    teeth1
    ""
    "")
  ) ; End of GRDRW function




(defun gear ()
   
   (grinf)
   (setq oldblp (getvar "blipmode"))
   (setq oldech (getvar "cmdecho"))
   (setvar "blipmode" 0)
   (setvar "cmdecho" 0)
    (grcalc)
    (grdrw)
    (setvar "blipmode" oldblp)
    (SEtvar "cmdecho" oldech)
    
  
    

    
)

(defun gear1 ()
   
   (grinf1)
   (setq oldblp1 (getvar "blipmode"))
   (setq oldech1 (getvar "cmdecho"))
   (setvar "blipmode" 0)
   (setvar "cmdecho" 0)
    (grcalc1)
    (grdrw1)
    (setvar "blipmode" oldblp1)
    (SEtvar "cmdecho" oldech1)
    
  
    

    
)




(defun c:Disli ()
  
  (gear)
  (gear1)
  
  
    
  
)