(defun c:sbtr()
(setq çap (getreal "\n Mil çapýný giriniz (min 0 max 80) :"))


(setq b 0)
(setq d1 0)
(setq D 0)
(command "erase" "all" "" "")

   (if  (>= çap 0)
   (if  (<= çap 10)                 
   (progn

(setq b 8.0)
(setq d1 10.0)
(setq D 28.0)
(setq y 6)
(setq rs 0.3)
)))

   (if  (>= çap 11)
   (if  (<= çap 12)
   (progn

(setq b 8.0)
(setq d1 12.0)
(setq D 30.0)
(setq y 6)
(setq rs 0.3)
)))

  (if  (>= çap 13)
  (if  (<= çap 15)
  (progn

(setq b 8.0)
(setq d1 15.0)
(setq D 35.0)
(setq y 7)
(setq rs 0.3)
)))

  (if  (>= çap 16)
  (if  (<= çap 20)
  (progn

(setq b 8.0)
(setq d1 20.0)
(setq D 42.0)
(setq y 8)
(setq rs 0.3)
)))

  (if  (>= çap 21)
  (if  (<= çap 25)
  (progn

(setq b 8.0)
(setq d1 25.0)
(setq D 47.0)
(setq y 10)
(setq rs 0.3)
)))

  (if  (>= çap 26)
  (if  (<= çap 30)
  (progn


(setq b 9.0)
(setq d1 30.0)
(setq D 55.0)
(setq y 10)
(setq rs 0.3)
)))

  (if  (>= çap 31)
  (if  (<= çap 35)
  (progn

(setq b 9.0)
(setq d1 35.0)
(setq D 62.0)
(setq y 15)
(setq rs 0.3)
)))

  (if  (>= çap 36)
  (if  (<= çap 40)
  (progn

(setq b 9.0)
(setq d1 40.0)
(setq D 68.0)
(setq y 15)
(setq rs 0.3)
)))

  (if  (>= çap 41)
  (if  (<= çap 45)
  (progn
    
(setq b 10.0)
(setq d1 45.0)
(setq D 75.0)
(setq y 18)
(setq rs 0.6)
)))

  (if  (>= çap 46)
  (if  (<= çap 50)
  (progn

(setq b 10.0)
(setq d1 50.0)
(setq D 80.0)
(setq y 18)
(setq rs 0.6)
)))

  (if  (>= çap 51)
  (if  (<= çap 55)
  (progn
      
(setq b 11.0)
(setq d1 55.0)
(setq D 90.0)
(setq y 20)
(setq rs 0.6)
)))

  (if  (>= çap 56)
  (if  (<= çap 60)
  (progn
      
(setq b 11.0)
(setq d1 60.0)
(setq D 95.0)
(setq y 20)
(setq rs 0.6)
)))

  (if  (>= çap 61)
  (if  (<= çap 65)
  (progn
      
(setq b 11.0)
(setq d1 65.0)
(setq D 100.0) 
(setq y 20)
(setq rs 0.6)
)))

  (if  (>= çap 66)
  (if  (<= çap 70)
  (progn
      
(setq b 13.0)
(setq d1 70.0)
(setq D 110.0)
(setq y 20)
(setq rs 0.6)
)))

  (if  (>= çap 71)
  (if  (<= çap 75)
  (progn
      
(setq b 13.0)
(setq d1 75.0)
(setq D 115.0)
(setq y 20)
(setq rs 0.6)
)))

  (if  (>= çap 76)
  (if  (<= çap 80)
  (progn
      
(setq b 14.0)
(setq d1 80.0)
(setq D 125.0)
(setq y 20)
(setq rs 0.6)
)))

  ;Hesaplamalar  
  (setq a  (- (/ D 2.0) (/ d1 2.0)))
  
  (setq l1 (list 0 (+ (/ d1 2.0) (* (/ a 3.0 ) 2.0))))
  (setq l2 (list 0 (+ (/ d1 2.0)  (- a 0.3))))
  (setq l3 (list 0.3 (+ (/ d1 2.0) a)))
  (setq l4 (list (- b 0.3 ) (+(/ d1 2.0) a)))
  (setq l5 (list b (-(+ (/ d1 2.0) a)0.3)))
  (setq l6 (list b (+(/ d1 2.0) (* (/ a 3.0 ) 2.0))))

  (setq m1 (list  0 (+(/ d1 2.0) (/ a 2.0))))
  (setq m2 (list  b (+(/ d1 2.0) (/ a 2.0))))
  
  (setq c1 (list (/ b 2.0) (+(/ d1 2.0) (/ a 2.0))))
  (setq c2 (+(/(/ a 3.0)2.0) (* (/(/ a 3.0)2.0) 0.2)))

  (setq k1 (list (/ b 2) (+(+(/ d1 2) (/ a 2)) c2 ))) 
  (setq k2 (list (/ b 2) (+(/ d1 2))))
  
  (setq t2 (list (+ (car l1) (/ b 2)) (cadr l1) (caddr l1)))
  (setq t3 (list (car c1) (+ (cadr c1) (/ a 12)) (caddr c1)))
  
  (setq s (/(* 0.6 b)2))
  
  (command "osmode" "0" )
  (command "ucs" "w"  )
  ;BilezikLer
  (command "line" l1 l2 "")
  (command "line" l3 l4 "")
  (command "line" l5 l6 "")
  
  (command "arc" l3 "E" l2  "R" rs "")
  (command "arc" l5 "E" l4  "R" rs "")
  
  (command "circle" c1 s "")                 
  (setq secme (ssget "l"))
  (command "line" l1 l6 "")                
  (setq sec (ssget "l"))
  (command "trim" sec "" secme "" )  
  (command "trim" secme "" t2 "")
  (command "trim" secme "" "f" k1 k2 "" "")
  (setq hepsi (ssget "x"))
  (command "mirror" hepsi "" m1 m2 "")
  (command "pedit" "l" "" "j" "all" "" "" )
  (command "revolve" "all" "" "x" "360" "")
  (command "view" "swiso")
  (command "zoom" "e" "")
  
  ;Bilyeler
  (command "sphere" c1 s "") 
  (command "ucs" "y" "")
  (command "array" "l" "" "p" 0 y "" "")
  (command "shademode" "g" "c" "")
  (command "change" "all" "" "p" "color" "253" "")


  )