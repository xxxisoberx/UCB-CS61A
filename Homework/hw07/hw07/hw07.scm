(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  'YOUR-CODE-HERE
  (car (cdr s))
)

(define (caddr s)
  'YOUR-CODE-HERE
  (car (cddr s))
)


(define (sign num)
  'YOUR-CODE-HERE
  (cond
    ((< num 0) -1)
    ((> num 0) 1)
    (else 0))
)


(define (square x) (* x x))

(define (pow x y)
  'YOUR-CODE-HERE
  (cond
    ((= y 0) 1)
    ((odd? y) (* x (pow x (- y 1))))
    (else (square (pow x (/ y 2)))))
)


(define (unique s)
  'YOUR-CODE-HERE
  (if (null? s)
      nil
      (cons (car s) (unique (filter (lambda (x) (not (eq? x (car s)))) (cdr s)))))
)


(define (replicate x n)
  'YOUR-CODE-HERE
  (define (rep_helper x n cur)
    (if (= n 0)
        cur
        (rep_helper x (- n 1) (append cur (list x)))))
  (rep_helper x n nil)
  )


(define (accumulate combiner start n term)
  'YOUR-CODE-HERE
  (if (= n 0)
      start
      (combiner (term n) (accumulate combiner start (- n 1) term)))
)


(define (accumulate-tail combiner start n term)
  'YOUR-CODE-HERE
  (define (helper combiner2 start2 n2 term2 cur_n cur_res)
    (if (= cur_n n2)
        (combiner2 cur_res (term2 cur_n))
        (helper combiner2 start2 n2 term2 (+ cur_n 1) (combiner2 cur_res (term2 cur_n)))))
  (helper combiner start n term 1 start)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  'YOUR-CODE-HERE
  `(map (lambda (,var) ,map-expr) (filter (lambda (,var) ,filter-expr) ,lst))
)

