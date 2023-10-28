
;FALTA:
;MÉTODO DE RECARGAR BATERÍAS
;TENER EN CUENTA EN LOS MÉTODOS EN LOS QUE SE GASTA BATERÍA QUE NO SE DEBEN
;REALIZAR SI NO LES DA LA BATERÍA
;MÁS MÉTODOS SEGURAMENTE PERO ES LA 1 AM Y YO QUE SÉ QUIERO DORMIR
;HOLA PAU DEL FUTURO DALE BRODER TÍO TÚ PUEDES CON TODO BRODER
;DEBUGGING Y TESTING (LO DE SIEMPRE VAMOS)


(define (domain drones)

;REQUIREMENTS
(:requirements :durative-actions :typing :fluents :negative-preconditions)

;TIPES AND HIERARCHY
(:types puntoRecarga zvr - lugar 
 pesPaquete ligPaquete - paquete
 pesDron ligDron - dron
 autonomia bateriaMaxima velocidadRecarga costeRecarga - bateria
 - object
)

;PREDICATES
(:predicates 
    (en ?x - (either dron paquete) ?l - lugar)
    (destinoDe ?p - paquete)
    (sinPaquete ?d - dron)
    (llevaPaquete ?d - dron ?p - paquete)
    (disponible ?l - lugar)
)

;FUNCTIONS
(:functions 
    (coste-recargas)
    (total-time)    
    (cargandoPaqueteLigero)
    (cargandoPaquetePesado)
    (entregandoPaquete)
    (recogidaLig)
    (recogidaPes)
    (entrega ?d - dron ?p - paquete)
    (bateriaMaxima ?d - dron)
    (autonomia ?d - dron)
    (velocidadRecarga ?d - dron)
    (costeRecarga ?d - dron)
    (velocidad ?d - dron)
    (distancia ?ori - lugar ?dest - lugar)
    
)

;ACTIONS
(:durative-action cargarPaqueteLigero
    :parameters (?p - ligPaquete ?d - dron ?l - lugar)
    :duration (= ?duration (cargandoPaqueteLigero))
    :condition (and 
        (at start (= (en ?d) (en ?p)))
        (at start (sinPaquete ?d))
        (at start (disponible ?l))
        (over all (en ?d ?l))
    )
    :effect (and 
        (over all (not (disponible ?l))) ;Estación ocupada durante la carga
        (at end ((disponible ?l))) ;Estación liberada al terminar
        (at end (not (sinPaquete ?d))) ;El dron lleva ahora un paquete
        (at end (llevaPaquete ?d ?p)) ;El dron d lleva el paquete p
        (at end (= total-time (+ total-time ?duration))) ;La duración total se incrementa
    )
)

(:durative-action cargarPaquetePesado
    :parameters (?p - pesPaquete ?d - pesDron ?l - lugar)
    :duration (= ?duration (cargandoPaquetePesado))
    :condition (and 
        (at start (= (en ?d) (en ?p)))
        (at start (sinPaquete ?d))
        (at start (disponible ?l))
        (over all (en ?d ?l))
    )
    :effect (and 
        (over all (not (disponible ?l))) ;Estación ocupada durante la carga
        (at end ((disponible ?l))) ;Estación liberada al terminar
        (at end (not (sinPaquete ?d))) ;El dron lleva ahora un paquete
        (at end (llevaPaquete ?d ?p)) ;El dron d lleva el paquete p
        (at end (= total-time (+ total-time ?duration))) 
    )
)

(:durative-action volar
    :parameters (?d - dron ?b - autonomia ?ori - lugar ?dest - lugar)
    :duration (= ?duration (/ (distancia ?ori ?dest) (velocidad ?d)))
    :condition (and 
        (at start (<= (distancia ?ori ?dest) ?b))

    )
    :effect (and 
        (at end (en ?d ?dest)) ;El dron ha llegado a su destino
        (at end (- ?b (distancia ?ori ?dest))) ;Se pierde batería
        (at end (= total-time (+ total-time ?duration)))
    )
)

(:durative-action entregarPaquete
    :parameters (?paquete - p ?d - dron ?l - lugar)
    :duration (= ?duration entregandoPaquete)
    :condition (and
        (at start not(sinPaquete ?d))
        (over all (=(destinoDe ?p) ?l))
    )
    :effect (and 
        (at end (sinPaquete ?d)) ;El dron ya no lleva ningún paquete
        (at end (not (llevaPaquete ?d ?p))) ;El dron ya no lleva el paquete p
        (at end (= total-time (+ total-time ?duration)))
    )
)

(:durative-action recargarBateria
    :parameters ()
    :duration (= ?duration 1)
    :condition (and 
        (at start (and 
        ))
        (over all (and 
        ))
        (at end (and 
        ))
    )
    :effect (and 
        (at start (and 
        ))
        (at end (and 
        ))
    )
)


)