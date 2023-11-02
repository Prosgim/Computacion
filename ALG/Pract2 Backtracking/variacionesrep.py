# AUTORES: PAU ROS GIMENO

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
        
def combinations(elementos, n):
    def backtracking(start, sol):
        if len(sol) == n:
            yield sol.copy()
        for i in range(start, len(elementos)):
            sol.append(elementos[i])
            yield from backtracking(i + 1, sol)
            sol.pop()

    yield from backtracking(0, [])
       
    
    
    
if __name__ == "__main__":
    for n in (1,2,3):
        print("Variaciones con repeticion de: ", n)
        for x in variacionesRepeticion(['tomate','queso','anchoas'], n):
            print(x)
    
    print("Permutaciones: ")
    for x in permutaciones(['tomate','queso','anchoas']):
        print(x)
    
    for n in (1,2,3):
        print("Combinaciones de: ", n)            
        for x in combinations(['tomate','queso','anchoas', 'aceitunas'], n):
            print(x)

