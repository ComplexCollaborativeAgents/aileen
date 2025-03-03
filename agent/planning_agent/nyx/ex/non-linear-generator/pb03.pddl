(define (problem run-generator2)
(:domain generator)
(:objects generator - gen tank1 tank2 tank3 - tank )
(:init
(= ( gen_fuel_level generator) 965)
(= ( capacity generator) 1000)
(= ( tank_fuel_level tank1 ) 16)
(= ( sqrtvolinit tank1 ) 4)
(= ( flow_constant tank1 ) 0.1)
(= ( tank_fuel_level tank2 ) 16)
(= ( sqrtvolinit tank2 ) 4)
(= ( flow_constant tank2 ) 0.1)
(= ( tank_fuel_level tank3 ) 16)
(= ( sqrtvolinit tank3 ) 4)
(= ( flow_constant tank3 ) 0.1)
(= (runtime) 1000))
(:goal (generator_ran generator))
(:metric minimize ( total-time ))
)
