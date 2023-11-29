(define (over-or-under num1 num2)
  ; 'YOUR-CODE-HERE
  (cond
    ((< num1 num2) -1)
    ((> num1 num2) 1)
    (else 0)))

;;; Tests
(over-or-under 1 2)
; expect -1
(over-or-under 2 1)
; expect 1
(over-or-under 1 1)
; expect 0


(define (filter-lst fn lst)
  ; 'YOUR-CODE-HERE
  (if (null? lst)
      nil
      (if (fn (car lst))
              (cons (car lst) (filter-lst fn (cdr lst)))
              (filter-lst fn (cdr lst)))))

;;; Tests
(define (even? x)
  (= (modulo x 2) 0))
(filter-lst even? '(0 1 1 2 3 5 8))
; expect (0 2 8)


(define (make-adder num)
  'YOUR-CODE-HERE
  (begin
    (lambda (inc) 
          (+ num inc)))
)

;;; Tests
(define adder (make-adder 5))
(adder 8)
; expect 13


(define lst
  ; 'YOUR-CODE-HERE
  (cons (cons 1 nil)
        (cons 2 (cons (cons 3 (cons 4 nil))
                      (cons 5 nil))))
)


(define (composed f g)
  ; 'YOUR-CODE-HERE
  (begin
    (lambda (x) (f (g x))))
)


(define (remove item lst)
  ; 'YOUR-CODE-HERE
  (filter-lst (lambda (x) (not (= x item))) lst)
)


;;; Tests
(remove 3 nil)
; expect ()
(remove 3 '(1 3 5))
; expect (1 5)
(remove 5 '(5 3 5 5 1 4 5 4))
; expect (3 1 4 4)


(define (no-repeats s)
  ; 'YOUR-CODE-HERE
  (if (null? s)
      nil
      (cons (car s) (no-repeats (remove (car s) (cdr s)))))
)


(define (substitute s old new)
  ; 'YOUR-CODE-HERE
  (if (null? s)
      nil
      (if (pair? (car s))
          (cons (substitute (car s) old new) (substitute (cdr s) old new))
          (if (eq? (car s) old)
              (cons new (substitute (cdr s) old new))
              (cons (car s) (substitute (cdr s) old new)))))
)


(define (sub-all s olds news)
  ; 'YOUR-CODE-HERE
  ; Solution 1
  ;(begin
  ;  (define (pos_ele ele lst)
  ;          (cond
  ;              ((null? lst) #f)
  ;              ((eq? ele (car lst)) lst)
  ;              (else (pos_ele ele (cdr lst))))
  ;  )
  ;  (define (lst_idx idx lst)
  ;          (if (= idx 0)
  ;              (car lst)
  ;              (lst_idx (- idx 1) (cdr lst))))
  ;  (if (null? s)
  ;      nil
  ;      (if (pair? (car s))
  ;          (cons (sub-all (car s) olds news) (sub-all (cdr s) olds news))
  ;          (if (pos_ele (car s) olds)
  ;              (cons (lst_idx (- (length olds) (length (pos_ele (car s) olds))) news) (sub-all (cdr s) olds news))
  ;              (cons (car s) (sub-all (cdr s) olds news)))))  
  ;)

  ; Solution 2
  (if (= (length olds) 0)
      s
      (substitute (sub-all s (cdr olds) (cdr news)) (car olds) (car news)))
)
