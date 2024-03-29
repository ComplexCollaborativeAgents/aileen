(define (domain ai_thor)

(:requirements
:negative-preconditions
:typing
)

(:types
cell interactable - object
)

(:predicates
(is_reachable ?c - cell)
(is_receptacle ?p - interactable)
(is_interactable ?p - interactable)
(is_toggleable ?p - interactable)
(is_breakable ?p - interactable)
(is_fillable ?p - interactable)
(is_cookable ?p - interactable)
(is_sliceable ?p - interactable)
(is_openable ?p - interactable)
(is_pickable ?p - interactable)
(is_moveable ?p - interactable)
(is_holdable ?p - interactable)
(location ?p - interactable ?c - cell)
(holding ?p - interactable)
(opened ?p - interactable)
(in ?p1 ?p2 - interactable)
(on ?p1 ?p2 - interactable)
(clear ?p - interactable)
(robot_location ?c - cell)
)

(:functions

)

(:action teleport
	:parameters (?from ?to - cell)
	:precondition (and
		(is_reachable ?to)
		(robot_location ?from)
	)
	:effect (and
		(robot_location ?to)
		(not (robot_location ?from))
	)
)

(:action pickup_Apple|+01.41|+00.98|+02.13
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Apple|+01.41|+00.98|+02.13)
		(robot_location ?c)
		(location Apple|+01.41|+00.98|+02.13 ?c)
		(not (holding Apple|+01.41|+00.98|+02.13))
	)
	:effect (and
		(holding Apple|+01.41|+00.98|+02.13)
		(not (location Apple|+01.41|+00.98|+02.13 ?c))
	)
)

(:action put_Apple|+01.41|+00.98|+02.13
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Apple|+01.41|+00.98|+02.13 ?c))
		(holding Apple|+01.41|+00.98|+02.13)
	)
	:effect (and
		(not (holding Apple|+01.41|+00.98|+02.13))
		(location Apple|+01.41|+00.98|+02.13 ?c)
	)
)

(:action put_inside_Fridge|-01.00|+00.00|+00.12
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(location Fridge|-01.00|+00.00|+00.12 ?c)
		(holding ?p)
		(opened Fridge|-01.00|+00.00|+00.12)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Fridge|-01.00|+00.00|+00.12 ?p)
	)
)

(:action open_Fridge|-01.00|+00.00|+00.12
	:parameters (?c - cell)
	:precondition (and
		(is_openable Fridge|-01.00|+00.00|+00.12)
		(robot_location ?c)
		(location Fridge|-01.00|+00.00|+00.12 ?c)
		(not (opened Fridge|-01.00|+00.00|+00.12))
	)
	:effect (and
		(opened Fridge|-01.00|+00.00|+00.12)
	)
)

(:action close_Fridge|-01.00|+00.00|+00.12
	:parameters (?c - cell)
	:precondition (and
		(is_openable Fridge|-01.00|+00.00|+00.12)
		(robot_location ?c)
		(location Fridge|-01.00|+00.00|+00.12 ?c)
		(opened Fridge|-01.00|+00.00|+00.12)
	)
	:effect (and
		(not (opened Fridge|-01.00|+00.00|+00.12))
	)
)




)