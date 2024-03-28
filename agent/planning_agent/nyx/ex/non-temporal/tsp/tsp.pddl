(define (domain tsp)
  (:requirements :strips :negative-preconditions :typing)
  (:types position)
  (:predicates
    (at ?pos - position)
    (connected ?start - position ?finish - position)
    (visited ?finish - position)
  )

  (:action move
    :parameters (?start - position ?finish - position)
    :precondition (and
      (at ?start)
      (connected ?start ?finish)
      (not (visited ?finish))
    )
    :effect (and
      (at ?finish)
      (visited ?finish)
      (not (at ?start))
    )
  )
)