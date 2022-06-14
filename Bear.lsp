(defun c:bearing ()
  

    (command "view" "or" "top" )
    (command "import" "rod.sat" "")
    (command "copyclip" "l" "" )
    (command "erase" "l" "" )
    (command "pasteclip" (list 0 0 0))
    

  
)