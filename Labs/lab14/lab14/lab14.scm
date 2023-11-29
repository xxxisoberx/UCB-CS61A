(define (split-at lst n)
  (cond 
		((<= (length lst) n) (cons lst nil))
  		((= n 0) (cons nil lst))
	  	(else (define rest (split-at (cdr lst) (- n 1))) (cons (cons (car lst) (car rest)) (cdr rest))))
)


(define-macro (switch expr cases)
	(cons 'cond
		(map (lambda (case) (cons `(equal? ,expr ',(car case)) (cdr case)))
    			cases))
)

