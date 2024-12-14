from itertools import combinations

map = {}

def x(p):
    return p[0]

def y(p):
    return p[1]

arr = []

with open('input', 'r') as file:
    for line, l in enumerate(file):
        arr.append(list(l[0:len(l) - 1]))
        for ch_i, ch in enumerate(l):
            if ch != '\n' and ch != '.':
                if ch in map:
                    map[ch].append((line, ch_i))
                else:
                    map[ch] = [(line, ch_i)]

ans = 0

# part 1
# for coord in map.values():
#     pairs = combinations(coord, 2)
#     for pair in pairs:
#         print(pair)
#         dx = x(pair[0]) - x(pair[1])
#         dy = y(pair[0]) - y(pair[1])
#
#         i1 = x(pair[0]) + dx
#         j1 = y(pair[0]) + dy
#
#         i2 = x(pair[1]) - dx
#         j2 = y(pair[1]) - dy
#
#         if i1 >= 0 and j1 >= 0 and i1 < len(arr) and j1 < len(arr[0]) and arr[i1][j1] != '#':
#             ans += 1
#             arr[i1][j1] = '#'
#
#         if i2 >= 0 and j2 >= 0 and i2 < len(arr) and j2 < len(arr[0]) and arr[i2][j2] != '#':
#             ans += 1
#             arr[i2][j2] = '#'

# print(f"part1 = {ans}")

# part2
for coord in map.values():
    pairs = combinations(coord, 2)
    for pair in pairs:
        print(pair)
        dx = x(pair[0]) - x(pair[1])
        dy = y(pair[0]) - y(pair[1])

        i1 = x(pair[0]) + dx
        j1 = y(pair[0]) + dy

        i2 = x(pair[1]) - dx
        j2 = y(pair[1]) - dy

        while i1 >= 0 and j1 >= 0 and i1 < len(arr) and j1 < len(arr[0]):
            if arr[i1][j1] == '.':
                ans += 1
                arr[i1][j1] = '#'

            i1 += dx
            j1 += dy

        while i2 >= 0 and j2 >= 0 and i2 < len(arr) and j2 < len(arr[0]):
            if arr[i2][j2] == '.':
                ans += 1
                arr[i2][j2] = '#'

            i2 -= dx
            j2 -= dy

    ans += len(coord)

print(f"part2 = {ans}")

for i in arr:
    print(i)

