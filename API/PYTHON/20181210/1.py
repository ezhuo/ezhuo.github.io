class Person:
    def __init__(self, first_name):
        # self.set_first_name(first_name)
        self.first_name = first_name

    # Getter function
    def get_first_name(self):
        return self._first_name

    # Setter function
    def set_first_name(self, value):
        if not isinstance(value, str):
            raise TypeError('Expected a string')
        self._first_name = value

    # Deleter function (optional)
    def del_first_name(self):
        raise AttributeError("Can't delete attribute")


p = Person('ezhuo')
p.first_name = 'aa'
print(p.first_name)
