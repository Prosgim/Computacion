;EXAMEN PRACT 1 TIA
;AUTOR: PAU ROS GIMENO


;TEMPLATES
    (deftemplate peso 0 10 kg
        ((bajo (0 1) (3 1) (5 0))
        (medio (3 0) (4 1) (7 1) (10 0))
        (alto (8 0) (9 1) (10 1))))

    (deftemplate humedad 0 50 %humedad
        ((seco (0 1) (5 1) (10 0))
        (humedo (5 0) (15 1) (30 1) (40 0))
        (mojado (35 0) (40 1) (50 1))))

    (deftemplate temperatura 20 110 grados
        ((baja (20 1) (30 1) (50 0))
        (media (30 0) (50 1) (60 1) (80 0))
        (alta (60 0) (80 1) (90 1))
        (vapor (s 80 105))
        (supervapor (pi 10 100))))
   
    (deftemplate duracion 20 120 mins
        ((corta (20 1) (30 1) (40 0))
        (media (30 0) (50 1) (70 1) (80 0))
        (larga (70 0) (80 1) (90 1) (110 0))
        (extralarga (80 0) (100 1) (120 1))))

    (deftemplate velocidad 0 1000 RPM
        ((baja (0 1) (300 1) (500 0))
        (media (400 0) (500 1) (700 1) (800 0))
        (alta (700 0) (800 1) (1000 1))))

    (deftemplate Secado
        (slot peso(type FLOAT))
        (slot humedad(type FLOAT))
        (slot velocidad(type FLOAT)) ;velocidad en RPM
        (slot modo(type SYMBOL)) ;modos: EST y HIEST
        (slot ECO(type SYMBOL))) ;modo ECO (ON/OFF)


;FUZZIFY
    (deffunction fuzzify (?fztemplate ?value ?delta)

        (bind ?low (get-u-from ?fztemplate))
        (bind ?hi  (get-u-to   ?fztemplate))

        (if (<= ?value ?low)
          then
            (assert-string
              (format nil "(%s (%g 1.0) (%g 0.0))" ?fztemplate ?low ?delta))
          else
            (if (>= ?value ?hi)
              then
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0))"
                               ?fztemplate (- ?hi ?delta) ?hi))
              else
                (assert-string
                   (format nil "(%s (%g 0.0) (%g 1.0) (%g 0.0))"
                               ?fztemplate (max ?low (- ?value ?delta))
                               ?value (min ?hi (+ ?value ?delta)) ))
            )
        )
  )
;RULES
    (defrule leerconsola
        (initial-fact)
        =>
        (printout t "Introduzca el peso en kg" crlf)
        (bind ?peso(read))
        (fuzzify peso ?peso 0)
        (printout t "Introduzca la humedad en % de humedad" crlf)
        (bind ?humedad (read))
        (fuzzify humedad ?humedad 0)
        (printout t "Introduzca el modo (EST/HIEST)" crlf)
        (bind ?modo (read))
        (assert (Secado ( modo ?modo )))
        (printout t "Introduzca si desea activar el modo ECO (ON/OFF)" crlf)
        (bind ?ECO (read))
        (assert (Secado ( ECO ?ECO )))
        )

    (defrule todoBajo
        (peso bajo)
        (humedad seco)
        =>
        (assert(temperatura extremely baja))
        (assert(duracion extremely corta)))

    (defrule pesoBajo
        (peso bajo)
        (humedad humedo)
        =>
        (assert(temperatura media))
        (assert(duracion somewhat corta)))

    (defrule humedadBajo
        (peso medio)
        (humedad seco)
        =>
        (assert(temperatura very baja))
        (assert(duracion very corta)))

    (defrule todoMedio
        (peso medio)
        (humedad humedo)
        =>
        (assert(temperatura more-or-less media))
        (assert(duracion somewhat media)))

    (defrule pesoAltoHumedadBaja
        (peso alto)
        (humedad seco)
        =>
        (assert(temperatura more-or-less baja))
        (assert(duracion more-or-less corta))) 

    (defrule humedadAltaPesoBajo
        (peso bajo)
        (humedad mojado)
        =>
        (assert(temperatura alta))
        (assert(duracion media))) 

    (defrule pesoAltoHumedadMedia
        (peso alto)
        (humedad humedo)
        =>
        (assert(temperatura alta))
        (assert(duracion larga))) 
   
   (defrule humedadAltaPesoMedio
        (peso medio)
        (humedad mojado)
        =>
        (assert(temperatura more-or-less alta))
        (assert(duracion corta))) 

    (defrule todoAlto
        (peso alto)
        (humedad mojado)
        =>
        (assert(temperatura extremely alta))
        (assert(duracion extralarga)))

;RULES MODO
    (defrule EST
        (modo EST)
        =>
        (assert (fuzzify temperatura 100 0))
    )

    (defrule HIEST
        (modo HIEST)
        =>
        (assert (fuzzify temperatura 110 0))
    )

;RULES VELOCIDAD
    (defrule velocidadAlta
        (peso bajo)
        (temperatura more-or-less vapor)
        =>
        (assert(velocidad alta))
    )

    (defrule velocidadMedia
        (peso medio)
        (temperatura vapor)
        =>
        (assert(velocidad media))
    )

    (defrule velocidadVeryBaja
        (peso bajo)
        (temperatura supervapor)
        =>
        (assert(velocidad very baja))
    )

;RULES ECO
    (defrule ECO
        (ECO ON)
        =>
        (assert (duracion larga))
        (assert (temperatura media))
        (assert (velocidad somewhat baja))
    )

    (defrule OUTPUTS
        (declare (salience -1))
            (temperatura ?temperatura)
            (duracion ?duracion)
            (velocidad ?velocidad)
            =>
            (bind ?temperatura temperatura)
            (bind ?duracion duracion)
            (bind ?velocidad velocidad))
    
    (defrule fuzzy1
        (declare (salience -2))
            (temperatura ?temperatura)
            (duracion ?duracion)
            (velocidad ?velocidad)
            => 
            (bind ?t (moment-defuzzify ?temperatura))
            (printout t "La temperatura moment es " ?t crlf)
            (bind ?t (maximum-defuzzify ?temperatura))
            (printout t "La temperatura maximum es " ?t crlf)
            (bind ?d (moment-defuzzify ?duracion))
            (printout t "La duración moment es " ?d crlf)
            (bind ?d (maximum-defuzzify ?duracion))
            (printout t "La duración maximum es " ?d crlf)
            (bind ?v (moment-defuzzify ?velocidad))
            (printout t "La velocidad moment es " ?v crlf)
            (bind ?v (maximum-defuzzify ?velocidad))
            (printout t "La velocidad maximum es " ?v crlf)
            (halt))
