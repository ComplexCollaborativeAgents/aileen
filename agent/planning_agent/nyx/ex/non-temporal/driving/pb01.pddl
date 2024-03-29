(define (problem driving-pb1)
  (:domain driving)
  (:objects san_diego la palo_alto - city)
  (:init
    (at san_diego)

    (visited san_diego)

    (route san_diego la)
    (route la palo_alto)

    (route la san_diego)
    (route palo_alto la)
  )

  (:goal (and (at palo_alto)))
)