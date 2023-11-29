### 1

```scheme
; 背景代码
(define (naturals n)
	(cons-stream n (naturals (+ n 1))))

(define nat (naturals 0))

(define (compute-rest n)
	(print 'evaluating!)
	(cons-stream n nil))
```

###### 1.1

```scheme
scm> (define (has-even? s)
		(cond ((null? s) #f)
			((even? (car s)) #t)
			(else (has-even? (cdr-stream s)))))
has-even?

scm> (define (f x) (* 3 x))
f

scm> (define nums (cons-stream 1 (cons-stream (f 3) (cons-stream (f 5) nil))))
nums

scm> nums
(1 . #[promise])

scm> (cdr nums)
#[promise]

scm> (cdr-stream nums)
(9 . #[promise])

scm> nums
(1 . #[promise])

scm> (define (f x) (* 2 x))
f

scm> (cdr-stream nums)
(9 . #[promise])

scm> (cdr-stream (cdr-stream nums))
(10 . #[promise])

scm> (has-even? nums)
#t
```

###### 1.2

```scheme
; Correct Implementation
(define (filter-stream f s)
	(cond
		((null? s) nil)
		((f (car s)) (cons-stream (car s) (filter-stream f (cdr-stream s))))
		(else (filter-stream f (cdr-stream s)))))

; Incorrect Implementation
(define (filter-stream f s)
	(if (null? s) nil
		(let ((rest (filter-stream f (cdr-stream s))))
			(if (f (car s))
				(cons-stream (car s) rest)
				rest))))

; 第二次implementation在执行“let ((rest (filter-stream f (cdr-stream s))))”时实际上调用了let函数对stream进行计算并将其结果的引用传递给rest（函数调用会立即求值）。如果s为一个无限流，会导致程序无法终止
```

###### 1.3

```scheme
(define (map-stream f s)
  (if (null? s) nil
      (cons-stream (f (car s)) (map-stream f (cdr-stream s)))))
```

###### 1.4

```scheme
(define (slice s start end)
    (cond
        ((or (null? s) (and (= start 0) (= end 0))) nil)
        ((= start 0) (cons (car s) (slice (cdr-stream s) 0 (- end 1))))
        (else (slice (cdr-stream s) (- start 1) (- end 1)))))
```

###### 1.5

```scheme
; 背景代码
(define (combine-with f xs ys)
    (if (or (null? xs) (null? ys))
        nil
        (cons-stream
            (f (car xs) (car ys))
            (combine-with f (cdr-stream xs) (cdr-stream ys)))))

; 1.5(i)
(define factorials
    (cons-stream 1 (combine-with * (naturals 1) factorials)))

; 1.5(ii)
(define fibs
    (cons-stream 0 (cons-stream 1 (combine-with + fibs (cdr-stream fibs)))))

; 1.5(iii)
(define (exp x)
    (define (x_power x) (cons-stream 1 (map-stream (lambda (n) (* n x)) (x_power x))))
    (cons-stream 1 (combine-with + (exp x) (combine-with / (cdr-stream (x_power x)) (cdr-stream factorials)))))
```

###### 1.6

```scheme
(define (filter-stream f s)
    (cond
        ((null? s) nil)
        ((f (car s)) (cons-stream (car s) (filter-stream f (cdr-stream s))))
        (else (filter-stream f (cdr-stream s)))))

(define (sieve s)
    (define (not_divisible? n) (not (= (remainder n (car s)) 0)))
    (cons-stream (car s) (sieve (filter-stream not_divisible? (cdr-stream s)))))

(define primes
    (sieve (naturals 2)))
```



###### 2.1

```scheme
(define-macro (make-lambda expr)
    `(lambda () ,expr))
```

###### 2.2

```scheme
(define-macro (make-stream first second)
    `(cons ,first (delay ,second)))

(define (cdr-stream stream)
    (force (cdr stream)))
```

