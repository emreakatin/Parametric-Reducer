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

; civata kodları

  (defun civata ()
  
  (command "osmode" 0)
  (command "erase" "all" "")
  (command "view" "swiso" "")
  (command "shademode" "g" "")
  
  
  
  (princ "\TS EN 24018 STANDARDINA UYGUN BiR DEÐER GÝRÝNÝZ...(metrik : 6-8-10)")(terpri)
  (setq d (getreal "\nAnma Capini Giriniz :"))


  (if (= d 6)
    (progn
       (setq hatve 1.00)
       (setq k 7.45)
       (setq da 14.45)
       (setq v 6)
       (setq r 0.11)
       (setq e 5.72)
    
      ))

  (if (= d 8)
    (progn
       (setq hatve 1.25)
       (setq k 9.45)
       (setq da 20.55)
       (setq v 8)
       (setq r 0.14)
       (setq e 6.86)
    
      ))
  
  (if (= d 10)
    (progn
       (setq hatve 1.50)
       (setq k 11.45)
       (setq da 24.55)
       (setq v 10)
       (setq r 0.16)
       (setq e 9.15)
      
      ))
                                     
                         
(setq disboyu (* 3.5 d))
(setq anmaboyu (* 4.5 d))
  
(setq pmer3 (list 0 0 0))
(command "polygon" "4" pmer3 "c" (/ v 2) "")
(setq pol1 (entlast))
(command "extrude" pol1 "" (- k (/ k 3.5)) "") 
(command "ucs" pmer3 "")	
(command "circle" "0,0,0" (/ da 2) "")  
(setq cember2 (entlast))  
(command "ucs" "y" 180)  
(command "extrude" cember2 "" "t" 30 (/ k 3.5) "")
(command "union" "all" "")
(setq polymerkez (list 0 0 (/ k 3.5)))  
(command "polygon" 6 polymerkez "i" (/ da 2) "")  
(command "ucs" "y" 180)  
(setq cokgen (entlast))  
(command "extrude" cokgen "" k "")
(command "intersect" "all" "")
(setq merkezyeni (list 0 0 (- k (/ k 3.5)))) 
(command "ucs" merkezyeni "") 
(setq boymerkez (list 0 0 0)) 
(command "circle" boymerkez (/ d 2) "")  
(command "extrude" "last" "" anmaboyu"")  
(setq silindir (entlast))
(command "union" "all" "")
(setq hmz (- anmaboyu disboyu)) 
(setq helixmerkez (list 0 0 hmz)) 
(setq turn (fix(+(/ disboyu hatve)2))) 
(command "helix" helixmerkez (/ d 2)(/ d 2) "t" turn "h" hatve "" )  
(setq helix (entlast))
(setq yenimerkez (list 0 0 anmaboyu))
(command "ucs" yenimerkez "")  
(command "circle" "0,0,0" (/ d 2) "")  
(setq pahcember (entlast))  
(command "extrude" pahcember "" "t" 30 (/ hatve 1.5) "") 
(setq pahlýcember (entlast))  
(command "union" pahlýcember silindir "")  
(setq civataboyu (entlast))  
(setq eskimerkez (list 0 0 (- anmaboyu (* anmaboyu 2))))  
(command "ucs" eskimerkez "") 
(setq ucgenmerkez(list (/ d 2) 0 (- anmaboyu disboyu))) 
(command "ucs" ucgenmerkez "")  
(command "ucs" "x" 90 "")  
(setq merkezyeni2 (list 0 0 0))  
(setq ucgencemberyaricapi (* hatve 0.576))  
(command "polygon" 3 merkezyeni2 "i" ucgencemberyaricapi "")  
(setq ucgen (entlast))  
(command "fillet" "r" r "")  
(command "fillet" "p" ucgen)  
(command "rotate" ucgen "" merkezyeni2 90)
(setq ucgentasimamerkez (list ucgencemberyaricapi 0 0))  
(command "move" ucgen "" merkezyeni2 ucgentasimamerkez "")  
(command "ucs" "y" 180)  
(setq ucgentasimamerkez2 (list (* hatve 0.8660) 0 0))  
(command "move" ucgen "" merkezyeni2 ucgentasimamerkez2 "")
(setq kaymamerkez (list -0.25 0 0))  
(command "move" ucgen"" merkezyeni2 kaymamerkez "")
(command "sweep" ucgen"" "b" merkezyeni2 helix)  
(setq yay (entlast))  
(command "subtract" civataboyu"" yay"")
(command "union" "all" "")
(command "erase" helix "")
(setq boltlast (entlast))
(command "shademode" "g" "c" "")   
(command "zoom" "e")

)


(defun c:Disli ()
  
  (gear)
  (gear1)
  
  (setq civ (getreal "\n civata baskmak ister misiniz evet ise 1 e basınız "))
  
  (if (= civ 1) 
  
  
  (civata) 
    
  )
  
)