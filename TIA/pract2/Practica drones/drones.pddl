
(define (domain drones)

;REQUIREMENTS
(:requirements :durative-actions :typing :fluents :negative-preconditions)

;TIPES AND HIERARCHY
(:types dron paquete puntoRecarga lugar - object
 pesPaquete ligPaquete - paquete
 pesDron ligDron - dron
)

;PREDICATES
(:predicates 
    (en ?x - (either dron paquete puntoRecarga) ?l - lugar)
    (sinPaquete ?d - dron)
    (llevaPaquete ?d - dron ?p - paquete)
    (disponible ?disp - puntoRecarga)
    (esZVR ?zvr)
)

;FUNCTIONS
(:functions  
    (coste-recargas)
    (recogidaLig)
    (recogidaPes)
    (entrega)
    (bateriaMaxima ?d - dron)
    (autonomia ?d - dron)
    (duracionRecarga ?d - dron)
    (costeRecarga ?d - dron)
    (velocidad ?d - dron)
    (distancia ?ori - lugar ?dest - lugar) 
)

;ACTIONS
(:durative-action cargarPaqueteLigero
    :parameters (?p - ligPaquete ?d - dron ?l - lugar)
    :duration (= ?duration (recogidaLig))
    :condition (and 
        (at start (and (en ?d ?l) (en ?p ?l)))
        (at start (sinPaquete ?d))
        (over all (en ?d ?l))
    )
    :effect (and 
        (at end (not (sinPaquete ?d))) ;El dron lleva ahora un paquete
        (at end (llevaPaquete ?d ?p)) ;El dron d lleva el paquete p
        ; (at end (assign total-time (+ total-time recogidaLig))) ;La duración total se incrementa
    )
)

(:durative-action cargarPaquetePesado
    :parameters (?p - pesPaquete ?d - pesDron ?l - lugar)
    :duration (= ?duration (recogidaPes))
    :condition (and 
        (at start (and (en ?d ?l) (en ?p ?l)))
        (at start (sinPaquete ?d))
        (over all (en ?d ?l))
    )
    :effect (and 
        (at end (not (sinPaquete ?d))) ;El dron lleva ahora un paquete
        (at end (llevaPaquete ?d ?p)) ;El dron d lleva el paquete p
        ; (at end (assign total-time (+ total-time recogidaPes)))
    )
)

(:durative-action volarLigero
    :parameters (?d - ligDron ?ori - lugar ?dest - lugar)
    :duration (= ?duration (/ (distancia ?ori ?dest) (velocidad ?d)))
    :condition (and 
        (at start (en ?d ?ori))
        (at start (< (distancia ?ori ?dest) (autonomia ?d))) 
    )
    :effect (and 
        (at start (not (en ?d ?ori)))
        (at end (en ?d ?dest)) ;El dron ha llegado a su destino
        (at end (assign (autonomia ?d) (- (autonomia ?d) (distancia ?ori ?dest)))) ;Se pierde batería
        ; (at end (assign total-time (+ total-time (/ (distancia ?ori ?dest) (velocidad ?d)))))
    )
)

(:durative-action volarPesado
    :parameters (?d - pesDron ?ori - lugar ?dest - lugar)
    :duration (= ?duration (/ (distancia ?ori ?dest) (velocidad ?d)))
    :condition (and 
        (at start (en ?d ?ori))
        (at start (<= (distancia ?ori ?dest) (autonomia ?d)))
        ; (at start (not (esZVR ?ori)))
        (at start (not (esZVR ?dest)))       
    )
    :effect (and 
        (at start (not (en ?d ?ori)))
        (at end (en ?d ?dest)) ;El dron ha llegado a su destino
        (at end (assign (autonomia ?d) (- (autonomia ?d) (distancia ?ori ?dest)))) ;Se pierde batería
        ; (at end (assign total-time (+ total-time (/ (distancia ?ori ?dest) (velocidad ?d)))))
    )
)

(:durative-action entregarPaquete
    :parameters (?p - paquete ?d - dron ?l - lugar)
    :duration (= ?duration (entrega))
    :condition (and
        (at start (llevaPaquete ?d ?p))
        (over all (en ?d ?l))
    )
    :effect (and 
        (at end (sinPaquete ?d)) ;El dron ya no lleva ningún paquete
        (at end (not (llevaPaquete ?d ?p))) ;El dron ya no lleva el paquete p
        (at end (en ?p ?l)) ; El paquete p ha sido entregado
        ; (at end (assign total-time (+ total-time entrega)))
    )
)

(:durative-action recargarBateria
    :parameters (?d - dron ?pr - puntoRecarga ?l - lugar)
    :duration (= ?duration (duracionRecarga ?d))
    :condition (and 
        (at start (disponible ?pr))
        (at start (sinPaquete ?d))
        (at start (and (en ?d ?l) (en ?pr ?l)))
    )
    :effect (and
        (over all (not (disponible ?pr))) ;El punto de recarga no está disponible
        (at end (disponible ?pr)) ;El punto de recarga está disponible
        (at end (assign (autonomia ?d) (bateriaMaxima ?d))) ;La autonomía se recarga al máximo
        (at end (assign coste-recargas (+ coste-recargas (costeRecarga ?d)))) ;El coste total de recargas se incrementa
        ; (at end (assign total-time (+ total-time (duracionRecarga ?d))))
    )
)

)