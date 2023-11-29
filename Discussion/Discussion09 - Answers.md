### 1

```python
# 背景代码
class Link:
    empty = ()
    def __init__(self, first, rest=empty):
        assert rest is Link.empty or isinstance(rest, Link)
        self.first = first
        self.rest = rest
    def __repr__(self):
        if self.rest:
            rest_str = ', ' + repr(self.rest)
        else:
            rest_str = ''
        return 'Link({0}{1})'.format(repr(self.first), rest_str)
    def __str__(self):
        string = '<'
        while self.rest is not Link.empty:
            string += str(self.first) + ' '
            self = self.rest
        return string + str(self.first) + '>'
```

###### 1.1

```python
def sum_nums(lnk):
    """
    >>> a = Link(1, Link(6, Link(7)))
    >>> sum_nums(a)
    14
    """
    if lnk is Link.empty:
        return 0
    else:
        return lnk.first + sum_nums(lnk.rest)
```

###### 1.2

```python
def multiply_lnks(lst_of_lnks):
    """
    >>> a = Link(2, Link(3, Link(5)))
    >>> b = Link(6, Link(4, Link(2)))
    >>> c = Link(4, Link(1, Link(0, Link(2))))
    >>> p = multiply_lnks([a, b, c])
    >>> p.first
    48
    >>> p.rest.first
    12
    >>> p.rest.rest.rest is Link.empty
    True
    """
    if len(lst_of_lnks) == 1:
        return lst_of_lnks[0]
    else:
        prod_lst = []
        while Link.empty not in lst_of_lnks:
            prod = 1
            for i in range(len(lst_of_lnks)):
                prod *= lst_of_lnks[i].first
                if lst_of_lnks[i].rest == Link.empty:
                    lst_of_lnks[i] = Link.empty
                else:
                    lst_of_lnks[i].first = lst_of_lnks[i].rest.first
                    lst_of_lnks[i].rest = lst_of_lnks[i].rest.rest
            prod_lst.append(prod)
        
        final_lst = Link.empty
        while prod_lst:
            final_lst = Link(prod_lst.pop(), final_lst)
        return final_lst
```

###### 1.3

```python
def filter_link(link, f):
    """
    >>> link = Link(1, Link(2, Link(3)))
    >>> g = filter_link(link, lambda x: x % 2 == 0)
    >>> next(g)
    2
    >>> next(g)
    StopIteration
    >>> list(filter_link(link, lambda x: x % 2 != 0))
    [1, 3]
    """
    while link != Link.empty:
        if f(link.first):
            yield link.first
        link = link.rest

def filter_no_iter(link, f):
    """
    >>> link = Link(1, Link(2, Link(3)))
    >>> list(filter_no_iter(link, lambda x: x % 2 != 0))
    [1, 3]
    """
    if link == Link.empty:
        return
    elif f(link.first):
        yield link.first
    yield from filter_no_iter(link.rest, f)
```



### 2

```python
# 背景代码
class Tree:
    def __init__(self, label, branches=[]):
        for b in branches:
            assert isinstance(b, Tree)
        self.label = label
        self.branches = branches
        
    def is_leaf(self):
        return not self.branches
    
    def __repr__(self):
        if self.branches:
            branch_str = ', ' + repr(self.branches)
        else:
            branch_str = ''
        return 'Tree({0}{1})'.format(self.label, branch_str)
```

###### 2,1

```python
def make_even(t):
    """
    >>> t = Tree(1, [Tree(2, [Tree(3)]), Tree(4), Tree(5)])
    >>> make_even(t)
    >>> t.label
    2
    >>> t.branches[0].branches[0].label
    4
    """
    t.label += 1 if t.label % 2 != 0 else 0
    for b in t.branches:
        make_even(b)
```

###### 2.2

```python
def square_tree(t):
    """Mutates a Tree t by squaring all its elements."""
    t.label = t.label ** 2
    for b in t.branches:
        square_tree(b)
```

###### 2.3

```python
def find_path(t, entry):
    if t.label == entry:
        return [t.label]
    for b in t.branches:
        sub_path = find_path(b, entry)
        if sub_path:
            return [t.label] + sub_path
    return False
```

###### 2.4

```python
def average(t):
    """
    Returns the average value of all the nodes in t.
    >>> t0 = Tree(0, [Tree(1), Tree(2, [Tree(3)])])
    >>> average(t0)
    1.5
    >>> t1 = Tree(8, [t0, Tree(4)])
    >>> average(t1)
    3.0
    """
    def sum_helper(t):
        total, count = t.label, 1
        for b in t.branches:
            tot, cou = sum_helper(b)
            total += tot
            count += cou
        return total, count
    total, count = sum_helper(t)
    return total / count
```

###### 2.5

```python
def combine_tree(t1, t2, combiner):
    """
    >>> a = Tree(1, [Tree(2, [Tree(3)])])
    >>> b = Tree(4, [Tree(5, [Tree(6)])])
    >>> combined = combine_tree(a, b, mul)
    >>> combined.label
    4
    >>> combined.branches[0].label
    10
    """
    if t1.is_leaf():
        return Tree(combiner(t1.label, t2.label))
    
    final_tree_branches = []
    for tup in zip(t1.branches, t2.branches):
        final_tree_branches += [combine_tree(tup[0], tup[1], combiner)]
    return Tree(combiner(t1.label, t2.label), final_tree_branches)
```

###### 2.6

```python
def alt_tree_map(t, map_fn):
    """
    >>> t = Tree(1, [Tree(2, [Tree(3)]), Tree(4)])
    >>> negate = lambda x: -x
    >>> alt_tree_map(t, negate)
    Tree(-1, [Tree(2, [Tree(-3)]), Tree(4)])
    """
    t.label = map_fn(t.label)
    for b in t.branches:
        for b2 in b.branches:
            alt_tree_map(b2, map_fn)
    return t

"""
def ret(tree):
    if isinstance(tree, list):
        ele_ret_lst = [ret(b) for b in tree]
        return "[" + ', '.join(ele_ret_lst) + "]"
    elif tree.is_leaf():
        return "Tree({})".format(tree.label)
    return "Tree({}, {})".format(tree.label, ret(tree.branches))
"""
```

