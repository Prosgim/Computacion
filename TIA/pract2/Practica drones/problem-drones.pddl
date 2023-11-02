(define (problem DRONES-1)
(:domain drones)
(:objects
    dronL1 - ligDron
    dronL2 - ligDron
    dronL3 - ligDron
    dronP1 - pesDron
    dronP2 - pesDron
    paqueteL1 - ligPaquete
    paqueteL2 - ligPaquete
    paqueteL3 - ligPaquete
    paqueteP1 - pesPaquete
    paqueteP2 - pesPaquete
    rA - puntoRecarga
    rB - puntoRecarga
    rC - puntoRecarga
    rF - puntoRecarga
    A - lugar
    B - lugar
    C - lugar
    D - lugar
    E - lugar
    F - lugar
)
(:init
    ;Lugar inicial de los drones
    (en dronL1 A)
    (en dronL2 A)
    (en dronL3 C)
    (en dronP1 E)
    (en dronP2 D)
    ;Lugar inicial de los paquetes
    (en paqueteL1 B)
    (en paqueteL2 A)
    (en paqueteL3 F)
    (en paqueteP1 D)
    (en paqueteP2 F)
    ;Puntos de recarga
    (en rA A)
    (en rB B)
    (en rC C)
    (en rF F)
    ;Disponibilidad inicial puntos de recarga
    (disponible rA)
    (disponible rB)
    (disponible rC)
    (disponible rF)
    ;Ningún dron lleva ningún paquete al inicio
    (sinPaquete dronL1)
    (sinPaquete dronL2)
    (sinPaquete dronL3)
    (sinPaquete dronP1)
    (sinPaquete dronP2)
    ;Zonas restringidas ZVR
    (esZVR A)
    (esZVR B)
    (esZVR C)   
    ;Coste de recogida y entrega
    (= (recogidaLig) 1)
    (= (recogidaPes) 2)
    (= (entrega) 2)
    ;Batería máxima
    (= (bateriaMaxima dronL1) 100)
    (= (bateriaMaxima dronL2) 100)
    (= (bateriaMaxima dronL3) 150)
    (= (bateriaMaxima dronP1) 200) 
    (= (bateriaMaxima dronP2) 220)
    ;Autonomía
    (= (autonomia dronL1) 5) 
    (= (autonomia dronL2) 10)
    (= (autonomia dronL3) 40)
    (= (autonomia dronP1) 40) 
    (= (autonomia dronP2) 120)
    ;Velocidad de recarga de la batería
    (= (duracionRecarga dronL1) 8)
    (= (duracionRecarga dronL2) 9)
    (= (duracionRecarga dronL3) 10)
    (= (duracionRecarga dronP1) 20)
    (= (duracionRecarga dronP2) 25)
    ;Coste de recarga de la batería
    (= (costeRecarga dronL1) 8)
    (= (costeRecarga dronL2) 10)
    (= (costeRecarga dronL3) 8)
    (= (costeRecarga dronP1) 9)
    (= (costeRecarga dronP2) 12)
    ;Velocidad del dron
    (= (velocidad dronL1) 2)
    (= (velocidad dronL2) 4)
    (= (velocidad dronL3) 4)
    (= (velocidad dronP1) 1) 
    (= (velocidad dronP2) 2)
    ;Distancias
    (= (distancia A A) 0)
    (= (distancia B B) 0)
    (= (distancia C C) 0)
    (= (distancia D D) 0)
    (= (distancia E E) 0)
    (= (distancia F F) 0)
    (= (distancia A B) 16)
    (= (distancia A C) 20)
    (= (distancia A D) 28)
    (= (distancia A E) 60)
    (= (distancia A F) 84)
    (= (distancia B A) 16)
    (= (distancia B C) 40)
    (= (distancia B D) 16)
    (= (distancia B E) 24)
    (= (distancia B F) 58)
    (= (distancia C A) 20)
    (= (distancia C B) 40)
    (= (distancia C D) 32)
    (= (distancia C E) 56)
    (= (distancia C F) 32)
    (= (distancia D A) 28)
    (= (distancia D B) 16)
    (= (distancia D C) 32)
    (= (distancia D E) 56)
    (= (distancia D F) 40)
    (= (distancia E A) 60)
    (= (distancia E B) 24)
    (= (distancia E C) 56)
    (= (distancia E D) 42)
    (= (distancia E F) 100)
    (= (distancia F A) 84)
    (= (distancia F B) 58)
    (= (distancia F C) 32)
    (= (distancia F D) 40)
    (= (distancia F E) 100)
    ; Coste total de recargas
    (= (coste-recargas) 0)
)

(:goal(and
    (en paqueteL1 C)
    (en paqueteL2 B)
    (en paqueteL3 D)
    (en paqueteP1 F)
    (en paqueteP2 E)

    (en dronL1 B)
    (en dronL2 B)
    (en dronL3 B)
    (en dronP1 E)
    (en dronP2 E)
))
   
(:metric minimize (+ (* 0.6 (total-time)) (* 0.4 (coste-recargas))))    
)