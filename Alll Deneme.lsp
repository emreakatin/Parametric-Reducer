(defun c:rdr ()
  
  (setq girs (getint "\n enter first torque "))
  (setq cks (getint "\n enter second torque "))
     
  
  (if (= (/ girs cks) 2)
    
    (progn
  
  (setq cen (list 0 0 0))
  (setq cem (list 10 10 0))
  (command "cylinder" cen cem 5) 
  

))
  
  
  (if (= (/ girs cks) 3)
    
    (progn
  
  (road)
  (road1)
  ;(setq cen (list 0 0 0))
  ;(setq cem (list 10 10 0))
  ;(command "cylinder" cen cem 200) 
  

))
  
)

(defun road ()
  
  
  
  (setq cen (list 0 0 0))
  (setq cem (list 30 0 0))
  (command "cylinder" cen cem 100 ) 
  

)

(defun road1 ()
  
  
  
  (setq cen1 (list 0 0 0))
  (setq cem1 (list 100 0 0))
  (command "cylinder" cen1 cem1 5 ) 
  

)
