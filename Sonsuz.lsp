(defun c:snz ()
  
  
	(progn	  

	(setq mn 0
		z1 0
		z2 0
		be 0.0)
  
  	  (command "erase" "all" "")
		
  	; SONSUZ ÝSTEKLER
  	  (while (or (= mn 0) (< mn 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri)
              (setq mn (getreal "\n Modül (Normal modül) giriniz : "))
          ))
          (while (or (= z1 0) (< z1 1))
      	      (progn
              (princ " 1 veya 1 den büyük giriniz...") (terpri) ; dikkat
              (setq z1 (getint "\n Aðýz sayýsýný giriniz : "))
          ))
  	  (while (or (= z2 0) (< z2 23))
      	      (progn
              (princ " 23 veya 23 den büyük giriniz...") (terpri) ; dikkat
              (setq z2 (getint "\n Kaþýlýk diþli diþ sayýsýný giriniz : "))
          ))
	  (initget 1 "Derece Radyan")
          (setq aci (getkword "Helis açýsýnýn cinsi (Derece/Radyan) : "))
	  (if (= aci "Derece")
	    (progn  
            (while (or (= be 0) (< be 1) (> be 20))
                (progn
                (princ " En az 1 en fazla 20 derece girebilirsiniz...") (terpri)
                (setq be (getreal "\n Helis açýsýný giriniz :"))
	    ))
	    (setq be (/ (* be pi) 180))
	    )
	  )
	  (if (= aci "Radyan")
	    (progn  
            (while (or (= be 0) (< be 0.018) (> be 0.348))
                (progn
                (princ " En az 0.018 en fazla 0.349 radyan girebilirsiniz...") (terpri)
                (setq be (getreal "\n Helis açýsýný giriniz :"))
	    ))
	    )
	  )

  	
	; SONSUZ ÝSTEKLER ARA
  
  	; SONSUZ HESAPLAR
        (setq tan (/ (sin be) (cos be))) 
  	(setq mx (/ mn (cos be))
	      pn (* pi mn)
	      px (* mx pi)
	      pz (* px z1)
	      d1 (/ pz (* pi tan))
	      da1 (+ d1 (* 2 mn))
	      df1 (- d1 (* 2.33 mn))
	      gma (/ (* 15 pi) 180)
	      gmaa(/ (* pi 75) 180)
	      L (+ (* 2 mn (sqrt z2)) (* 2 mn))
	      ha (/ (- da1 d1) 2)
	      hf (/ (- d1 df1) 2)
	      h (/ (- da1 df1) 2)
	      r1 (* 0.25 mn)
	      s (/ px 2)
	      )
  	; SONSUZ HESAPLAR BÝTTÝ

  	; SONSUZ ÝSTEKLER DEVAM
  	(setq mci (/ df1 2)
	      mcap 0.0
  	      yazi (strcat (itoa (fix df1)) " ve " (itoa (fix mci)) " deðerleri arasýnda giriniz..." ))
  	
	(while (or (= mcap 0.0) (< mcap mci) (> mcap df1))
      	      (progn
              (princ yazi) (terpri)
              (setq mcap (getreal "\n Mil çapýný giriniz : "))
	))
   	(setq mboy (getreal "\n Mil boyu giriniz : "))
  	; SONSUZ ÝSTEKLER BÝTTÝ
  	
  	; TRAPEZ VÝDA DÝÞ PROFÝL ÇÝZÝMÝ
  	(command "view" "top")
  	(command "osnap" "o")
	(command "erase" "all" "")
  	(setq nok1 (list 0 (/ df1 2)))
	(setq nok2 (list (* -1 (+ (/ s 2) (* hf (/ (sin gma) (cos gma))))) (/ df1 2)))
  	(setq nok3 (polar nok2 gmaa (/ h (cos gma))))
  	(setq nok4 (list 0 (+ (/ df1 2) h)))
  	(command "line" nok1 nok2 nok3 nok4 "")
  	(command "zoom" "e")
  	(command "mirror" "all" "" nok1 nok4 "n")
  	(command "region" "all" "")
  	(setq profil (ssget "all"))
  	; TRAPEZ VÝDA DÝÞ PROFÝL ÇÝZÝMÝ BÝTTÝ

  	; SONSUZ DÝÞLÝ ÇÝZÝMÝ
  	(command "ucs" "y" "-90")
  	(command "helix" "0,0" nok1 nok1 "h" pz L)
  	(setq heliss (ssget "l"))
  	(command "_sweep" profil "" "A" "N" heliss)
  	(setq helissw (ssget "l"))
  	(command "zoom" "e")
  	(command "_cylinder" "0,0" (/ df1 2) L)
  	(if (> z1 1) (command "-array" helissw "" "p" "0,0" z1 "360" "y"))
  	(command "union" "all" "")
  	(setq govde (ssget "l"))
  	(command "_cylinder" "0,0" (+ 2 (/ da1 2)) (/ L -4))
  	(setq sil1 (ssget "l"))
	(command "_cylinder" (list 0 0 L) (+ 2 (/ da1 2)) (/ L 4))
  	(setq sil2 (ssget "l"))
  	(command "zoom" "e")
  	(command "subtract" govde "" sil1 sil2 "")
  	(command "_cylinder" "0,0" (/ mcap 2) (* -1 mboy ))
  	(command "_cylinder" (list 0 0 L) (/ mcap 2) mboy)
  	(command "ucs" "y" "90")
  	(command "zoom" "e")
  	(command "union" "all" "")
  	(command "view" "_swiso")
  	(command "_vscurrent" "_C")
 	; SONSUZ DÝÞLÝ ÇÝZÝMÝ BÝTTÝ
  ))