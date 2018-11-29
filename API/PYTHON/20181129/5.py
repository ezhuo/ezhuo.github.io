class B:
    def __init__(self):
        self.__private = 0

    def __private_method(self):
        pass

    def public_method(self):
        pass
        self.__private_method()


class C(B):
    def __init__(self):
        super().__init__()
        B.__private = 2
        self.__private = 1  # Does not override B.__private

    # Does not override B.__private_method()
    def __private_method(self):
        pass


x = C()
x.public_method()
print(x.__dict__)
# help(x)
