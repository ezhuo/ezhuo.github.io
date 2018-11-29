prices = {
    'ACME': 45.23,
    'AAPL': 612.78,
    'IBM': 205.55,
    'HPQ': 37.20,
    'FB': 10.75
}
# Make a dictionary of all prices over 200
p1 = {key: value for key, value in prices.items() if value > 200}
print(p1)
# Make a dictionary of tech stocks
tech_names = {'AAPL', 'IBM', 'HPQ', 'MSFT'}
p2 = {key: value for key, value in prices.items() if key in tech_names}
print(p2)


p11 = dict((key, value) for key, value in prices.items() if value > 200)
tech_names = {'AAPL', 'IBM', 'HPQ', 'MSFT'}
p12 = {key: prices[key] for key in prices.keys() & tech_names}

print(p11)
print(p12)
