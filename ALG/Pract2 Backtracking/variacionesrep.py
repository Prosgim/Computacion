# AUTORES: PAU ROS GIMENO
# (poner aquí el nombre o 2 nombres del equipo de prácticas

def variacionesRepeticion(elementos, cantidad):
    
    def backtracking(sol):
        if len(sol) == cantidad:
            yield sol.copy()
        else:
            for opcion in elementos:
                sol.append(opcion)
                yield from backtracking(sol)
                sol.pop()
                
    yield from backtracking([])

# COMPLETAR las actividades 1 y 2 para permutaciones y combinaciones
def permutaciones(elementos):
    def backtracking(sol):
        if len(sol) == len(elementos):
            yield sol.copy()
        else:
            for opcion in elementos:
                if opcion not in sol:
                    sol.append(opcion)
                    yield from backtracking(sol)
                    sol.pop()
    
    for p in backtracking([]):
        yield p
        
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
    
    
    
if __name__ == "__main__":
    for n in (1,2,3):
        print('Variaciones con repeticion n =',n)
        for x in variacionesRepeticion(['tomate','queso','anchoas'], n):
            print(x)
    
    print("Permutaciones: ")
    for x in permutaciones(['tomate','queso','anchoas']):
        print(x)
    
    for n in (1,2,3):
        print("Combinaciones de: ", n)            
        for x in combinations(['tomate','queso','anchoas'], n):
            print(x)
    # probar las actividades 1 y 2 para permutaciones y combinaciones
