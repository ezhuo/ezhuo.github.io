import os
filenames = os.listdir('.')
print(filenames)
ls = [name for name in filenames if name.startswith(('1.','exe'))]
print(ls)