```python
>>> def f(a, b):
...     if a > b:
...     	return f(a - 3, 2 * b)
...     elif a < b:
...		return f(b // 2, a)
...     else:
...     	return b
>>> f(2, 2)
2

>>> f(7, 4)
4

>>> f(2, 28)
8

>>> f(-1, -3)
Infinite
```



```python
>>> def crust():
...     print("70km")
...     def mantle():
...          print("2900km")
...          def core():
...               print("5300km")
...               return mantle()
...          return core
...     return mantle
>>> drill = crust
>>> drill = drill()
70km

>>> drill = drill()
2900km

>>> drill = drill()
5300km
2900km

>>> drill()
5300km
2900km
Function
```

