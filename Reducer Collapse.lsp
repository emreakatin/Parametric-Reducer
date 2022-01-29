(defun hels ()
   
    (progn
      	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (initget 1 "SAð SOl")
  	  (setq secimhelis (getkword "Helis tipini seçiniz (SAð/SOl): "))
  
	  (if (= secimhelis "SAð") (setq secimhelis "CCW"))
	  (if (= secimhelis "SOl") (setq secimhelis "CW"))
	  (while (or (= mn 0) (< mn 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri)
              (setq mn (getreal "\n Modül giriniz : "))
          ))
          (while (or (= z 0) (< z 14))
      	      (progn
              (princ " 14 veya 14 den büyük giriniz...") (terpri)
              (setq z (getint "\n Diþ sayýsýný giriniz : "))
          ))
	  (initget 1 "Derece Radyan")
          (setq aci (getkword "Eðim açýsýnýn cinsi (Derece/Radyan) : "))
	  (if (= aci "Derece")
	    (progn  
            (while (or (= be 0) (< be 1) (> be 20))
                (progn
                (princ " En az 1 en fazla 20 derece girebilirsiniz...") (terpri)
                (setq be (getreal "\n Eðim açýsýný giriniz :"))
	    ))
	    (setq be (/ (* be pi) 180))
	    )
	  )
	  (if (= aci "Radyan")
	    (progn  
            (while (or (= be 0) (< be 0.018) (> be 0.348))
                (progn
                (princ " En az 0.018 en fazla 0.349 radyan girebilirsiniz...") (terpri)
                (setq be (getreal "\n Eðim açýsýný giriniz :"))
	    ))))
	  
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
  	
	(while (or (= mcap 0.0) (< mcap mci) (> mcap ddb))
      	      (progn
              (princ yazi) (terpri)
              (setq mcap (getreal "\n Mil çapýný giriniz : "))
	))
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
  		(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
 )


)




(defun sarı ()
   
    (progn
      	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
	 
      
    (setq mn 4 ) ;modül saysısı
    (setq z 20 ) ;diş sayısı 
    
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
  	(setq mrk (list d d))
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
  		(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
)

    

)



(defun krmz ()
   
    (progn
      	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
	 
      
    (setq mn 4 ) ;modül saysısı
    (setq z 20 ) ;diş sayısı 
    
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
  	(setq mrk (list d d))
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
  		(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
)

    

)

(defun ysl ()
   
    (progn
      	  (setq mn 0
                z 0
		secimhelis ""
                be 0)

	  (setq secimhelis "CW")
	 
      
    (setq mn 4 ) ;modül saysısı
    (setq z 20 ) ;diş sayısı 
    
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
  	(setq mrk (list d d))
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
  		(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
)

    

)











(defun helc ()
   
    (progn	        

	  (setq m 0
        z1 0
	z2 0
	be 0.0)
  

  ; KONÝK ÝSTEKLER
  	 (while (or (= m 0) (< m 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri)
              (setq m (getreal "\n Modül giriniz : "))
          ))
          (while (or (= z1 0) (< z1 13))
      	      (progn
              (princ " 13 veya 13 den büyük giriniz...") (terpri)
              (setq z1 (getreal "\n 1. Diþ sayýsýný giriniz : "))
          ))
  	  (while (or (= z2 0) (< z2 13))
      	      (progn
              (princ " 13 veya 13 den büyük giriniz...") (terpri)
              (setq z2 (getreal "\n 2. Diþ sayýsýný giriniz : "))
          ))
  	  
	  (initget 1 "Derece Radyan")
          (setq aci (getkword "Eksenler arasý açý cinsini seçiniz (Derece/Radyan) : "))
	  (if (= aci "Derece")
	    (progn  
            (while (or (= be 0) (< be 5) (> be 90))
                (progn
                (princ " En az 5 en fazla 90 derece girebilirsiniz...") (terpri)
                (setq be (getreal "\n Eksenler arasý açýyý giriniz :"))
	    ))
	    (setq be (/ (* be pi) 180))
	    )
	  )
	  (if (= aci "Radyan")
	    (progn  
            (while (or (= be 0) (< be 0.087) (> be 1.57))
                (progn
                (princ " En az 0.087 en fazla 1.57 radyan girebilirsiniz...") (terpri)
                (setq be (getreal "\n Eksenler arasý açýyý giriniz :"))
	    ))
	    )
	  )
  	
  
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

   	; KONÝK ÝSTEKLER DEVAM
  	(setq mci (/ df1 2)
	      mcap 0.0
  	      yazi (strcat (itoa (fix (/ df1 2))) " ve " (itoa (fix (/ mci 2))) " deðerleri arasýnda giriniz..." ))
  	
	(while (or (= mcap 0.0) (< mcap (/ mci 2)) (> mcap (/ df1 2) ))
      	      (progn
              (princ yazi) (terpri)
              (setq mcap (getreal "\n Mil çapýný giriniz : "))
	))
   	(setq mboy (getreal "\n Mil boyu giriniz : "))
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
  
  (setq mcapv2 (- mcap 6))
  
  (setq cen (list 0 0 0))
  (setq cem (list mcapv2 mcapv2 0))
  (command "cylinder" cen cem 200) 
  

)



(defun c:set ()
  
 (command "osmode" "0" )

  
    (bearing)
    (command "export" "ahmet.sat" "all" "")
    (command "erase" "all" "" )
  
    (hels)
    (command "export" "mehmet.sat" "all" "")
    (command "erase" "all" "")

    (road)
    (command "export" "aslı.sat" "all" "")
    (command "erase" "all" "")
    
  
    
    
    
    (command "import" "ahmet.sat" "")
    (command "rotate3d" "all" "" "y" (list 0 0 0) "90" )
    (command "copyclip" "all" "" )
    (command "erase" "all" "" )
    (command "pasteclip" (list 0 -3 0))
    (command "pasteclip" (list 0 -3 200))
    (command "pasteclip" (list 80 -3 0))
    (command "pasteclip" (list 80 -3 200))
  
  
    (command "import" "aslı.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 14 0 0))
    (command "pasteclip" (list 95 0 0))


    (command "import" "mehmet.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 0 0 30))
    (command "pasteclip" (list 80 0 30))
    (command "pasteclip" (list 80 0 135))

    (command "zoom" "e" "")
    
  

)