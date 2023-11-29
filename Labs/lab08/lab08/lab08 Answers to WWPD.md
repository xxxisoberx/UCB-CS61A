```python
>>> s = [1, 2, 3, 4]
>>> t = iter(s)
>>> next(s)
Error

>>> next(t)
1

>>> next(t)
2

>>> iter(s)
Iterator

>>> next(iter(s))
1

>>> next(iter(t))
3

>>> next(iter(s))
1

>>> next(iter(t))
4

>>> next(t)
StopIteration
```

```python
>>> r = range(6)
>>> r_iter = iter(r)
>>> next(r_iter)
0

>>> [x + 1 for x in r]
[1, 2, 3, 4, 5, 6]

>>> [x + 1 for x in r_iter]
[2, 3, 4, 5, 6]

>>> next(r_iter)
StopIteration

>>> list(range(-2, 4))   # Converts an iterable into a list
[-2, -1, 0, 1, 2, 3]
```

```python
>>> map_iter = map(lambda x : x + 10, range(5))
>>> next(map_iter)
10

>>> next(map_iter)
11

>>> list(map_iter)
[12, 13, 14]

>>> for e in filter(lambda x : x % 2 == 0, range(1000, 1008)):
...     print(e)
...
1000
1002
1004
1006

>>> [x + y for x, y in zip([1, 2, 3], [4, 5, 6])]
[5, 7, 9]

>>> for e in zip([10, 9, 8], range(3)):
...   print(tuple(map(lambda x: x + 2, e)))
...
(12, 2)
(11, 3)
(10, 4)
```



```python
# 背景代码
class Car(object):
    num_wheels = 4
    gas = 30
    headlights = 2
    size = 'Tiny'

    def __init__(self, make, model):
        self.make = make
        self.model = model
        self.color = 'No color yet. You need to paint me.'
        self.wheels = Car.num_wheels
        self.gas = Car.gas

    def paint(self, color):
        self.color = color
        return self.make + ' ' + self.model + ' is now ' + color

    def drive(self):
        if self.wheels < Car.num_wheels or self.gas <= 0:
            return 'Cannot drive!'
        self.gas -= 10
        return self.make + ' ' + self.model + ' goes vroom!'

    def pop_tire(self):
        if self.wheels > 0:
            self.wheels -= 1

    def fill_gas(self):
        self.gas += 20
        return 'Gas level: ' + str(self.gas)

    
>>> deneros_car = Car('Tesla', 'Model S')
>>> deneros_car.model
'Model S'

>>> deneros_car.gas = 10
>>> deneros_car.drive()
'Tesla Model S goes vroom!'

>>> deneros_car.drive()
'Cannot drive!'

>>> deneros_car.fill_gas()
'Gas level: 20'

>>> deneros_car.gas
20

>>> Car.gas
30


>>> deneros_car = Car('Tesla', 'Model S')
>>> deneros_car.wheels = 2
>>> deneros_car.wheels
2

>>> Car.num_wheels
4

>>> deneros_car.drive()
'Cannot drive!'

>>> Car.drive()
Error

>>> Car.drive(deneros_car)
'Cannot drive!'
```

```python
# 背景代码
class MonsterTruck(Car):
     size = 'Monster'

     def rev(self):
         print('Vroom! This Monster Truck is huge!')

     def drive(self):
         self.rev()
         return Car.drive(self)
    

>>> deneros_car = MonsterTruck('Monster', 'Batmobile')
>>> deneros_car.drive()
Vroom! This Monster Truck is huge!
'Monster Batmobile goes vroom!'

>>> Car.drive(deneros_car)
'Monster Batmobile goes vroom!'

>>> MonsterTruck.drive(deneros_car)
Vroom! This Monster Truck is huge!
'Monster Batmobile goes vroom!'

>>> Car.rev(deneros_car)
Error
```

