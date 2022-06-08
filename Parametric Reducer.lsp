(defun c:rdr ()
  
  (setq abc (getint "\n if you want bevel gear reducer write 4 \n Select the step number of the reducer you want =  "))
  
     
  
  (if (= abc 1)
    
    (progn
  

  
(command "osmode" "0" )
(command "view" "or" "top" )
  
    ;(bearing)
    ;(command "export" "bear.sat" "all" "")
    ;(command "erase" "all" "" )
  
    ;(hels)
   (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
     
	  (setq mn 4 ) ;modül saysısı
     
     
    (initget 1 "1/1 4/5 2/3 1/2 ")
    
    (setq girs (getint "\n enter first torque "))
    (setq cks (getint "\n enter second torque "))
     
     
    
  ;(setq bcd (getkword "Enter reduce ratio: ")) kitaba bakılacak integerdan keyworde çevirmek için "rtos" string dönüşümü için
    
    (if (= (/ girs cks) 1) (setq z 20))
    (if (= (/ girs cks) 1.25) (setq z 25))
    (if (= (/ girs cks) 1.5) (setq z 25))
    (if (= (/ girs cks) 2) (setq z 40))
	  
    ;(if (= bcd "1/1") (setq z 20))
	  ;(if (= bcd "4/5") (setq z 25))
    ;(if (= bcd "2/3") (setq z 30))
    ;(if (= bcd "1/2") (setq z 40))
   
     
     
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
    (command "export" "gear.sat" "all" "")
    (command "erase" "all" "")
    (command "erase" "all" "")

    ;(road)
  (setq cen (list 0 0 0))
  (setq cem (list 30 0 0))
  (command "cylinder" cen cem 380 ) 
  
   
    (command "export" "rod.sat" "all" "")
    (command "erase" "all" "")
    
    (command "view" "or" "top" )
    (command "import" "bir.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -55 44 150))
 
    
    
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
    (command "pasteclip" (list -8 16 0))
    (command "pasteclip" (list 0 100 0))
    
    
    ))
  
      (if (= z 25)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -19 16 0))
    (command "pasteclip" (list 0 100 0))
    
    ))
  
      (if (= z 30)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -44 10 0))
    (command "pasteclip" (list 0 100 0))
    ))
  
  
    (if (= z 40)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -37 -15 0))
    (command "pasteclip" (list 0 100 0))
    ))

   
  

    (command "view" "or" "top" )
    (command "import" "gear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    
    (if (= z 20)
    (command "pasteclip" (list -22 3 150)) ; 20 diş okey
    )

    (if (= z 25)
    (command "pasteclip" (list -46 -11 150)) ; 25 diş okey
    )

    (if (= z 30)
    (command "pasteclip" (list -80 -26 150)) ; 30 diş okey
    )
  
    (if (= z 40)
    (command "pasteclip" (list -88 -73 150)) ; 40 diş okey
    
    )



    ;(if (= z 20)
      ;(progn
      ;(command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 100" "" "")
      ;(command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ;))
  
   
    ;(if (= z 40)
      ;(progn
      ;(command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 50" "" "")
      ;(command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ;))
  
 
  
  
    (command "zoom" "e" "")

    (command "zoom" "e" "")
    
  












    





  

))
  
  
  (if (= abc 2)
    
    (progn


  
(command "osmode" "0" )
(command "view" "or" "top" )
  
    ;(bearing)
    ;(command "export" "bear.sat" "all" "")
    ;(command "erase" "all" "" )
  
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
    (command "export" "gear.sat" "all" "")
    (command "erase" "all" "")

  ; iki kademe redüktörün mil kısmı    
      
  (setq cen (list 0 0 0))
  (setq cem (list 30 0 0))
  (command "cylinder" cen cem 380) 
      
    ; iki kademe redüktörün mil kısmı bitti
      
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
    
)
  
  
  (if (= abc 3)
    
    (progn
  
    (command "osmode" "0" )
(command "view" "or" "top" )
  
    ;(bearing)
    ;(command "export" "bear.sat" "all" "")
    ;(command "erase" "all" "" )
  
          	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
     
	  (setq mn 4 ) ;modül saysısı
    
    (setq girs (getint "\n enter first torque "))
    (setq cks (getint "\n enter second torque "))
     
    ;(initget 1 "1/2 1/4 1/6 1/7 1/8")
    
  
    (if (= (/ girs cks) 8) (setq z 40))
    (if (= (/ girs cks) 10) (setq z 60))
    (if (= (/ girs cks) 12) (setq z 80))
     
     ;(setq z 40)
     
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
    (command "export" "gear.sat" "all" "")
    (command "erase" "all" "")

    (setq cen (list 0 0 0))
    (setq cem (list 30 0 0))
    (command "cylinder" cen cem 380) 
    
    (command "export" "rod.sat" "all" "")
    (command "erase" "all" "")

    (setq cen1 (list 0 0 0))
    (setq cem1 (list 30 0 0))
    (command "cylinder" cen1 cem1 100) 
    
    (command "export" "rod1.sat" "all" "")
    (command "erase" "all" "")
    
    (command "view" "or" "top" )
    (command "import" "sri.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -24 123 0))
    (command "pasteclip" (list -57 -155 200))
  
    (command "view" "or" "top" )
    (command "import" "krmz.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -300 -400 100))

  
    (command "view" "or" "top" )
    (command "import" "ysl.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -43 -80 0))
    (command "pasteclip" (list -65 80 100))
    
    
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
  
 
  
  
    (if (= z 40)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -83 -182 0))
    (command "pasteclip" (list -51 96 -170))
    (command "import" "rod1.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -30 -72 -30))
    (command "pasteclip" (list -202 -16 170))
    
    
    ))
  
     (if (= z 60)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -83 -182 0))
    (command "pasteclip" (list -51 96 -170))
    (command "import" "rod1.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -30 -72 -30))
    (command "pasteclip" (list -227 18 170))
    
    
    ))
  
        (if (= z 80)
      (progn
    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -83 -182 0))
    (command "pasteclip" (list -51 96 -170))
    (command "import" "rod1.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list -30 -72 -30))
    (command "pasteclip" (list -245 44 170))
    
    
    ))





    (command "view" "or" "top" )
    (command "import" "gear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    
    
  
    (if (= z 40)
    (command "pasteclip" (list -255 -72 200)) ; 40 diş okey
    
    )

    (if (= z 60)
    (command "pasteclip" (list -320 -80 200)) ; 60 diş okey
    )
  
    (if (= z 80)
    (command "pasteclip" (list -382 -90 200)) ; 60 diş okey
    )

   
  
   

    (if (= z 20)
      (progn
      (command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 100" "" "")
      (command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ))
  
   
    ;(if (= z 40)
      ;(progn
      ;(command "text" "j" "cen" "500,0,0" "50" "0" "Output RPM = 50" "" "")
      ;(command "text" "j" "cen" "500,100,0" "50" "0" "Input RPM = 200" "" "")
    ;))
  
  
  
  
    (command "zoom" "e" "")

    (command "zoom" "e" "")

))
  
  (if (= abc 4)
    
    (progn
  
    (setq m 4 ;modül sayısı
        z1 20 ; birinci diş sayısı 13den büyük
	z2 20         ; ikinic diş sayısı
	be 45)       ; açı derece cinsinden
      
  (setq be (/ (* be pi) 180))
      
      
      
    (setq girs (getint "\n enter first torque "))
    (setq cks (getint "\n enter second torque "))
      
      
    (if (= (/ girs cks) 1) (setq z1 20))
    (if (= (/ girs cks) 1) (setq z2 20))
    
    (if (= (/ girs cks) 3/2) (setq z1 30))
    (if (= (/ girs cks) 3/2) (setq z2 30))
      
    (if (= (/ girs cks) 2) (setq z1 40))
    (if (= (/ girs cks) 2) (setq z2 40))
      
    (if (= (/ girs cks) 3) (setq z1 50))
    (if (= (/ girs cks) 3) (setq z2 40))
    
      
      
      
      ;(if (= (/ girs cks) 4) (setq z1 30) (setq z2 30))

  

  ; KONÝK ÝSTEKLER yukarıda

  
  ; KONÝK ÝSTEKLER DEVAM

  ; KONÝK HESAPLAR
  (setq pa (* m pi)
 	d1 (* m z1)
   	S1 (atan (/ z1 z2))
  	da1 (+ d1 (* 2 m (cos s1)))
	df1 (- d1 (* 2.332 m (cos s1)))
  	a1 (atan (/ (+ z1 (* 2 (cos S1))) (- z2 (* 2 (sin S1)))))
  	Sf1 (atan (/ (* 2 1.166 (sin S1)) z1))
	Y1 (- S1 Sf1)
	Sa1 (atan (/ (* 2 (sin S1)) z1))
	ha1 (* 1 m)
	hf1 (* 1.166 m)
	h1 (* 2.166 m)
	b1 (/ (* m z1) (* 6 (sin S1)))
	Ra1 (/ d1 (* 2 (sin s1)))
	F1 (* Ra1 (cos S1))
	)
  
  ; KONÝK HESAPLAR BÝTTÝ

   	; KONÝK ÝSTEKLER DEVAM,
    
  	;(setq mci (/ df1 2)
	   ;   mcap 0.0
 ; 	 ;     yazi (strcat (itoa (fix (/ df1 2))) " ve " (itoa (fix (/ mci 2))) " deðerleri arasýnda giriniz..." ))
  	
	;(while (or (= mcap 0.0) (< mcap (/ mci 2)) (> mcap (/ df1 2) ))
   ;   	      (progn
    ;          (princ yazi) (terpri)
     ;         (setq mcap (getreal "\n Mil çapýný giriniz : "))
	;))
    (setq mcap 20 )   ; bunun 36 ile 18 arasında olması gerekiyor
   	(setq mboy 50 )
  	; KONÝK ÝSTEKLER BÝTTÝ
  
  ; DÝÞ PROFÝL HESAPLAR
  (setq       d (* z1 m)
	      da (+ d (* 2 m))
	      pt pa
	      h (* (/ 13 6) m)
	      hf (* (/ 7 6) m)
	      ddb df1
    	      y (* d 0.0166666)
	      tda (- d (* y 2))
	      radius (* 0.166 m)
	 )
  (setq mrk (list 0 0))
  		(command "circle" mrk "d" (+ (* 20 m) da))
	      	(command "zoom" "extents")
	        (command "erase" "l" "")
  	      
  ; DÝÞ PROFÝL ÇÝZÝMÝ
                (command "osnap" "o")
  		(command "view" "_top")
  		(command "erase" "all" "") 
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
  		  	(command "fillet" "u" (polar mrk (/ pi 1.998) (/ (+ m ddb) 2)) (polar mrk (* 1.5 pi) (/ ddb 2)) "")
  		  	(command "osnap" "o")
  		  	(command "group" "add" "dp1" "l" "" )
		))
  		(command "mirror" "g" "dp1" "" mrk (polar mrk (- (/ pi 2) adeger) (/ d 2)) "N")
 		(if (< tda ddb) (command "trim" "" (polar mrk pi (/ tda 2)) ""))
  		(command "group" "explode" "dp1")
  		(command "group" "explode" "dairesil")
		(command "group" "explode" "dairesil2")
  		(command "group" "explode" "dairetr")
  		(if (>= tda ddb) (command "group" "explode" "dairetr2"))
  		(command "zoom" "extents")
  		(command "osnap" "quadrant")
  		(command "explode" (polar mrk  pi (/ da 2)) "")
  		(command "trim" "" (polar mrk  pi (/ da 2)) "")
  		(if (>= tda ddb) (command "trim" "" (polar mrk pi (/ ddb 2)) ""))
  		(command "region" "all" "" )
  		(command "osnap" "o")
  		(setq disprofil (ssget "all"))
  		(setq acidrc (/ (* adeger 180) pi))
		(command "rotate" "all" "" mrk acidrc )
  	; DÝÞ PROFÝL ÇÝZÝMÝ BÝTTÝ

        ; KONÝK DÝÞLÝ OLUÞTURMA
  	(command "ucs" "x" "90")
  	(command "ucs" "y" "-90")
  	(setq nkt1 (list (/ df1 -2) 0))
  	(setq nkt2 (polar nkt1 (- (/ pi 2) y1) b1))
  	(setq aci (/ (* S1 180) pi))
  	(setq aci2 (/ (* Y1 180) pi))
  	(command "rotate" disprofil "" nkt1 (* -1 aci))
  	(command "line" nkt1 nkt2 "")
  	(setq spczg (ssget "l"))
  	(setq oran (/ b1 Ra1))
  	(command "ucs" "y" "-90")
  	(command "sweep" disprofil "" "s" oran "a" "n" spczg)
  	(command "ucs" "x" "-90")
  	(command "array" "all" "" "p" "0,0" (fix z1) "360" "y")
  	(command "circle" "0,0" "d" df1)
  	(setq daire (ssget "l"))
  	(command "extrude" daire "" "t" aci2 (* b1 (cos y1)))
  	(setq koni (ssget "l"))
  	(command "circle" (list 0 0 (* b1 (cos y1))) "d" (- df1 (* 2 b1 (sin y1))) )
  	(setq daire (ssget "l"))
  	(command "extrude" daire "" "t" (- 90 aci2) (* -0.25 m))
  	(command "subtract" koni "" "l" "")
  	(command "union" "all" "")
  	(setq koni (ssget "l"))
  	(command "_cylinder" "0,0" df1 (* -1 m))
  	(command "subtract" koni "" "l" "")
  	(command "circle" (list 0 0) "d" df1)
  	(setq daire (ssget "l"))
  	(command "extrude" daire "" "t" (- 90 aci2) (* -0.25 m))
  	(command "union" "all" "")
  	(command "_cylinder" "0,0" mcap (* -1 mboy ))
  	(command "union" "all" "")
  	(setq koni (ssget "all"))
  	(command "_cylinder" (list 0 0 (* -1 mboy )) (/ mcap 2) (* 4 mboy))
  	(command "subtract" koni "" "l" "")
  	(command "view" "_swiso")
  	(command "_vscurrent" "_C")
  	; KONÝK DÝÞLÝ OLUÞTURMA BÝTTÝ
      
      (if (= (/ girs cks) 1)
      
      (progn
      (command "import" "conicgear.sat" "")
      )
      )
      
      (if (= (/ girs cks) 3/2)
        
      (progn
      
    (command "view" "or" "top" )
    (command "import" "conicgear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 0 0 0))

      )
      )
      
        (if (= (/ girs cks) 2)
        
      (progn
      
    (command "view" "or" "top" )
    (command "import" "conicgear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 60 -32 5))

      )
      )
      
        (if (= (/ girs cks) 3)
        
      (progn
      
    (command "view" "or" "top" )
    (command "import" "conicgear.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 84 -42 0))

      )
      )
  

))
  

  
)