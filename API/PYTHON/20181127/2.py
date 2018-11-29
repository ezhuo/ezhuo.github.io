class myClass:

    i = 111

    def __init__(self):
        print(self, self.i)

    def fn(self, value):
        self.i = value

    def __str__(self):
        return str(self.i)


class myClass2(myClass):

    def fn2(self, value):
        self.i = 4444


def test():
    a = myClass2()
    fn = a.fn2
    fn(333)
    print(a)
    global a
    idx = 2
    print(idx)


test()
print(a)
