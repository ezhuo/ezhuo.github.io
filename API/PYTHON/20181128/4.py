from itertools import zip_longest

xpts = [1, 5, 4, 2, 10, 7]
ypts = [101, 78, 37, 15, 62, 99]

a = zip_longest(xpts, ypts)
for idx in a:
    print(idx)
