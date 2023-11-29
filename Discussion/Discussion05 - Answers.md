###### 背景代码

```python
def tree(label, branches=[]):
    """Construct a tree with the given label value and a list of branches."""
    for branch in branches:
        assert is_tree(branch), 'branches must be trees'
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
    otherwise.
    """
    return not branches(tree)

def print_tree(t, indent=0):
    """Print a representation of this tree in which each node is
    indented by two spaces times its depth from the root.

    >>> print_tree(tree(1))
    1
    >>> print_tree(tree(1, [tree(2)]))
    1
      2
    >>> numbers = tree(1, [tree(2), tree(3, [tree(4), tree(5)]), tree(6, [tree(7)])])
    >>> print_tree(numbers)
    1
      2
      3
        4
        5
      6
        7
    """
    print('  ' * indent + str(label(t)))
    for b in branches(t):
        print_tree(b, indent + 1)

def copy_tree(t):
    """Returns a copy of t. Only for testing purposes.

    >>> t = tree(5)
    >>> copy = copy_tree(t)
    >>> t = tree(6)
    >>> print_tree(copy)
    5
    """
    return tree(label(t), [copy_tree(b) for b in branches(t)])
```



###### 1.1

```python
def height(t):
    """Return the height of a tree.
    >>> t = tree(3, [tree(5, [tree(1)]), tree(2)])
    >>> height(t)
    2
    """
    if is_leaf(t):
        return 0
    else:
        return 1 + max([height(i) for i in branches(t)])
```

###### 1.2

```python
def square_tree(t):
    """Return a tree with the square of every element in t
    >>> numbers = tree(1,
    ...             [tree(2,
    ...                 [tree(3),
    ...                  tree(4)]),
    ...              tree(5,
    ...                 [tree(6,
    ...                     [tree(7)]),
    ...                  tree(8)])])
    >>> print_tree(square_tree(numbers))
    1
        4
            9
            16
        25
            36
                49
            64
    """
    if is_leaf(t):
        return tree(label(t) ** 2)
    else:
        return tree(label(t) ** 2, [square_tree(b) for b in branches(t)])
```

###### 1.3

```python
def find_path(tree, x):
    """
    >>> t = tree(2, [tree(7, [tree(3), tree(6, [tree(5), tree(11)])] ), tree(15)])
    >>> find_path(t, 5)
    [2, 7, 6, 5]
    >>> find_path(t, 10) # returns None
    """
    if label(tree) == x:
        return [x]
    for b in branches(tree):
        path = find_path(b, x)
        if path:
            return [label(tree)] + path
```

###### 1.4

```python
t = tree(1, [tree(2), tree(3)])
1. label(t)
    1, No
2. t[0]
    1, Yes, label(t)
3. label(branches(t)[0])
    2, Yes, label(label(branches(t)))
4. label(branches(t))
    [2], No
5. is_leaf(t[1:][1])
    True, Yes, is_leaf(branches(t)[1])
6. [label(b) for b in branches(t)]
    [2, 3], No
7. branches(tree(2, tree(t, [])))[0]
    [1, [2, 3]], Yes, label(branches(tree(2, tree(t, []))))
```

###### 2.1

```python
>>> lst1 = [1, 2, 3]
>>> lst2 = lst1
>>> lst1 is lst2
True
>>> lst2.extend([5, 6])
>>> lst1[4]
6
>>> lst1.append([-1, 0, 1])
>>> -1 in lst1
False
>>> lst2[5]
[-1, 0, 1]
>>> lst3 = lst2[:]
>>> lst3.insert(3, lst2.pop(3))
>>> len(lst1)
5
>>> lst1[4] is lst3[6]
True
>>> lst3[lst2[4][1]]
1
>>> lst1[:3] is lst2[:3]
False
>>> lst1[:3] == lst2[:3]
True
>>> x = (1, 2, [4, 5, 6])
>>> x[2] = [3, 5, 6]
Error
>>> x
(1, 2, [4, 5, 6])
>>> x[2][0] = 3
>>> x
(1, 2, [3, 5, 6])
```

###### 2.2

```python
def add_this_many(x, el, lst):
    """ Adds el to the end of lst the number of times x occurs
    in lst.
    >>> lst = [1, 2, 4, 2, 1]
    >>> add_this_many(1, 5, lst)
    >>> lst
    [1, 2, 4, 2, 1, 5, 5]
    >>> add_this_many(2, 2, lst)
    >>> lst
    [1, 2, 4, 2, 1, 5, 5, 2, 2]
    """
    lst += [el for i in lst if i == x]
```

###### 2.3

```python
def group_by(s, fn):
    """
    >>> group_by([12, 23, 14, 45], lambda p: p // 10)
    {1: [12, 14], 2: [23], 4: [45]}
    >>> group_by(range(-3, 4), lambda x: x * x)
    {0: [0], 1: [-1, 1], 4: [-2, 2], 9: [-3, 3]}
    """
    d = {}
    for i in s:
        if fn(i) not in d:
            d[fn(i)] = [i]
        else:
            d[fn(i)] += [i]
    return d
```

###### Quiz (a)

```python
def partition_options(total, biggest):
    """
    >>> partition_options(2, 2)
    [[2], [1, 1]]
    >>> partition_options(3, 3)
    [[3], [2, 1], [1, 1, 1]]
    >>> partition_options(4, 3)
    [[3, 1], [2, 2], [2, 1, 1], [1, 1, 1, 1]]
    """
    if total == 0:
        return [[1 for _ in range(total)]]
    elif total < 0 or biggest == 0:
        return []
    else:
        with_biggest = partition_options(total - biggest, biggest)
        without_biggest = partition_options(total, biggest - 1) 
        with_biggest = [[biggest] + i for i in with_biggest]
        return with_biggest + without_biggest
```

###### Quiz (b)

```python
def min_elements(T, lst):
    """
    >>> min_elements(10, [4, 2, 1]) # 4 + 4 + 2
    3
    >>> min_elements(12, [9, 4, 1]) # 4 + 4 + 4
    3
    >>> min_elements(0, [1, 2, 3])
    0
    """
    if T == 0:
        return 0
    return min(1 + min_elements(T - e, lst) for e in lst if T - e >= 0)
```

