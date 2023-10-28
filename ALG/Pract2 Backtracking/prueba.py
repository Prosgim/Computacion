def combinations(elements, n):
    def backtrack(start, sol):
        if len(sol) == n:
            result.append(list(sol))
            return
        for i in range(start, len(elements)):
            sol.append(elements[i])
            backtrack(i + 1, sol)
            sol.pop()
    
    result = []
    backtrack(0, [])
    return result

elements = ['tomate', 'queso', 'anchoas', 'aceitunas']
n = 3

combinations_list = combinations(elements, n)
for combination in combinations_list:
    print(combination)
