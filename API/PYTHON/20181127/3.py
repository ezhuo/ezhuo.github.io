import sys


def func(c):
    d = c
    print('in func function', sys.getrefcount(c) - 1)


print('init', sys.getrefcount(11) - 1)
a = 11
print('after a=11', sys.getrefcount(11) - 1)
b = a
print('after b=1', sys.getrefcount(11) - 1)
func(11)
print('after func(a)', sys.getrefcount(11) - 1)
list1 = [a, 12, 14]
print('after list1=[a,12,14]', sys.getrefcount(11) - 1)
a = 12
print('after a=12', sys.getrefcount(11) - 1)
del a
print('after del a', sys.getrefcount(11) - 1)
del b
print('after del b', sys.getrefcount(11) - 1)
# list1.pop(0)
# print 'after pop list1',sys.getrefcount(11)-1
del list1
print('after del list1', sys.getrefcount(11) - 1)
