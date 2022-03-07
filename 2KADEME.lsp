(defun hels ()
   
   (progn
      	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
     
	  (setq mn 4 ) ;modül saysısı
    
    (setq girs (getint "\n enter first torque "))
    (setq cks (getint "\n enter second torque "))
     
    ;(initget 1 "1/2 1/4 1/6 1/7 1/8")
    
    (if (= (/ girs cks) 2) (setq z 20))
    (if (= (/ girs cks) 4) (setq z 40))
    (if (= (/ girs cks) 6) (setq z 60))
    (if (= (/ girs cks) 7) (setq z 70))
     
     
    ;(setq bcd (getkword "Enter reduce ratio: "))
    
  
	  ;(if (= bcd "1/2") (setq z 20))
	  ;(if (= bcd "1/4") (setq z 40))
    ;(if (= bcd "1/6") (setq z 60))
    ;(if (= bcd "1/7") (setq z 70))
    ;(if (= bcd "1/8") (setq z 80))
     
     
    ;(setq z (getint "\n Dis sayisini giriniz : "))
     
    (setq be 6) 
    (setq be (/ (* be pi) 180))
      
 
	  
        ;/ HELÝS HESAPLAR /
        (setq mt (/ mn (cos be))
	      d (* z mt)
	      da (+ d (* 2 mn))
	      pt (/ (* pi mn) (cos be))
	      b (* 10 mn)
	      h (* (/ 13 6) mn)
	      hf (* (/ 7 6) mn)
              ddb (- d (* 2 hf))
	      y (* d 0.0166666)
	      tda (- d (* y 2))
	      radius (* 0.166 mn)
	 )
  	(setq mrk (list 0 0))
	  	(command "erase" "all" "")
  		(command "circle" mrk "d" (+ (* 20 mn) da))
	      	(command "zoom" "extents")
	        (command "erase" "l" "")
        
	; HELÝS ÝSTEKLER DEVAM
     
	  (setq mci (/ ddb 5)
	      mcap 0.0
  	      yazi (strcat (itoa (fix (/ ddb 2))) " ve " (itoa (fix mci)) " deðerleri arasýnda giriniz..." ))
  	
    (setq mcap 30)
     
	; HELÝS ÝSTEKLER BÝTTÝ
	      
  		
  	;/ DÝÞ PROFÝL ÇÝZÝMÝ
                (command "osnap" "o")
  		(command "view" "_top")
  		(command "circle" mrk "d" d)
  		(command "group" "create" "dairesil" "" "l" "")
  		(setq dp1 (polar mrk (/ (* 75 pi) 180) (/ tda 2)))
  		(setq m1 (polar mrk (/ pi 2) (/ d 2)))
  		(setq m2 (polar m1 (/ (* 345 pi) 180) (/ d 8)))
    		(command "circle" mrk "d" tda)
		(command "group" "create" "dairesil2" "" "l" "")
  		(command "circle" mrk "d" da)
  		(command "group" "create" "dairetr" "" "l" "")
  		(command "arc" "c" m2 (polar m2 (/ pi 2) (/ d 8)) (polar m2 (* pi 1.2) (/ d 8)))
  		(setq zum (polar m2 (/ pi 2) (/ d 8)))
  		(setq zum2 (polar m2 (* pi 1.2) (/ d 8)))
  		(command "zoom" "w" (list (- (car zum2) (/ d 8)) (+ (cadr zum) (/ d 8))) (list (+ (car zum) (/ d 8)) (- (cadr zum2) (/ d 8)))) 
  		(command "group" "create" "dp1" "" "l" "" )
  		(command "osnap" "end")
  		(command "trim" "g" "dairetr" "g" "dairesil2" "" (polar m2 (/ pi 2) (/ d 8)) (polar m2 (* pi 1.2) (/ d 8))"")
  		(command "osnap" "o")
  		(command "erase" "g" "dairesil" "")
  		(if (>= tda ddb)
		(progn
			(command "erase" "g" "dairesil2" "")
		  	(command "osnap" "end")
  			(command "line" (polar mrk (/ pi 1.998) (/ tda 2)) mrk "")
   			(command "osnap" "o")
  			(command "group" "add" "dp1" "l" "" )
		))
		(command "zoom" "extents")
  		(if (>= tda ddb)
		  (progn
		    	(command "circle" mrk "d" ddb)
  			(command "group" "create" "dairetr2" "" "l" "")
		  )
		)
  		(setq dacos (- 1 (/ (expt (/ pt 4) 2) (* 2 (expt (/ d 2) 2)))))
  		(setq adeger (atan (/ (expt (- 1 (expt dacos 2)) 0.5) dacos)))
		(if (>= tda ddb)
		(progn
		  	(command "osnap" "end")
		  	(command "trim" "" mrk "")
  		  	(command "osnap" "o")
		  	(command "fillet" "r" radius)
  		  	(command "osnap" "mid")
  		  	(command "fillet" "u" (polar mrk (/ pi 1.998) (/ (+ mn ddb) 2)) (polar mrk (* 1.5 pi) (/ ddb 2)) "")
  		  	(command "osnap" "o")
  		  	(command "group" "add" "dp1" "l" "" )
		))
  		(command "mirror" "g" "dp1" "" mrk (polar mrk (- (/ pi 2) adeger) (/ d 2)) "N")
 		(if (< tda ddb) (command "trim" "" (polar mrk pi (/ tda 2)) ""))
  		(command "group" "explode" "dp1" "")
  		(command "group" "explode" "dairesil" "")
		(command "group" "explode" "dairesil2" "")
  		(command "group" "explode" "dairetr" "")
  		(command "group" "explode" "dairetr2" "")
  		(command "trim" "" (polar mrk (* 1.5 pi) (/ da 2)) "")
  		(if (>= tda ddb) (command "trim" "" (polar mrk pi (/ ddb 2)) ""))
  		(command "region" "all" "" )
  		(command "group" "create" "disprofil" "" "all" "")
  	;/ DÝÞ PROFÝL ÇÝZÝMÝ BÝTTÝ

  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B
  		(setq acidrc (/ (* adeger 180) pi))
		(command "rotate" "all" "" mrk acidrc )
  		(setq egmnokt (polar mrk (/ pi 2) (/ ddb 2)))
  		(command "view" "back")
  		(setq c (* (/ (sin be) (cos be)) b))
  		(setq tur (/ (atan (/ c (/ ddb 2))) (* 2 pi)))
  		(setq hlxnokta egmnokt)
  		(command "view" "top")
  		(command "helix" mrk hlxnokta hlxnokta "w" secimhelis "t" tur (list (car mrk) (cadr mrk) b))
  		(command "group" "create" "heliks" "" "l" "")
		(command "sweep" "g" "disprofil" "" "a" "n" "g" "heliks" "heliks")
  		(command "erase" "g" "heliks" "")
  		(command "group" "explode" "heliks" "")
  		(command "array" "all" "" "p" mrk z "360" "y")
  		(command "circle" mrk "d" ddb)
  		(command "extrude" "l" "" (list (car mrk) (cadr mrk) b))
  		(command "group" "explode" "disprofil" "")
  		(command "union" "all" "")
	  	(setq gvde (ssget "all"))
	  	(command "_cylinder" mrk  mcap b)
	  	(command "subtract" gvde "" "l" "")
  		(command "view" "_swiso")
  		;(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
 )


)





(defun bearing()
  

  
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


    




(defun road ()
  
  
  
  (setq cen (list 0 0 0))
  (setq cem (list 30 0 0))
  (command "cylinder" cen cem 380) 
  

)



(defun c:set ()
  
(command "osmode" "0" )
(command "view" "or" "top" )
  
    ;(bearing)
    ;(command "export" "bear.sat" "all" "")
    ;(command "erase" "all" "" )
  
    (hels)
    (command "export" "gear.sat" "all" "")
    (command "erase" "all" "")

    (road)
    (command "export" "rod.sat" "all" "")
    (command "erase" "all" "")
    
    (command "view" "or" "top" )
    (command "import" "sri.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 0 0 0))
  
    (command "view" "or" "top" )
    (command "import" "krmz.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -240 120 0))

  
    (command "view" "or" "top" )
    (command "import" "ysl.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -38 328 300))
    
    
    ;(command "import" "bear.sat" "")
    ;(command "rotate3d" "all" "" "y" (list 0 0 0) "90" )
    ;(command "copyclip" "all" "" )
    ;(command "erase" "all" "" )
    ;(command "pasteclip" (list 0 -3 0))

  
    ;(command "view" "or" "top" )
    ;(command "import" "rod.sat" "")
    ;(command "copyclip" "l" "" )
    ;(command "erase" "l" "" )
    ;(command "pasteclip" (list -23 -23 -30))
    ;(command "pasteclip" (list -23 340 -30))
  
  
     (if (= z 20)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -26 -29 -30))
    (command "pasteclip" (list -23 340 -30))
    (command "pasteclip" (list -21 266 150))
    ))
  
  
    (if (= z 40)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -26 -29 -30))
    (command "pasteclip" (list -23 340 -30))
    (command "pasteclip" (list -28 232 150))
    ))

    (if (= z 60)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -26 -29 -30))
    (command "pasteclip" (list -23 340 -30))
    (command "pasteclip" (list -20 180 150))
    ))

    (if (= z 70)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -26 -29 -30))
    (command "pasteclip" (list -23 340 -30))
    (command "pasteclip" (list -20 168 150))
    ))
  

    (command "view" "or" "top" )
    (command "import" "gear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    
    (if (= z 20)
    (command "pasteclip" (list -33 250 300)) ; 20 diş okey
    )
  
    (if (= z 40)
    (command "pasteclip" (list -88 175 300)) ; 40 diş okey
    
    )

    (if (= z 60)
    (command "pasteclip" (list -112 90 300)) ; 60 diş okey
    )

    (if (= z 70)
    (command "pasteclip" (list -135 50 300)) ; 70 diş okey
    )
  
    (if (= z 80)
    (command "pasteclip" (list -155 13 300)) ; 80 diş sıgmadı
    )

    (if (= z 20)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 100" "" "")
      (command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ))
  
   
    (if (= z 40)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 50" "" "")
      (command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ))
  
    (if (= z 60)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 33.333" "" "")
      (command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ))
  
    (if (= z 70)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 28.5714" "" "")
      (command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ))
  
    (if (= z 80)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Error" "" "")
      
    ))
  
  
    (command "zoom" "e" "")

    (command "zoom" "e" "")
    
  

)