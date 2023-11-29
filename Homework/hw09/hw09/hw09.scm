(define (reverse lst)
    (if (equal? lst nil) nil
        (append (reverse (cdr lst)) (list (car lst))))
)

