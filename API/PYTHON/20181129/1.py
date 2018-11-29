def apply_async(func, args, *, callback):
    # Compute the result
    result = func(*args)

    # Invoke the callback with the result
    callback(result)


def print_result(result):
    print('Got:', result)


def add(x, y):
    return x + y


def make_handler():
    sequence = 0
    while True:
        result = yield
        sequence += 1
        print('[{}] Got: {}'.format(sequence, result))


g = make_handler()
g.__next__()

a = apply_async(add, (2, 3), callback=g.send)
print(a)

apply_async(add, ('hello', 'world'), callback=g.send)
