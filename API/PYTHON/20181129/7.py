import math


class Structure1:
    # Class variable that specifies expected fields
    _fields = []

    def __init__(self, *args):
        print('init',args,self._fields)
        if len(args) != len(self._fields):
            raise TypeError('Expected {} arguments'.format(len(self._fields)))
        # Set the arguments
        print(list(zip(self._fields, args)))
        for name, value in zip(self._fields, args):
            setattr(self, name, value)

# Example class definitions


class Stock(Structure1):
    _fields = ['name', 'shares', 'price']


class Point(Structure1):
    _fields = ['x', 'y']


class Circle(Structure1):
    _fields = ['radius']

    def area(self):
        return math.pi * self.radius ** 2


s = Stock('ACME', 50, 91.1)
# p = Point(2, 3)
