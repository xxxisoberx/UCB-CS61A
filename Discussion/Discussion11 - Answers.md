###### 1.2

```scheme
(define (reverse lst)
    (define (rev_helper lst2 res)
        (if (null? lst2)
            res
            (rev_helper (cdr lst2) (cons (car lst2) res))))
    (rev_helper lst nil))
```

###### 1.3

```scheme
(define (insert n lst)
    (define (ins_helper n2 lst2 res)
        (cond
            ((equal? lst2 nil) (append res (list n2)))
            ((< n2 (car lst2)) (append res (list n2) lst2))
            (else (ins_helper n2 (cdr lst2) (append res (list (car lst2)))))))
    (ins_helper n lst nil))
```



###### 2.1

```python
def make_lambda(params, body):
    """
    >>> f = make_lambda("x, y", "x + y")
    >>> f
    <function <lambda> at ...>
    >>> f(1, 2)
    3
    >>> g = make_lambda("a, b, c", "c if a > b else -c")
    >>> g(1, 2, 3)
    -3
    >>> make_lambda("f, x, y", "f(x, y)")(f, 1, 2)
    3
    """
    return eval("lambda " + params + ": " + body)
```

###### 2.2

```python
def make_lambda_2(params, body):
    return eval(f"lambda {params}: {body}")
```



###### 3.1

```scheme
(define-macro (or-macro expr1 expr2)
`(let ((v1 ,expr1))
    (if v1 v1
        ,expr2)))
```

###### 3.2

```scheme
(define-macro (prune-expr expr)
  (define (helper args keep?)
    (if (null? args)
        '()
        (if keep?
            (cons (car args) (helper (cdr args) #f))
            (helper (cdr args) #t))))
  `(begin (apply (eval (car ',expr)) (list ,@(helper (cdr expr) #t)))))
```

###### 3.3(a)

```scheme
(define-macro (when condition exprs)
    (list 'if condition (cons 'begin exprs) ''okay))
```

###### 3.3(b)

```scheme
(define-macro (when_2 condition exprs)
    `(if ,condition (begin ,@exprs) 'okay))
```

