(defun c:bearing ()
  
(command "import" "bear.sat" "")
(setq bear (ssget "x"))
(command "copyclip" bear "" )
(command "erase" bear "")
(command "pasteclip" (list 0 0 0))
  

  
)