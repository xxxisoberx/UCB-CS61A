(define (rle s)
    (define (helper s cur_value cur_num)
        (cond
            ((equal? s nil) (if (= cur_num 0) nil (cons-stream (list cur_value cur_num) nil)))
            ((= cur_value (car s)) (helper (cdr-stream s) cur_value (+ cur_num 1)))
            ((and (not (= cur_value (car s))) (= cur_num 0)) (helper s (car s) 0))
            (else (cons-stream (list cur_value cur_num) (helper s 0 0)))))
    (helper s 0 0)
)



(define (group-by-nondecreasing s)
    (define (helper s pre res)
        (cond
            ((equal? s nil) (cons-stream res nil))
            ((<= pre (car s)) (helper (cdr-stream s) (car s) (append res (list (car s)))))
            (else (cons-stream res (helper s (car s) nil)))))
    (helper s (car s) nil))


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))

