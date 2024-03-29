(define (domain driving)
    (:requirements :typing :fluents :negative-preconditions )
    (:types city)
    (:predicates (at ?c - city) (route ?c1 - city ?c2 - city) (visited ?c - city))
    
(:action drive-direct
  :parameters (?start - city ?finish - city)
  :precondition (and (at ?start) (route ?start ?finish)) 
  :effect (and (at ?finish) (not (at ?start)) (visited ?finish))
)

)
