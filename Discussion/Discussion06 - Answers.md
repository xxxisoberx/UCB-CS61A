###### 1.1

```python
def stepper(num):
    def step():
        nonlocal num
        num = num + 1
        return num
    return step

"""
>>> s = stepper(3)
>>> s()
4
>>> s()
5
"""
```

###### 1.2

```python
def memory(n):
    """
    >>> f = memory(10)
    >>> f(lambda x: x * 2)
    20
    >>> f(lambda x: x - 7)
    13
    >>> f(lambda x: x > 5)
    True
    """
    def func(f):
        nonlocal n
        n = f(n)
        return n
    return func
```

###### 2.1

```python
from operator import add

six = 1

def ty(one, a):
    summer = one(a, six)
    return summer

"""
>>> six = ty(add, 6)
# Output nothing but six = 7
>>> summer = ty(add, 6)
# Output nothing but summer = 13
"""
```

###### 2.2

```python
def nonlocalist():
    """
    >>> prepend, get = nonlocalist()
    >>> prepend(2)
    >>> prepend(3)
    >>> prepend(4)
    >>> get(0)
    4
    >>> get(1)
    3
    >>> get(2)
    2
    >>> prepend(8)
    >>> get(2)
    3
    """
    get = lambda x: "Index out of range!"
    def prepend(value):
        nonlocal get
        f = get
        def get(i):
            if i == 0:
                return value
            return f(i-1)
        
    return prepend, lambda x: get(x)
```

###### 2.3

```python
"""
>>> f = lambda x: [print(i+1) for i in range(x)]
>>> f = f(10)
1
2
3
4
5
6
7
8
9
10
>>> f
[None, None, None, None, None, None, None, None, None, None]
"""
```

###### 2.4

```python
square = lambda x: x * x
double = lambda x: 2 * x
def memory(x, f):
    """Return a higher-order function that prints its
    memories.
    >>> k = memory(3, lambda x: x)
    >>> k = k(square)
    3
    >>> k = k(double)
    9
    >>> k = k(print)
    6
    >>> k = k(square)
    3
    None
    """
    def g(h):
        print(f(x))
        return memory(x, h)
    return g
```

###### 2.5

```python
def announce_losses(who, last_score=0):
    """
    >>> f = announce_losses(0)
    >>> f1 = f(10, 0)
    >>> f2 = f1(1, 10) # Player 0 loses points due to swine swap
    Oh no! Player 0 just lost 9 point(s).
    >>> f3 = f2(7, 10)
    >>> f4 = f3(7, 11) # Should not announce when player 0's score does not change
    >>> f5 = f4(11, 12)
    """
    assert who == 0 or who == 1, 'The who argument should indicate a player.'
    def say(score0, score1):
        if who == 0:
            score = score0
        elif who == 1:
            score = score1
        if score < last_score:
            print("Oh no! Player " + str(who) + " just lost " + str(last_score-score) + " point(s).")
        return announce_losses(who, score0 if who == 0 else score1)
    return say
```

###### 2.6

```python
def fox_says(start, middle, end, num):
    """
    >>> fox_says('wa', 'pa', 'pow', 3)
    'wa-pa-pa-pa-pow'
    >>> fox_says('fraka', 'kaka', 'kow', 4)
    'fraka-kaka-kaka-kaka-kaka-kow'
    """
    def repeat(k):
        if k == 1:
            return middle
        else:
            return middle + '-' + repeat(k-1)
    return start + '-' + repeat(num) + '-' + end
```

###### 2.7

```python
def primary_stress(t):
    """
    >>> word = tree("", [
    tree("w", [tree("s", [tree("min")]), tree("w", [tree("ne")])]),
    tree("s", [tree("s", [tree("so")]), tree("w", [tree("ta")])])])
    >>> primary_stress(word)
    'so'
    >>> phrase = tree("", [
    tree("s", [tree("s", [tree("law")]), tree("w", [tree("degree")])]),
    tree("w", [tree("requirement")])])
    >>> primary_stress(phrase)
    'law'
    """
    def helper(t, num_s):
        if is_leaf(t):
            return [label(t), num_s]
        if label(t) == "s":
            num_s = num_s + 1
        return max([helper(b, num_s) for b in branches(t)],
            key = lambda x: branches(x))
    return label(helper(t, 0))


# 背景代码
def tree(label, branches=[]):
    """Construct a tree with the given label value and a list of branches."""
    for branch in branches:
        assert is_tree(branch)
    return [label] + list(branches)

def label(tree):
    """Return the label value of a tree."""
    return tree[0]

def branches(tree):
    """Return the list of branches of the given tree."""
    return tree[1:]

def is_tree(tree):
    """Returns True if the given tree is a tree, and False otherwise."""
    if type(tree) != list or len(tree) < 1:
        return False
    for branch in branches(tree):
        if not is_tree(branch):
            return False
    return True

def is_leaf(tree):
    """Returns True if the given tree's list of branches is empty, and False
    otherwise."""
    return not branches(tree)
```

###### 2.8

```python
def subset_sum(seq, k):
    if not seq:
        if k == 0:
            return True
        return False
    else:
        return subset_sum(seq[1:], k) or subset_sum(seq[1:], k-seq[0])
```

