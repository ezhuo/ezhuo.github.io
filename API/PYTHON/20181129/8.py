class Attr(object):
    def __init__(self, attrname, attrtype):
        self.attrname = attrname
        self.attrtype = attrtype

    def __get__(self, instance, value):
        return instance.__dict__[self.attrname]

    def __set__(self, instance, value):
        if not isinstance(value, self.attrtype):
            raise TypeError("%s type error" % self.attrname)
        instance.__dict__[self.attrname] = value

    def __delete__(self, instance):
        del instance.__dict__[self.attrname]


class Person(object):
    name = Attr("name", str)
    age = Attr("age", int)


p = Person()
p.age = 5
