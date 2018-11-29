from collections import ChainMap
a = {'x': 1, 'z': 3}
b = {'y': 2, 'z': 4}
c = {}
c.update(a)
c.update(b)

print(c)


