
(define-macro (def func args body)
    'YOUR-CODE-HERE
    `(define (,func ,@args) ,body))


(define (map-stream f s)
    (if (null? s)
    	nil
    	(cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define all-three-multiples
  (cons-stream 3 (map-stream (lambda (x) (+ x 3)) all-three-multiples))
)


(define (compose-all funcs)
  (if (equal? funcs nil)
      (lambda (x) x)
      (lambda (x) ((compose-all (cdr funcs)) ((car funcs) x))))
)


(define (partial-sums stream)
  (define (helper cur_sums stream)
    (if (equal? stream nil)
        nil
        (cons-stream (+ cur_sums (car stream)) (helper (+ cur_sums (car stream)) (cdr-stream stream)))))
  (helper 0 stream)
)

