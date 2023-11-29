```python
>>> lambda x: x  # A lambda expression with one parameter x
Function

>>> a = lambda x: x  # Assigning the lambda function to the name a
>>> a(5)
5

>>> (lambda: 3)()  # Using a lambda expression as an operator in a call exp.
3

>>> b = lambda x: lambda: x  # Lambdas can return other lambdas!
>>> c = b(88)
>>> c
Function

>>> c()
88

>>> d = lambda f: f(4)  # They can have functions as arguments as well.
>>> def square(x):
...     return x * x
>>> d(square)
16
```

```python
>>> x = None # remember to review the rules of WWPD given above!
>>> x
>>> lambda x: x
Function
```

```python
>>> z = 3
>>> e = lambda x: lambda y: lambda: x + y + z
>>> e(0)(1)()
4

>>> f = lambda z: x + z
>>> f(3)
Error
```

```python
>>> higher_order_lambda = lambda f: lambda x: f(x)
>>> g = lambda x: x * x
>>> higher_order_lambda(2)(g)  # Which argument belongs to which function call?
Error

>>> higher_order_lambda(g)(2)
4

>>> call_thrice = lambda f: lambda x: f(f(f(x)))
>>> call_thrice(lambda y: y + 1)(0)
3

>>> print_lambda = lambda z: print(z)  # When is the return expression of a lambda expression executed?
>>> print_lambda
Function

>>> one_thousand = print_lambda(1000)
1000

>>> one_thousand
Nothing
```



```python
>>> def even(f):
...     def odd(x):
...         if x < 0:
...             return f(-x)
...         return f(x)
...     return odd
>>> steven = lambda x: x
>>> stewart = even(steven)
>>> stewart
Function

>>> stewart(61)
61

>>> stewart(-4)
4
```

```python
>>> def cake():
...    print('beets')
...    def pie():
...        print('sweets')
...        return 'cake'
...    return pie
>>> chocolate = cake()
beets

>>> chocolate
Function

>>> chocolate()
sweets
'cake'

>>> more_chocolate, more_cake = chocolate(), cake
sweets

>>> more_chocolate
'cake'

>>> def snake(x, y):
...    if cake == more_cake:
...        return chocolate
...    else:
...        return x + y
>>> snake(10, 20)
Function

>>> snake(10, 20)()
sweets
'cake'

>>> cake = 'cake'
>>> snake(10, 20)
30
```

