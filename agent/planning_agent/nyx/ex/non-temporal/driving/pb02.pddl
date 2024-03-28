(define (problem driving-pb2)
  (:domain driving)
  (:objects san_diego la palo_alto sacramento portland - city)
  (:init
    (at san_diego)

    (visited san_diego)

    (route san_diego la)
    (route la palo_alto)

    (route la san_diego)
    (route palo_alto la)

    (route la sacramento)
    (route sacramento la)

    (route sacramento portland)
    (route portland sacramento)

    (route palo_alto portland)
    (route portland palo_alto)

  )

  (:goal (and (at portland)))
)