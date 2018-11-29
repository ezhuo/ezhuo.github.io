class Base:
    def __init__(self):
        print('Base.__init__')


class A(Base):
    def __init__(self):
        super().__init__()
        print('A.__init__')


class B(Base):
    def __init__(self, val):
        super().__init__()
        self.b = val
        print('B.__init__')


class C(A, B):
    def __init__(self):
        A.__init__(self)
        B.__init__(self, val=2)
        # super().__init__()  # Only one call to super() here
        print('C.__init__')


c = C()
