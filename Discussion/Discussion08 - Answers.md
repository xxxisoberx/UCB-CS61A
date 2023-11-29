###### 1.1

```python
>>> lst = [6, 1, "a"]
>>> next(lst)
Error

>>> lst_iter = iter(lst)
>>> next(lst_iter)
6

>>> next(lst_iter)
1

>>> next(iter(lst))
6

>>> [x for x in lst_iter]
["a"]
```



###### 2.1

```python
def generate_subsets():
    """
    >>> subsets = generate_subsets()
    >>> for _ in range(3):
    ... print(next(subsets))
    ...
    [[]]
    [[], [1]]
    [[], [1], [2], [1, 2]]
    """
    def subset(lst):
        # return [1, 2, ..., n]'s subsets(iterable or iterator)
        if not lst:
            return [[]]
        sub_without_first = subset(lst[1:])
        sub_with_first = [[lst[0]] + i for i in sub_without_first]
        return sub_with_first + sub_without_first
        # return iter(sub_with_first + sub_without_first)
    
    count_next = 0
    while True:
        yield subset(list(range(1, count_next+1)))
        count_next += 1
```

###### 2.2

```python
def sum_paths_gen(t):
    """
    >>> t1 = tree(5)
    >>> next(sum_paths_gen(t1))
    5
    >>> t2 = tree(1, [tree(2, [tree(3), tree(4)]), tree(9)])
    >>> sorted(sum_paths_gen(t2))
    [6, 7, 10]
    """
    if is_leaf(t):
        yield label(t)
    for branch in branches(t):
        for i in list(sum_paths_gen(branch)):
            yield label(t) + i

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



###### 3.1

```python
class Student:
    students = 0 # this is a class attribute
    def __init__(self, name, ta):
        self.name = name # this is an instance attribute
        self.understanding = 0
        Student.students += 1
        print("There are now", Student.students, "students")
        ta.add_student(self)
    def visit_office_hours(self, staff):
        staff.assist(self)
        print("Thanks, " + staff.name)

class Professor:
    def __init__(self, name):
        self.name = name
        self.students = {}
    def add_student(self, student):
        self.students[student.name] = student
    def assist(self, student):
        student.understanding += 1

"""
>>> callahan = Professor("Callahan")
>>> elle = Student("Elle", callahan)
There are now 1 students
>>> elle.visit_office_hours(callahan)
Thanks, Callahan
>>> elle.visit_office_hours(Professor("Paulette"))
Thanks, Paulette
>>> elle.understanding
2
>>> [name for name in callahan.students]
['Elle']
>>> x = Student("Vivian", Professor("Stromwell")).name
There are now 2 students
>>> x
'Vivian'
>>> [name for name in callahan.students]
['Elle']
"""
```

###### 3.2

```python
class Email:
    """Every email object has 3 instance attributes: the
    message, the sender name, and the recipient name.
    """
    def __init__(self, msg, sender_name, recipient_name):
        self.message = msg
        self.sender_name = sender_name
        self.recipient_name = recipient_name

class Server:
    """Each Server has an instance attribute clients, which
    is a dictionary that associates client names with
    client objects.
    """
    def __init__(self):
        self.clients = {}

    def send(self, email):
        """Take an email and put it in the inbox of the client
        it is addressed to.
        """
        if email.recipient_name in self.clients:
            self.clients[email.recipient_name].receive(email)

    def register_client(self, client, client_name):
        """Takes a client object and client_name and adds them
        to the clients instance attribute.
        """
        self.clients[client_name] = client

class Client:
    """Every Client has instance attributes name (which is
    used for addressing emails to the client), server
    (which is used to send emails out to other clients), and
    inbox (a list of all emails the client has received).
    """
    def __init__(self, server, name):
        self.inbox = []
        self.server = server
        self.name = name
        self.server.register_client(self, self.name)

    def compose(self, msg, recipient_name):
        """Send an email with the given message msg to the
        given recipient client.
        """
        email = Email(msg, self.name, recipient_name)
        self.server.send(email)

    def receive(self, email):
        """Take an email and add it to the inbox of this
        client.
        """
        self.inbox.append(email)
```



###### 4.1

```python
class Pet():
    def __init__(self, name, owner):
        self.is_alive = True # It's alive!!!
        self.name = name
        self.owner = owner
    def eat(self, thing):
        print(self.name + " ate a " + str(thing) + "!")
    def talk(self):
        print(self.name)

class Cat(Pet):
    def __init__(self, name, owner, lives=9):
        super().__init__(name, owner)
        self.lives = lives

    def talk(self):
        """ Print out a cat's greeting.
        >>> Cat('Thomas', 'Tammy').talk()
        Thomas says meow!
        """
        print(self.name + ' says meow!')

    def lose_life(self):
        """Decrements a cat's life by 1. When lives reaches zero, 'is_alive'
        becomes False. If this is called after lives has reached zero, print out
        that the cat has no more lives to lose.
        """
        if self.is_alive:
            self.lives -= 1
            if self.lives == 0:
                self.is_alive = False
        else:
            print("The cat has no more lives to lose!")
```

###### 4.2

```python
class NoisyCat(Cat): # Fill me in!
    """A Cat that repeats things twice."""
    # def __init__(self, name, owner, lives=9):
        # Is this method necessary? Why or why not?
    def talk(self):
        """Talks twice as much as a regular cat.
        >>> NoisyCat('Magic', 'James').talk()
        Magic says meow!
        Magic says meow!
        """
        for _ in range(2):
            super().talk()
```

###### 4.3

```python
class A:
    def f(self):
        return 2
    def g(self, obj, x):
        if x == 0:
            return A.f(obj)
        return obj.f() + self.g(self, x - 1)
    
class B(A):
    def f(self):
        return 4
    
"""
>>> x, y = A(), B()
>>> x.f()
2
>>> B.f()
Error
>>> x.g(x, 1)
4
>>> y.g(x, 2)
8
"""
```

