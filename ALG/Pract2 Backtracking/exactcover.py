import subsetsum
# AUTORES: PAU ROS GIMENO

def exact_cover(listaConjuntos, U=None):

    # permitimos que nos pasen U, si no lo hacen lo calculamos:
    if U is None:
        U = set().union(*listaConjuntos) 
    
    def backtracking(sol, cjtAcumulado):
        if cjtAcumulado == U:
            yield sol
        if len(sol) >= len(listaConjuntos):
            return
        cjt = listaConjuntos[len(sol)]
        if set.isdisjoint(cjtAcumulado, cjt):
            sol.append(1)
            yield from backtracking(sol, cjtAcumulado.union(cjt))
            sol.pop()
        sol.append(0)
        yield from backtracking(sol, cjtAcumulado)
        sol.pop            
    yield from backtracking([], set())

                
if __name__ == "__main__":
    listaConjuntos = [{"casa","coche","gato"},
                      {"casa","bici"},
                      {"bici","perro"},
                      {"boli","gato"},
                      {"coche","gato","bici"},
                      {"casa", "moto"},
                      {"perro", "boli"},
                      {"coche","moto"},
                      {"casa"}]
    for solucion in exact_cover(listaConjuntos):
        print(solucion)
        




U = {1, 2, 3, 4, 5}
datos = [{1, 2, 3}, {2, 3, 4}, {4, 5}, {1, 5}, {2, 3}]
soluciones = exact_cover(U, datos)

for solucion in soluciones:
    print(solucion)

