(defun c:hels2 ()
   
    (progn
      	  (setq mn1 0
                z1 0
		secimhelis1 ""
                be1 0)

	  
  
	  
      
	  (setq secimhelis1 "CW"))
    (setq mn1 4 ) ; modül
    (setq z1  30 ) ; diş sayısı
    (setq be1 15 ) ; derece cinsinden eğim açısı
    (setq be1 (/ (* be1 pi) 180))
  
  
          
	  
	  
	  
        ;/ HELÝS HESAPLAR /
        (setq m1 (/ mn1 (cos be1))
	      d1 (* z1 mt1)
	      da1 (+ d1 (* 2 mn1))
	      pt1 (/ (* pi mn1) (cos be1))
	      b1 (* 10 mn1)
	      h1 (* (/ 13 6) mn1)
	      hf1 (* (/ 7 6) mn1)
              ddb1 (- d1 (* 2 hf1))
	      y1 (* d1 0.0166666)
	      tda1 (- d1 (* y1 2))
	      radius1 (* 0.166 mn1)
	 )
  	(setq mrk1 (list d1 d1))
	  	(command "erase" "all" "")
  		(command "circle" mrk1 "d" (+ (* 20 mn1) da1))
	      	(command "zoom" "extents")
	        (command "erase" "l" "")
        
	; HELÝS ÝSTEKLER DEVAM
  	(setq mci1 (/ ddb1 5)
	      mcap1 0.0
  	      yazi1 (strcat (itoa (fix (/ ddb1 2))) " ve " (itoa (fix mci1)) " deðerleri arasýnda giriniz..." ))
  	
	(while (or (= mcap1 0.0) (< mcap1 mci1) (> mcap1 ddb1))
      	      (progn
              (princ yazi1) (terpri)
              (setq mcap1 30 ) ;mil çapı 
	))
	; HELÝS ÝSTEKLER BÝTTÝ
	      
  		
  	;/ DÝÞ PROFÝL ÇÝZÝMÝ
                (command "osnap" "o")
  		(command "view" "_top")
  		(command "circle" mrk1 "d" d1)
  		(command "group" "create" "dairesil" "" "l" "")
  		(setq dp2 (polar mrk1 (/ (* 75 pi) 180) (/ tda1 2)))
  		(setq m2 (polar mrk1 (/ pi 2) (/ d1 2)))
  		(setq m3 (polar m2 (/ (* 345 pi) 180) (/ d1 8)))
    		(command "circle" mrk1 "d" tda1)
		(command "group" "create" "dairesil2" "" "l" "")
  		(command "circle" mrk1 "d" da1)
  		(command "group" "create" "dairetr" "" "l" "")
  		(command "arc" "c" m3 (polar m3 (/ pi 2) (/ d1 8)) (polar m3 (* pi 1.2) (/ d1 8)))
  		(setq zum1 (polar m3 (/ pi 2) (/ d1 8)))
  		(setq zum3 (polar m3 (* pi 1.2) (/ d1 8)))
  		(command "zoom" "w" (list (- (car zum3) (/ d1 8)) (+ (cadr zum1) (/ d1 8))) (list (+ (car zum1) (/ d1 8)) (- (cadr zum3) (/ d1 8)))) 
  		(command "group" "create" "dp1" "" "l" "" )
  		(command "osnap" "end")
  		(command "trim" "g" "dairetr" "g" "dairesil2" "" (polar m3 (/ pi 2) (/ d1 8)) (polar m3 (* pi 1.2) (/ d1 8))"")
  		(command "osnap" "o")
  		(command "erase" "g" "dairesil" "")
  		(if (>= tda1 ddb1)
		(progn
			(command "erase" "g" "dairesil2" "")
		  	(command "osnap" "end")
  			(command "line" (polar mrk1 (/ pi 1.998) (/ tda1 2)) mrk1 "")
   			(command "osnap" "o")
  			(command "group" "add" "dp1" "l" "" )
		))
		(command "zoom" "extents")
  		(if (>= tda1 ddb1)
		  (progn
		    	(command "circle" mrk1 "d" ddb1)
  			(command "group" "create" "dairetr2" "" "l" "")
		  )
		)
  		(setq dacos1 (- 1 (/ (expt (/ pt1 4) 2) (* 2 (expt (/ d1 2) 2)))))
  		(setq adeger1 (atan (/ (expt (- 1 (expt dacos1 2)) 0.5) dacos1)))
		(if (>= tda1 ddb1)
		(progn
		  	(command "osnap" "end")
		  	(command "trim" "" mrk1 "")
  		  	(command "osnap" "o")
		  	(command "fillet" "r" radius1)
  		  	(command "osnap" "mid")
  		  	(command "fillet" "u" (polar mrk1 (/ pi 1.998) (/ (+ mn1 ddb1) 2)) (polar mrk1 (* 1.5 pi) (/ ddb1 2)) "")
  		  	(command "osnap" "o")
  		  	(command "group" "add" "dp1" "l" "" )
		))
  		(command "mirror" "g" "dp1" "" mrk1 (polar mrk1 (- (/ pi 2) adeger1) (/ d1 2)) "N")
 		(if (< tda1 ddb1) (command "trim" "" (polar mrk1 pi (/ tda1 2)) ""))
  		(command "group" "explode" "dp1" "")
  		(command "group" "explode" "dairesil" "")
		(command "group" "explode" "dairesil2" "")
  		(command "group" "explode" "dairetr" "")
  		(command "group" "explode" "dairetr2" "")
  		(command "trim" "" (polar mrk1 (* 1.5 pi) (/ da1 2)) "")
  		(if (>= tda1 ddb1) (command "trim" "" (polar mrk1 pi (/ ddb1 2)) ""))
  		(command "region" "all" "" )
  		(command "group" "create" "disprofil" "" "all" "")
  	;/ DÝÞ PROFÝL ÇÝZÝMÝ BÝTTÝ

  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B
  		(setq acidrc1 (/ (* adeger1 180) pi))
		(command "rotate" "all" "" mrk1 acidrc1 )
  		(setq egmnokt1 (polar mrk1 (/ pi 2) (/ ddb1 2)))
  		(command "view" "back")
  		(setq c1 (* (/ (sin be1) (cos be1)) b1))
  		(setq tur1 (/ (atan (/ c1 (/ ddb1 2))) (* 2 pi)))
  		(setq hlxnokta1 egmnokt1)
  		(command "view" "top")
  		(command "helix" mrk1 hlxnokta1 hlxnokta1 "w" secimhelis1 "t" tur1 (list (car mrk1) (cadr mrk1) b1))
  		(command "group" "create" "heliks" "" "l" "")
		(command "sweep" "g" "disprofil" "" "a" "n" "g" "heliks" "heliks")
  		(command "erase" "g" "heliks" "")
  		(command "group" "explode" "heliks" "")
  		(command "array" "all" "" "p" mrk1 z1 "360" "y")
  		(command "circle" mrk1 "d" ddb1)
  		(command "extrude" "l" "" (list (car mrk1) (cadr mrk1) b1))
  		(command "group" "explode" "disprofil" "")
  		(command "union" "all" "")
	  	(setq gvde1 (ssget "all"))
	  	(command "_cylinder" mrk1  mcap1 b1)
	  	(command "subtract" gvde1"" "l" "")
  		(command "view" "_swiso")
  		(command "_vscurrent" "_C")
  	;/ HELÝS DÝÞLÝ ÇÝZÝMÝ 3B BÝTTÝ
)


)
