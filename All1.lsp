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
  
  (setq cen (list 0 0 0))
  (setq cem (list 10 10 0))
  (command "cylinder" cen cem 200) 
  

))
  
)