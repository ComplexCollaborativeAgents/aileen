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

(:action pickup_Bread|-00.92|+00.99|+02.27
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Bread|-00.92|+00.99|+02.27)
		(robot_location ?c)
		(location Bread|-00.92|+00.99|+02.27 ?c)
		(not (holding Bread|-00.92|+00.99|+02.27))
	)
	:effect (and
		(holding Bread|-00.92|+00.99|+02.27)
		(not (location Bread|-00.92|+00.99|+02.27 ?c))
	)
)

(:action put_Bread|-00.92|+00.99|+02.27
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Bread|-00.92|+00.99|+02.27 ?c))
		(holding Bread|-00.92|+00.99|+02.27)
	)
	:effect (and
		(not (holding Bread|-00.92|+00.99|+02.27))
		(location Bread|-00.92|+00.99|+02.27 ?c)
	)
)

(:action put_inside_Fridge|-01.00|+00.00|+00.12
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
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