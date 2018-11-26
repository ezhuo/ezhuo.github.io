def g():
    print('函数体内：', 'init')
    a = yield 'return 1。。。'
    a = 'param 2 + ' + a
    print('函数体内：', '第二次迭代执行。。。', a)
    b = yield '第二个返回值：' + a
    b = 'param 3 + ' + b
    print('函数体内：', '第三次迭代执行。。。', b)
    yield '第三个返回值' + b


f = g()
print('1. 第一次迭代调用next：', f.__next__())
print('2. 第二次迭代调用send(2)：',  f.send('send2'))
print('3. 第三次迭代调用send(3)：', f.send('send3'))
