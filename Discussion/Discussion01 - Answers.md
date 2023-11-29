###### 1.1

```python
def wears_jacket_with_if(temp, raining):
    """
    >>> wears_jacket_with_if(90, False)
    False
    >>> wears_jacket_with_if(40, False)
    True
    >>> wears_jacket_with_if(100, True)
    True
    """
    if temp < 60 or raining:
        return True
    else:
        return False
```

```python
def wears_jacket(temp, raining):
    return temp < 60 or raining
```

###### 1.2

```python
def square(x):
    print("here!")
    return x * x
def so_slow(num):
    x = num
    while x > 0:
        x = x + 1
    return x / 0
square(so_slow(5))
---
无限循环，无任何输出
```

###### 1.3

```python
def is_prime(n):
    """
    >>> is_prime(10)
    False
    >>> is_prime(7)
    True
    """
    if n < 2:
        return False
    i = n // 2
    while i > 1:
        if n % i == 0:
            return False
        i -= 1
    return True
```

###### 1.

```python
x = 3
def p(rint):
    print(rint)
def g(x, y):
    if x:
        print("one")
    elif x:
        print(True, x) # Does x being truth-y affect the printed value?
    if y:
        print(True, y) # Does y being truth-y affect the printed value?
    else:
        print(False, y) # Does y being false-y affect the printed value?
    return print(p(y)) + x
```

| Expression                      | Interactive Output                          |
| ------------------------------- | ------------------------------------------- |
| print(4, 5) + 1                 | 4 5<br />Error                              |
| 2 * 2 * 1 + x * x               | 13                                          |
| print(3 * 3 * 1)                | 9                                           |
| print(x + 1 * x + 1)            | 7                                           |
| print(print(x + 1 * x + 1))     | 7<br />None                                 |
| print(print(x + 1 * x + 1) + 1) | 7<br />Error                                |
| print(p("rint"))                | rint<br />None                              |
| x, y = 2, x<br />g(y, x)        | one<br />True 2<br />2<br />None<br />Error |
| g(y, p("rint"))                 | Error                                       |

