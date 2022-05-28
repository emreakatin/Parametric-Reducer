(defun c:br ()
  
(command "osmode" "0" )
(command "view" "or" "top" )
  
    ;(bearing)
    ;(command "export" "bear.sat" "all" "")
    ;(command "erase" "all" "" )
  
    (hels)
    (command "export" "gear.sat" "all" "")
    (command "erase" "all" "")
    (command "erase" "all" "")

    (road)
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
    
  

)

(defun hels ()
   
   (progn
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
 )


)








    




(defun road ()
  
  
  
  (setq cen (list 0 0 0))
  (setq cem (list 30 0 0))
  (command "cylinder" cen cem 380 ) 
  

)



