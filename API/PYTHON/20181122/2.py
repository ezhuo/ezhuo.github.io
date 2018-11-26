def g():
    print('1')
    x = yield 'hello'
    if (x == None):
        x = 0
    print('2', 'x=', x)
    x += 1
    x += 1
    idx = 7
    while (idx > 0):
        idx -= 1
    d = yield x
    if (d == None):
        d = 0
    y = 5 + (d)
    print('3', 'y=', y)
    # yield y


f = g()
for idx in f:
    print('idx=', idx)
