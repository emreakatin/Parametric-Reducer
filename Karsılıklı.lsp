(defun c:krsl ()
  

	(progn

	    (setq mn 0
		z1 0
		z2 0
		be 0.0)
  
  	  (command "erase" "all" "")
		
  	; KARÞILIK ÝSTEKLER
  	  (while (or (= mn 0) (< mn 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri)
              (setq mn (getreal "\n Modül (Normal modül) giriniz : "))
          ))
          (while (or (= z2 0) (< z2 23))
      	      (progn
              (princ " 23 veya 23 den büyük giriniz...") (terpri) 
              (setq z2 (getint "\n Kaþýlýk diþli sayýsýný giriniz : "))
          ))
  	  (while (or (= z1 0) (< z1 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri) 
              (setq z1 (getint "\n Sonsuz diþli aðýz sayýsýný giriniz : "))
          ))
	  (initget 1 "Derece Radyan")
          (setq aci (getkword "Helis açýsýnýn cinsi (Derece/Radyan) : "))
	  (if (= aci "Derece")
	    (progn  
            (while (or (= be 0) (< be 5.5) (> be 8.5))
                (progn
                (princ " En az 5.5 en fazla 8.5 derece girebilirsiniz...") (terpri)
                (setq be (getreal "\n Helis açýsýný giriniz :"))
	    ))
	    (setq be (/ (* be pi) 180))
	    )
	  )
	  (if (= aci "Radyan")
	    (progn  
            (while (or (= be 0) (< be 0.096) (> be 0.148))
                (progn
                (princ " En az 0.096 en fazla 0.148 radyan girebilirsiniz...") (terpri)
                (setq be (getreal "\n Helis açýsýný giriniz :"))
	    ))
	    )
	  )
  	
	; KARÞILIK ÝSTEKLER ARA

  	; KARÞILIK HESAPLAR
  	(if (<= z2 28) (setq f 1.9))
	(if (and (> z2 28)  (<= z2 35)) (setq f 2.0))
  	(if (and (> z2 35)  (<= z2 45)) (setq f 2.2))
    	(if (and (> z2 45)  (<= z2 55)) (setq f 2.4))
  	(if (and (> z2 55)  (<= z2 65)) (setq f 2.6))
    	(if (and (> z2 65)  (<= z2 75)) (setq f 2.7))
  	(if (and (> z2 75)  (<= z2 85)) (setq f 2.9))
  	(setq pn (* mn pi)
	      mt (/ mn (cos be))
	      pt1 (/ pn (cos be))
	      d1 (/ mn (sin be))
	      da1 (+ d1 (* 2 mn))
	      Bta (atan (/ (* 2 f pn) (+ d1 (* 1.2 pn))))
	      rk (- (/ d1 2) mn)
	      b (* 2 rk (sin Bta))
	      BB (+ b (* 0.25 pn)))
	(if (<= z2 30) (setq d2 (* mt z2)))
	(if (> z2 30) (setq d2 (+ (* mn z2 0.937) (* 2 mn))))
  	(setq da2 (+ d2 (* 2 mn))
	      df2 (- d2 (* 2.33 mn))
	)

  	; KARÞILIK HESAPLAR BÝTTÝ

  	; KARÞILIK ÝSTEKLER DEVAM
  	(setq mci (/ df2 5)
	      mcap 0.0
  	      yazi (strcat (itoa (fix (/ df2 2))) " ve " (itoa (fix mci)) " deðerleri arasýnda giriniz..." ))
  	
	(while (or (= mcap 0.0) (< mcap mci) (> mcap df2))
      	      (progn
              (princ yazi) (terpri)
              (setq mcap (getreal "\n Mil çapýný giriniz : "))
	))
	; KARÞILIK ÝSTEKLER BÝTTÝ

  	; DÝÞ PROFÝL HESAPLAR
  (setq       d (* z2 mn)
	      da (+ d (* 2 mn))
	      pt pn
	      h (* (/ 13 6) mn)
	      hf (* (/ 7 6) mn)
	      ddb df2
    	      y (* d 0.0166666)
	      tda (- d (* y 2))
	      radius (* 0.166 mn)
	 )
  (setq mrk (list 0 0))
  		(command "circle" mrk "d" (+ (* 20 mn) da))
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
  		  	(command "fillet" "u" (polar mrk (/ pi 1.998) (/ (+ mn ddb) 2)) (polar mrk (* 1.5 pi) (/ ddb 2)) "")
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

  	; KARÞILIK DÝÞLÝ ÇÝZÝMÝ
	(command "ucs" "x" "90")
  	(command "ucs" "y" "-90")
  	(setq aci (/ (* Bta 180) pi))
	(command "arc" "c" (list (* -1 (+ (/ df2 2) rk)) 0) (list (/ df2 -2) 0) "A" aci)
  	(setq czg1 (ssget "l"))
   	(command "line" (polar (list (* -1 (+ (/ df2 2) rk)) 0) Bta Rk) (list 0 (/ b 2)) "")
  	(setq czg2 (ssget "l"))
  	(command "line" (list 0 (/ b 2)) "0,0" "")
  	(setq czg3 (ssget "l"))
  	(command "line" "0,0" (list (/ df2 -2) 0) "")
  	(setq czg4 (ssget "l"))
  	(command "region" czg1 czg2 czg3 czg4 "")
  	(setq czg1 (ssget "l"))
  	(command "revolve" czg1 "" "0,0" (list 0 (/ b 2)) "360")
  	(command "arc" "c" (list (* -1 (+ (/ df2 2) rk)) 0) (list (/ df2 -2) 0) "A" aci)
  	(setq czg2 (ssget "l"))
  	(command "sweep" disprofil "" "a" "n" czg2)
  	(setq dis (ssget "l"))
  	(command "erase" czg2 "")
  	(command "ucs" "x" "-90")
  	(command "circle" (list 0 0 (/ b 2)) (list (- (+ (/ df2 2) rk) (* rk (cos bta))) 0))
  	(command "extrude" "l" "" "t" (- 90 aci) (/ (- BB b) 2))
  	(command "array" dis "" "p" "0,0" z2 "360" "y")
  	(command "union" "all" "")
	(command "view" "_left")
  	(command "mirror" "all" "" (list 0 0) (list (/ df2 -2) 0) "n")
	(command "union" "all" "")
  	(setq gvde (ssget "all"))
  	(command "view" "_top")
	(command "_cylinder" (list 0 0 b) mcap (* BB -6))
	(command "subtract" gvde "" "l" "")
  	(command "view" "_swiso")
  	(command "_vscurrent" "_C")
	; KARÞILIK DÝÞLÝ ÇÝZÝMÝ BÝTTÝ
  ))
