(defun c:helc ()
   
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
