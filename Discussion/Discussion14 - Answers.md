```python
# 背景代码
class Tree:
    def __init__(self, label, branches=[]):
        for b in branches:
            assert isinstance(b, Tree)
        self.label = label
        self.branches = list(branches)

    def is_leaf(self):
        return not self.branches

    def map(self, fn):
        self.label = fn(self.label)
        for b in self.branches:
            b.map(fn)

    def __contains__(self, e):
        if self.label == e:
            return True
        for b in self.branches:
            if e in b:
                return True
        return False

    def __repr__(self):
        if self.branches:
            branch_str = ', ' + repr(self.branches)
        else:
            branch_str = ''
        return 'Tree({0}{1})'.format(self.label, branch_str)

    def __str__(self):
        def print_tree(t, indent=0):
            tree_str = '  ' * indent + str(t.label) + "\n"
            for b in t.branches:
                tree_str += print_tree(b, indent + 1)
            return tree_str
        return print_tree(self).rstrip()

class Link:
    empty = ()

    def __init__(self, first, rest=empty):
        assert rest is Link.empty or isinstance(rest, Link)
        self.first = first
        self.rest = rest

    def __repr__(self):
        if self.rest is not Link.empty:
            rest_repr = ', ' + repr(self.rest)
        else:
            rest_repr = ''
        return 'Link(' + repr(self.first) + rest_repr + ')'

    def __str__(self):
        string = '<'
        while self.rest is not Link.empty:
            string += str(self.first) + ' '
            self = self.rest
        return string + str(self.first) + '>'
```



###### 1.1

```python
def paths(x, y):
    if x == y:
        return [[x]]
    elif x > y:
        return []
    else:
        a = paths(x+1, y)
        b = paths(2*x, y)
        return [[x] + i for i in a] + [[x] + j for j in b]
```

###### 1.2

```python
def merge(s1, s2):
    if len(s1) == 0:
        return s2
    elif len(s2) == 0:
        return s1
    elif s1[0] < s2[0]:
        return [s1[0]] + merge(s1[1:], s2)
    else:
        return [s2[0]] + merge(s1, s2[1:])

def mergesort(seq):
    if not seq or len(seq) == 1:
        return seq
    return merge(mergesort(seq[:len(seq)//2]), mergesort(seq[len(seq)//2:]))
```



###### 2.1

```python
def long_paths(tree, n):
    if tree.is_leaf() and n > 0:
        return []
    elif tree.is_leaf():
        return [Link(tree.label)]
    else:
        path = []
        for b in tree.branches:
            for i in long_paths(b, n-1):
                path.append(Link(tree.label, i))
        return path
```

###### 2.2

```python
def widest_level(t):
    levels = []
    x = [t]
    while x:
        levels.append([node.label for node in x])
        x = sum([node.branches for node in x], [])
    return max(levels, key=len)
```



###### 3.1

```python
>>> cats = [1, 2]
>>> dogs = [cats, cats.append(23), list(cats)]
>>> cats
[1, 2, 23]

>>> dogs[1] = list(dogs)
>>> dogs[1]
[[1, 2, 23], None, [1, 2, 23]]

>>> dogs[0].append(2)
>>> cats
[1, 2, 23, 2]

>>> cats[1::2]
[2, 2]

>>> cats[:3]
[1, 2, 23]

>>> dogs[2].extend([list(cats).pop(0), 3])
>>> dogs[3]
Error

>>> dogs
[[1, 2, 23, 2], [[1, 2, 23, 2], None, [1, 2, 23, 1, 3]], [1, 2, 23, 1, 3]]
```



###### 4.1

```python
class Emotion(object):
    num = 0
    power = 5
    def __init__(self):
        Emotion.num += 1
    def feeling(self, other):
        if self.power == other.power:
            print("Together")
        elif self.power < other.power:
            other.catchphrase()
            self.catchphrase()
        else:
            self.catchphrase()
            other.catchphrase()

class Joy(Emotion):
    def catchphrase(self):
        print("Think positive thoughts")

class Sadness(Emotion):
    def catchphrase(self):
        print("I'm positive you will get lost")
```



###### 5.1

```python
def flip_two(lnk):
    if lnk == Link.empty or lnk.rest == Link.empty:
        return
    lnk.first, lnk.rest.first = lnk.rest.first, lnk.first
    flip_two(lnk.rest.rest)
```



###### 6.1

```python
def repeated(f):
    g = lambda x: x
    while True:
        yield g
        g = lambda x, pre_g = g: f(pre_g(x))
```

###### 6.2

```python
def ben_repeated(f):
    g = lambda x: x
    while True:
        yield g
        g = lambda x: f(g(x))

# This function doesn't work at all! g will recursively search for g!
```

###### 6.3

```python
from operator import add, mul

def accumulate(iterable, f):
    it = iter(iterable)
    total = next(it)
    yield total
    for i in it:
        total = f(total, i)
        yield total
```



###### 7.1

```scheme
(define (append-stream s1 s2)
    (if (equal? s1 nil) s2
        (cons-stream (car s1) (append-stream (cdr-stream s1) s2))))
```

###### 7.2

```scheme
(define (map-stream f s)
    (if (null? s)
        nil
        (cons-stream (f (car s)) (map-stream f (cdr-stream s)))))

(define (subset-stream lst)
    (if (null? lst)
        (cons-stream nil nil)
        (let ((rest (subset-stream (cdr lst))))
            (append-stream rest (map-stream (lambda (item) (cons (car lst) item)) rest)))))
```

###### 7.3

```python
(define (deep-map fn lst)
    (cond
        ((null? lst) nil)
        ((list? (car lst)) (cons (deep-map fn (car lst)) (deep-map fn (cdr lst))))
        (else (cons (fn (car lst)) (deep-map fn (cdr lst))))))
```

###### 7.4

```python
(define (sum lst)
    (if (null? lst)
        0
        (+ (car lst) (sum (cdr lst)))))
```



### 8

```sqlite
-- 背景代码
CREATE TABLE scoring AS
   SELECT 'Donald Stewart' AS player, 7 AS points, 1 AS quarter UNION
   SELECT 'Christopher Brown Jr.', 7, 1 UNION
   SELECT 'Ryan Sanborn', 3, 2 UNION
   SELECT 'Greg Thomas', 3, 2 UNION
   SELECT 'Cameron Scarlett', 7, 3 UNION
   SELECT 'Nikko Remigio', 7, 4 UNION
   SELECT 'Ryan Sanborn', 3, 4 UNION
   SELECT 'Chase Garbers', 7, 4;

CREATE TABLE players AS
   SELECT 'Ryan Sanborn' AS name, 'Stanford' AS team UNION
   SELECT 'Donald Stewart', 'Stanford' UNION
   SELECT 'Cameron Scarlett', 'Stanford' UNION
   SELECT 'Christopher Brown Jr.', 'Cal' UNION
   SELECT 'Greg Thomas', 'Cal' UNION
   SELECT 'Nikko Remigio', 'Cal' UNION
   SELECT 'Chase Garbers', 'Cal';
```

###### 8.1

```sqlite
select quarter from scoring group by quarter having sum(points) > 10;
```

###### 8.2

```sqlite
select sum(a.points), b.team from scoring as a, players as b
   where a.player = b.name group by team;
```

