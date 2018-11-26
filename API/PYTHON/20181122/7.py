try:
    f = open('1.py', 'r')
    str = f.read()
    print(str)
    f.close()
except Exception as err:
    print('b', err)
finally:
    print('dd'/0)
