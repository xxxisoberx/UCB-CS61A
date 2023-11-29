###### 1.1

```python
def multiply(m, n):
    if n == 1:
        return m
    else:
        return multiply(m, n-1) + m
```

###### 1.2

```python
def is_prime(n):
    """
    >>> is_prime(7)
    True
    >>> is_prime(10)
    False
    >>> is_prime(1)
    False
    """
    def prime_helper(i, n):
        if n == 1:
            return False
        elif i == n:
            return True
        else:
            return (n % i != 0) and prime_helper(i+1, n)
    return prime_helper(2, n)
```



###### 2.1

```python
def count_stair_ways(n):
    if n == 1:
        return 1
    elif n == 2:
        return 2
    else:
        return count_stair_ways(n-1) + count_stair_ways(n-2)
```

###### 2.2

```python
def count_k(n, k):
    """
    >>> count_k(3, 3) # 3, 2 + 1, 1 + 2, 1 + 1 + 1
    4
    >>> count_k(4, 4)
    8
    >>> count_k(10, 3)
    274
    >>> count_k(300, 1) # Only one step at a time
    1
    """
    if n == 0 or n == 1:
        return 1
    elif n < k:
        return count_k(n, n)
    else:
        way = 0
        for i in range(k):
            way += count_k(n-i-1, k)
        return way
```



###### 3.1

```python
"""
>>> a = [1, 5, 4, [2, 3], 3]
>>> print(a[0], a[-1])
1 3
>>> len(a)
5
>>> 2 in a
False
>>> 4 in a
True
>>> a[3][0]
2
"""
```

###### 3.2

```python
def even_weighted(s):
    """
    >>> x = [1, 2, 3, 4, 5, 6]
    >>> even_weighted(x)
    [0, 6, 20]
    """
    return [s[i] * i for i in range(len(s)) if i % 2 == 0]
```

###### 3.3

```python
def max_product(s):
    """Return the maximum product that can be formed using non-consecutive
    elements of s.
    >>> max_product([10,3,1,9,2]) # 10 * 9
    90
    >>> max_product([5,10,5,10,5]) # 5 * 5 * 5
    125
    >>> max_product([])
    1
    """
    def max_pro(s_left, product):  
        length = len(s_left)
        if length == 0:
            return 1
        elif length == 1:
            return s_left[0]
        elif length == 2:
            return max(s_left[0], s_left[1])
        elif length == 3:
            return max(s_left[0] * s_left[2], s_left[1])
        else:
            pro_use_first = product * s_left[0]
            pro_use_second = product * s_left[1]
            s_without_first_two = [s_left[i] for i in range(2, length)]
            s_without_first_three = [s_left[i] for i in range(3, length)]
            after_use_first = max_pro(s_without_first_two, pro_use_first) * pro_use_first
            after_use_second = max_pro(s_without_first_three, pro_use_second) * pro_use_second
            return max(after_use_first, after_use_second)
    return max_pro(s, 1)
```



###### Whole Numbers (a)

```python
def check_hole_number(n):
    """
    >>> check_hole_number(123)
    False
    >>> check_hole_number(3241968)
    True
    >>> check_hole_number(3245968)
    False
    """
    if n < 10:
        return True 
    return ((n // 10) % 10 < n % 10) and ((n // 10) % 10 < (n // 100) % 10) and check_hole_number(n//100)
```

###### Whole Numbers (b)

```python
def check_mountain_number(n):
    """
    >>> check_mountain_number(103)
    False
    >>> check_mountain_number(153)
    True
    >>> check_mountain_number(123456)
    True
    >>> check_mountain_number(2345986)
    True
    """
    def helper(n, state, left_num_change_state):
        if n < 10:
            return left_num_change_state >= 0
        if (n % 10 < (n // 10) % 10 and state == 1) or (n % 10 > (n // 10) % 10 and state == -1):
            return helper(n//10, state, left_num_change_state)
        return helper(n//10, -state, left_num_change_state-1)
    return helper(n//10, 1 if n % 10 < (n // 10) % 10 else -1, 1 if n % 10 < (n // 10) % 10 else 0)
```

