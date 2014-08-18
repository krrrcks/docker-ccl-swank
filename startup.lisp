(ql:quickload "swank")
(swank:create-server :dont-close t)

;;; put your startup code here

(format t "Hello, world!~%")
