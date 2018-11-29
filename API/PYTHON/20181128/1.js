function* objectEntries() {
    let propKeys = Object.keys(this);

    for (let propKey of propKeys) {
        yield [propKey, this[propKey]];
    }
}

let jane = {
    first: 'Jane',
    last: 'Doe'
};

jane[Symbol.iterator] = objectEntries;

for (let [key, value] of jane) {
    console.log(`${key}: ${value}`);
}

var g = function* () {
    try {
        yield 1;
        yield 2;
        yield 3;
        yield 4;
    } catch (e) {
        console.log('g:', e);
    }
};

var i = g();
console.log(i.next());
// i.throw(new Error('出错了！'));
console.log(i.next());

function* foo() {
    var x = yield 3;
    var y = x.toUpperCase();
    yield y;
}

var it = foo();
it.next(); // { value:3, done:false }
try {
    it.next(42);
} catch (err) {
    console.log(err);
}