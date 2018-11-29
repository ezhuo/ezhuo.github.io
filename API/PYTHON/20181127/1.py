
class myError(Exception):
    def __init__(self, value):
        print('__init__',value)
        self.value = value

    def __str__(self):
        print('myerror:__str__')
        return repr(self.value)


try:
    a = 1/0
except Exception as err:
    print('err', err)
else:
    print('ok')
finally:
    print('finally')
    try:
        raise myError('fdsa')
    except myError as err1:
        print(err1)
