;;functions
(defun circle-area (radius)
	(let ((pi 3.1415926)
		  area)
	  (setq area (* pi  radius radius))
	  (message "Area is: %.2f " area))
	)
(circle-area 3)
"Area is: 28.27 "
	
(defun circle-area (radix)
  (let ((pi 3.1415926)
        area)
    (setq area (* pi radix radix))
    (message "直径为 %.2f 的圆面积是 %.2f" radix area)))
circle-area

(circle-area 3)
"直径为 3.00 的圆面积是 28.27"


(setq foo 1)
1
(defvar foo 3.5
  "Foo documentation string")
foo ;;describe variable shows that foo=1

(setq circ-area
	  (lambda (r)
		 (setq area (* 3.142 r r))))
(lambda (r) (setq area (* 3.142 r r)))
(funcall circ-area 1)
3.142

(defun my-max (a b)
  (if (> a b)
	  a b)
  )
(my-max 3 4)

(defun fib (n)
  (cond ((= n 0) 0)
		 ((= n 1) 1)
		 (t (+ (fib (- n 1))
			   (fib (- n 2))
			   )
			)
   )
  )
fib

(fib 10)
55

(defun factorial (n)
  





	  
	  
