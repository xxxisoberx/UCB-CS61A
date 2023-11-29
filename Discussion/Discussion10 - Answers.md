###### 3.1

```scheme
scm> (define a (+ 1 2))
a

scm> a
3

scm> (define b (+ (* 3 3) (* 4 4)))
b

scm> (+ a b)
28

scm> (= (modulo 10 3) (quotient 5 3))
#t

scm> (even? (+ (- (* 5 4) 3) 2))
#f
```



###### 4.1

```scheme
scm> (if (or #t (/ 1 0)) 1 (/ 1 0))
1

scm> (if (> 4 3) (+ 1 2 3 4) (+ 3 4 (* 3 2)))
10

scm> ((if (< 4 3) + -) 4 100)
-96

scm> (if 0 1 2)
1
```

###### 4.1

```scheme
(define (factorial x)
        (if (= x 0)
            1
            (* x (factorial (- x 1)))))
```

###### 4.2

```scheme
(define (fib n)
        (cond
            ((= n 0) 0)
            ((= n 1) 1)
            (else (+ (fib (- n 2)) (fib (- n 1))))))
```



###### 5.1

```scheme
(define (my-append a b)
        (if (null? a)
            b
            (cons (car a) (my-append (cdr a) b))))
```

###### 5.2

```scheme
(define (insert element lst index)
        (if (= index 0)
            (cons element lst)
            (cons (car lst) (insert element (cdr lst) (- index 1)))))
```

###### 5.3

```scheme
(define (duplicate lst)
        (if (null? lst)
            nil
            (cons (car lst) (cons (car lst) (duplicate (cdr lst))))))
```

