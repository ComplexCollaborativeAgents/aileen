(define (domain generator)
(:requirements :fluents :time :adl :typing)
(:types generator tank)
(:predicates (refueling ?g - generator) (generator-ran) (available ?t - tank) (running ?g - generator) (failure))

(:functions (fuelLevel ?g - generator) (capacity ?g - generator) (generate_timing ?g - generator) (refuel_timing ?g - generator ?t - tank))

(:action start_generator
  :parameters (?g - generator)
  :precondition ()
  :effect (and (assign (generate_timing ?g) 0) (running ?g))
)

(:action end_generator
  :parameters (?g - generator)
  :precondition (and (running ?g) (= (generate_timing ?g) 1000))
  :effect (and (generator-ran))
)

(:process generating
  :parameters (?g - generator)
  :precondition (and (running ?g))
  :effect (and (decrease (fuelLevel ?g) (* #t 1)) (increase (generate_timing ?g) (* #t 1)))
)

(:action start_refueling
  :parameters (?g - generator ?t - tank)
  :precondition (and (available ?t))
  :effect (and (not (available ?t)) (refueling ?g) (assign (refuel_timing ?g ?t) 0))
)

(:action end_refueling
  :parameters (?g - generator ?t - tank)
  :precondition (and (refueling ?g) (= (refuel_timing ?g ?t) 10))
  :effect (and (not (refueling ?g)) (assign (refuel_timing ?g ?t) 0))
)

(:process refueling
  :parameters (?g - generator ?t - tank)
  :precondition (and (refueling ?g))
  :effect (and (increase (fuelLevel ?g) (* #t 2)) (increase (refuel_timing ?g ?t) (* #t 1)))
)

(:event overflow
  :parameters(?g - generator)
  :precondition (and (>= (fuelLevel ?g) (capacity ?g)))
  :effect (and (failure))
)

(:event empty
  :parameters(?g - generator)
  :precondition (and (< (fuelLevel ?g) 0))
  :effect (and (failure))
)

(:event refuel_timing_error
  :parameters(?g - generator ?t - tank)
  :precondition (and (> (refuel_timing ?g ?t) 10))
  :effect (and (failure))
)

(:event generate_timing_error
  :parameters(?g - generator)
  :precondition (and (> (generate_timing ?g) 1000))
  :effect (and (failure))
)

)