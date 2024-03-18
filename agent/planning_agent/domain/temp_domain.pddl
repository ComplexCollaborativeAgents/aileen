(define (domain ai_thor)
(:requirements
:negative-preconditions
:typing)
(:types

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
(is_near ?c - cell)
(location ?c - cell?p - interactable)
(holding ?p - interactable)
(opened ?p - interactable)
(in ?p1 ?p2 - interactable)
(on ?p1 ?p2 - interactable)
(closed ?p - interactable)
)
(:functions
(robot_x )
(robot_y )
(robot_z )
(prev_robot_x )
(prev_robot_y )
(prev_robot_z )
(cell_x ?c - cell)
(cell_y ?c - cell)
(cell_z ?c - cell)
(location_x ?p - interactable)
(location_y ?p - interactable)
(location_z ?p - interactable)
)
(:action teleport
	:parameters (( ?from ?to - cell))
	:precondition (and
		((is_reachable ?to)
		(=  (cell_x ?from))
		(=  (cell_y ?from)))
	)
	:effect (and
		((assign  (cell_x ?from))
		(assign  (cell_y ?from))
		(assign  (cell_x ?to))
		(assign  (cell_y ?to)))
	)
)

(:action pickup_Lettuce|+01.46|+01.01|+01.68
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Lettuce|+01.46|+01.01|+01.68)
		
		
		(not ((holding Lettuce|+01.46|+01.01|+01.68))))
	)
	:effect (and
		(
		(not ((holding Lettuce|+01.46|+01.01|+01.68)))
		
		)
	)
)

(:action pickup_SoapBottle|+01.67|+00.93|+01.11
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?SoapBottle|+01.67|+00.93|+01.11)
		
		
		(not ((holding SoapBottle|+01.67|+00.93|+01.11))))
	)
	:effect (and
		(
		(not ((holding SoapBottle|+01.67|+00.93|+01.11)))
		
		)
	)
)

(:action pickup_Bread|-00.92|+00.99|+02.27
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Bread|-00.92|+00.99|+02.27)
		
		
		(not ((holding Bread|-00.92|+00.99|+02.27))))
	)
	:effect (and
		(
		(not ((holding Bread|-00.92|+00.99|+02.27)))
		
		)
	)
)

(:action pickup_Fork|+01.35|+00.74|+02.50
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Fork|+01.35|+00.74|+02.50)
		
		
		(not ((holding Fork|+01.35|+00.74|+02.50))))
	)
	:effect (and
		(
		(not ((holding Fork|+01.35|+00.74|+02.50)))
		
		)
	)
)

(:action pickup_Tomato|+01.44|+00.99|+00.84
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Tomato|+01.44|+00.99|+00.84)
		
		
		(not ((holding Tomato|+01.44|+00.99|+00.84))))
	)
	:effect (and
		(
		(not ((holding Tomato|+01.44|+00.99|+00.84)))
		
		)
	)
)

(:action pickup_Bowl|-01.06|+01.49|+00.88
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Bowl|-01.06|+01.49|+00.88)
		
		
		(not ((holding Bowl|-01.06|+01.49|+00.88))))
	)
	:effect (and
		(
		(not ((holding Bowl|-01.06|+01.49|+00.88)))
		
		)
	)
)

(:action pickup_Pot|-00.82|+00.93|+00.82
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Pot|-00.82|+00.93|+00.82)
		
		
		(not ((holding Pot|-00.82|+00.93|+00.82))))
	)
	:effect (and
		(
		(not ((holding Pot|-00.82|+00.93|+00.82)))
		
		)
	)
)

(:action pickup_Spatula|+01.34|+00.93|+02.40
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Spatula|+01.34|+00.93|+02.40)
		
		
		(not ((holding Spatula|+01.34|+00.93|+02.40))))
	)
	:effect (and
		(
		(not ((holding Spatula|+01.34|+00.93|+02.40)))
		
		)
	)
)

(:action pickup_Knife|+01.36|+00.74|+00.87
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Knife|+01.36|+00.74|+00.87)
		
		
		(not ((holding Knife|+01.36|+00.74|+00.87))))
	)
	:effect (and
		(
		(not ((holding Knife|+01.36|+00.74|+00.87)))
		
		)
	)
)

(:action pickup_SaltShaker|+01.67|+00.93|+02.05
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?SaltShaker|+01.67|+00.93|+02.05)
		
		
		(not ((holding SaltShaker|+01.67|+00.93|+02.05))))
	)
	:effect (and
		(
		(not ((holding SaltShaker|+01.67|+00.93|+02.05)))
		
		)
	)
)

(:action pickup_Apple|+01.41|+00.98|+02.13
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Apple|+01.41|+00.98|+02.13)
		
		
		(not ((holding Apple|+01.41|+00.98|+02.13))))
	)
	:effect (and
		(
		(not ((holding Apple|+01.41|+00.98|+02.13)))
		
		)
	)
)

(:action pickup_PepperShaker|+01.60|+00.93|+02.16
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?PepperShaker|+01.60|+00.93|+02.16)
		
		
		(not ((holding PepperShaker|+01.60|+00.93|+02.16))))
	)
	:effect (and
		(
		(not ((holding PepperShaker|+01.60|+00.93|+02.16)))
		
		)
	)
)

(:action pickup_ButterKnife|+01.37|+00.74|+02.24
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?ButterKnife|+01.37|+00.74|+02.24)
		
		
		(not ((holding ButterKnife|+01.37|+00.74|+02.24))))
	)
	:effect (and
		(
		(not ((holding ButterKnife|+01.37|+00.74|+02.24)))
		
		)
	)
)

(:action pickup_Potato|-00.76|+00.96|+02.36
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Potato|-00.76|+00.96|+02.36)
		
		
		(not ((holding Potato|-00.76|+00.96|+02.36))))
	)
	:effect (and
		(
		(not ((holding Potato|-00.76|+00.96|+02.36)))
		
		)
	)
)

(:action pickup_Plate|+01.38|+01.06|+00.01
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Plate|+01.38|+01.06|+00.01)
		
		
		(not ((holding Plate|+01.38|+01.06|+00.01))))
	)
	:effect (and
		(
		(not ((holding Plate|+01.38|+01.06|+00.01)))
		
		)
	)
)

(:action pickup_DishSponge|+01.51|+00.84|+01.37
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?DishSponge|+01.51|+00.84|+01.37)
		
		
		(not ((holding DishSponge|+01.51|+00.84|+01.37))))
	)
	:effect (and
		(
		(not ((holding DishSponge|+01.51|+00.84|+01.37)))
		
		)
	)
)

(:action pickup_Egg|+01.32|+00.96|+01.75
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Egg|+01.32|+00.96|+01.75)
		
		
		(not ((holding Egg|+01.32|+00.96|+01.75))))
	)
	:effect (and
		(
		(not ((holding Egg|+01.32|+00.96|+01.75)))
		
		)
	)
)

(:action pickup_Cup|+01.31|+00.93|+00.78
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Cup|+01.31|+00.93|+00.78)
		
		
		(not ((holding Cup|+01.31|+00.93|+00.78))))
	)
	:effect (and
		(
		(not ((holding Cup|+01.31|+00.93|+00.78)))
		
		)
	)
)

(:action pickup_Pan|+01.38|+01.74|+00.39
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Pan|+01.38|+01.74|+00.39)
		
		
		(not ((holding Pan|+01.38|+01.74|+00.39))))
	)
	:effect (and
		(
		(not ((holding Pan|+01.38|+01.74|+00.39)))
		
		)
	)
)

(:action pickup_Spoon|+01.41|+00.74|+02.43
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Spoon|+01.41|+00.74|+02.43)
		
		
		(not ((holding Spoon|+01.41|+00.74|+02.43))))
	)
	:effect (and
		(
		(not ((holding Spoon|+01.41|+00.74|+02.43)))
		
		)
	)
)

(:action pickup_Mug|+01.46|+00.93|+01.09
	:parameters (( ?c - cell))
	:precondition (and
		((is_pickable ?Mug|+01.46|+00.93|+01.09)
		
		
		(not ((holding Mug|+01.46|+00.93|+01.09))))
	)
	:effect (and
		(
		(not ((holding Mug|+01.46|+00.93|+01.09)))
		
		)
	)
)

(:action put_Lettuce|+01.46|+01.01|+01.68
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Lettuce|+01.46|+01.01|+01.68))))
	)
	:effect (and
		(
		(not ((holding Lettuce|+01.46|+01.01|+01.68)))
		
		)
	)
)

(:action put_SoapBottle|+01.67|+00.93|+01.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding SoapBottle|+01.67|+00.93|+01.11))))
	)
	:effect (and
		(
		(not ((holding SoapBottle|+01.67|+00.93|+01.11)))
		
		)
	)
)

(:action put_Bread|-00.92|+00.99|+02.27
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Bread|-00.92|+00.99|+02.27))))
	)
	:effect (and
		(
		(not ((holding Bread|-00.92|+00.99|+02.27)))
		
		)
	)
)

(:action put_Fork|+01.35|+00.74|+02.50
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Fork|+01.35|+00.74|+02.50))))
	)
	:effect (and
		(
		(not ((holding Fork|+01.35|+00.74|+02.50)))
		
		)
	)
)

(:action put_Tomato|+01.44|+00.99|+00.84
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Tomato|+01.44|+00.99|+00.84))))
	)
	:effect (and
		(
		(not ((holding Tomato|+01.44|+00.99|+00.84)))
		
		)
	)
)

(:action put_Bowl|-01.06|+01.49|+00.88
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Bowl|-01.06|+01.49|+00.88))))
	)
	:effect (and
		(
		(not ((holding Bowl|-01.06|+01.49|+00.88)))
		
		)
	)
)

(:action put_Pot|-00.82|+00.93|+00.82
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Pot|-00.82|+00.93|+00.82))))
	)
	:effect (and
		(
		(not ((holding Pot|-00.82|+00.93|+00.82)))
		
		)
	)
)

(:action put_Spatula|+01.34|+00.93|+02.40
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Spatula|+01.34|+00.93|+02.40))))
	)
	:effect (and
		(
		(not ((holding Spatula|+01.34|+00.93|+02.40)))
		
		)
	)
)

(:action put_Knife|+01.36|+00.74|+00.87
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Knife|+01.36|+00.74|+00.87))))
	)
	:effect (and
		(
		(not ((holding Knife|+01.36|+00.74|+00.87)))
		
		)
	)
)

(:action put_SaltShaker|+01.67|+00.93|+02.05
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding SaltShaker|+01.67|+00.93|+02.05))))
	)
	:effect (and
		(
		(not ((holding SaltShaker|+01.67|+00.93|+02.05)))
		
		)
	)
)

(:action put_Apple|+01.41|+00.98|+02.13
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Apple|+01.41|+00.98|+02.13))))
	)
	:effect (and
		(
		(not ((holding Apple|+01.41|+00.98|+02.13)))
		
		)
	)
)

(:action put_PepperShaker|+01.60|+00.93|+02.16
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding PepperShaker|+01.60|+00.93|+02.16))))
	)
	:effect (and
		(
		(not ((holding PepperShaker|+01.60|+00.93|+02.16)))
		
		)
	)
)

(:action put_ButterKnife|+01.37|+00.74|+02.24
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding ButterKnife|+01.37|+00.74|+02.24))))
	)
	:effect (and
		(
		(not ((holding ButterKnife|+01.37|+00.74|+02.24)))
		
		)
	)
)

(:action put_Potato|-00.76|+00.96|+02.36
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Potato|-00.76|+00.96|+02.36))))
	)
	:effect (and
		(
		(not ((holding Potato|-00.76|+00.96|+02.36)))
		
		)
	)
)

(:action put_Plate|+01.38|+01.06|+00.01
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Plate|+01.38|+01.06|+00.01))))
	)
	:effect (and
		(
		(not ((holding Plate|+01.38|+01.06|+00.01)))
		
		)
	)
)

(:action put_DishSponge|+01.51|+00.84|+01.37
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding DishSponge|+01.51|+00.84|+01.37))))
	)
	:effect (and
		(
		(not ((holding DishSponge|+01.51|+00.84|+01.37)))
		
		)
	)
)

(:action put_Egg|+01.32|+00.96|+01.75
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Egg|+01.32|+00.96|+01.75))))
	)
	:effect (and
		(
		(not ((holding Egg|+01.32|+00.96|+01.75)))
		
		)
	)
)

(:action put_Cup|+01.31|+00.93|+00.78
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Cup|+01.31|+00.93|+00.78))))
	)
	:effect (and
		(
		(not ((holding Cup|+01.31|+00.93|+00.78)))
		
		)
	)
)

(:action put_Pan|+01.38|+01.74|+00.39
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Pan|+01.38|+01.74|+00.39))))
	)
	:effect (and
		(
		(not ((holding Pan|+01.38|+01.74|+00.39)))
		
		)
	)
)

(:action put_Spoon|+01.41|+00.74|+02.43
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Spoon|+01.41|+00.74|+02.43))))
	)
	:effect (and
		(
		(not ((holding Spoon|+01.41|+00.74|+02.43)))
		
		)
	)
)

(:action put_Mug|+01.46|+00.93|+01.09
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		(not ((holding Mug|+01.46|+00.93|+01.09))))
	)
	:effect (and
		(
		(not ((holding Mug|+01.46|+00.93|+01.09)))
		
		)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+02.39
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p CounterTop|-00.97|+00.97|+02.39)))
		)
	)
	:effect (and
		(
		(not ((holding p CounterTop|-00.97|+00.97|+02.39)))
		
		
		)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+02.38
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Drawer|-00.78|+00.77|+02.38)))
		)
	)
	:effect (and
		(
		(not ((holding p Drawer|-00.78|+00.77|+02.38)))
		
		
		)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.47
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p StoveBurner|-01.11|+00.92|+01.47)))
		)
	)
	:effect (and
		(
		(not ((holding p StoveBurner|-01.11|+00.92|+01.47)))
		
		
		)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+02.39
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Drawer|+01.37|+00.77|+02.39)))
		)
	)
	:effect (and
		(
		(not ((holding p Drawer|+01.37|+00.77|+02.39)))
		
		
		)
	)
)

(:action put_inside_Stool|-00.75|+00.01|+03.12
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Stool|-00.75|+00.01|+03.12)))
		)
	)
	:effect (and
		(
		(not ((holding p Stool|-00.75|+00.01|+03.12)))
		
		
		)
	)
)

(:action put_inside_CounterTop|+01.51|+00.97|+02.31
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p CounterTop|+01.51|+00.97|+02.31)))
		)
	)
	:effect (and
		(
		(not ((holding p CounterTop|+01.51|+00.97|+02.31)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.22|+01.39|+00.59
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.22|+01.39|+00.59)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.22|+01.39|+00.59)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.16
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.50|+02.11|+01.16)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.50|+02.11|+01.16)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.22|+02.01|+00.59
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.22|+02.01|+00.59)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.22|+02.01|+00.59)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+02.11
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.22|+00.39|+02.11)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.22|+00.39|+02.11)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.22|+00.55|+00.59
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.22|+00.55|+00.59)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.22|+00.55|+00.59)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.16
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+02.11|+01.16)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+02.11|+01.16)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+00.63
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.63|+00.39|+00.63)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.63|+00.39|+00.63)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+02.05|-00.33
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+02.05|-00.33)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+02.05|-00.33)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+00.58
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+02.11|+00.58)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+02.11|+00.58)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+02.08
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+02.11|+02.08)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+02.11|+02.08)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.21
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+02.11|+01.21)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+02.11|+01.21)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+02.08
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.50|+02.11|+02.08)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.50|+02.11|+02.08)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.21
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.50|+02.11|+01.21)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.50|+02.11|+01.21)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.69
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.50|+01.81|+02.69)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.50|+01.81|+02.69)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.10
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.50|+01.81|+02.10)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.50|+01.81|+02.10)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+02.11
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.63|+00.39|+02.11)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.63|+00.39|+02.11)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.70
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+01.81|+02.70)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+01.81|+02.70)))
		
		
		)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+00.92
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Drawer|-00.78|+00.77|+00.92)))
		)
	)
	:effect (and
		(
		(not ((holding p Drawer|-00.78|+00.77|+00.92)))
		
		
		)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.87
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p StoveBurner|-01.11|+00.92|+01.87)))
		)
	)
	:effect (and
		(
		(not ((holding p StoveBurner|-01.11|+00.92|+01.87)))
		
		
		)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+00.92
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p CounterTop|-00.97|+00.97|+00.92)))
		)
	)
	:effect (and
		(
		(not ((holding p CounterTop|-00.97|+00.97|+00.92)))
		
		
		)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+00.63
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|+01.22|+00.39|+00.63)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|+01.22|+00.39|+00.63)))
		
		
		)
	)
)

(:action put_inside_Floor|+01.23|+00.00|-00.84
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Floor|+01.23|+00.00|-00.84)))
		)
	)
	:effect (and
		(
		(not ((holding p Floor|+01.23|+00.00|-00.84)))
		
		
		)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Sink|+01.54|+00.87|+01.64)))
		)
	)
	:effect (and
		(
		(not ((holding p Sink|+01.54|+00.87|+01.64)))
		
		
		)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.87
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p StoveBurner|-00.83|+00.92|+01.87)))
		)
	)
	:effect (and
		(
		(not ((holding p StoveBurner|-00.83|+00.92|+01.87)))
		
		
		)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.47
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p StoveBurner|-00.83|+00.92|+01.47)))
		)
	)
	:effect (and
		(
		(not ((holding p StoveBurner|-00.83|+00.92|+01.47)))
		
		
		)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+00.92
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Drawer|+01.37|+00.77|+00.92)))
		)
	)
	:effect (and
		(
		(not ((holding p Drawer|+01.37|+00.77|+00.92)))
		
		
		)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.11
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cabinet|-00.91|+01.81|+02.11)))
		)
	)
	:effect (and
		(
		(not ((holding p Cabinet|-00.91|+01.81|+02.11)))
		
		
		)
	)
)

(:action put_inside_Fridge|-01.00|+00.00|+00.12
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Fridge|-01.00|+00.00|+00.12)))
		)
	)
	:effect (and
		(
		(not ((holding p Fridge|-01.00|+00.00|+00.12)))
		
		
		)
	)
)

(:action put_inside_Toaster|-01.00|+00.93|+02.56
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Toaster|-01.00|+00.93|+02.56)))
		)
	)
	:effect (and
		(
		(not ((holding p Toaster|-01.00|+00.93|+02.56)))
		
		
		)
	)
)

(:action put_inside_GarbageCan|+01.45|-00.03|+02.91
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p GarbageCan|+01.45|-00.03|+02.91)))
		)
	)
	:effect (and
		(
		(not ((holding p GarbageCan|+01.45|-00.03|+02.91)))
		
		
		)
	)
)

(:action put_inside_Microwave|+01.63|+01.48|+01.65
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Microwave|+01.63|+01.48|+01.65)))
		)
	)
	:effect (and
		(
		(not ((holding p Microwave|+01.63|+01.48|+01.65)))
		
		
		)
	)
)

(:action put_inside_Bowl|-01.06|+01.49|+00.88
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Bowl|-01.06|+01.49|+00.88)))
		)
	)
	:effect (and
		(
		(not ((holding p Bowl|-01.06|+01.49|+00.88)))
		
		
		)
	)
)

(:action put_inside_Pot|-00.82|+00.93|+00.82
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Pot|-00.82|+00.93|+00.82)))
		)
	)
	:effect (and
		(
		(not ((holding p Pot|-00.82|+00.93|+00.82)))
		
		
		)
	)
)

(:action put_inside_CoffeeMachine|+01.69|+00.93|+02.45
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p CoffeeMachine|+01.69|+00.93|+02.45)))
		)
	)
	:effect (and
		(
		(not ((holding p CoffeeMachine|+01.69|+00.93|+02.45)))
		
		
		)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64|SinkBasin
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Sink|+01.54|+00.87|+01.64|SinkBasin)))
		)
	)
	:effect (and
		(
		(not ((holding p Sink|+01.54|+00.87|+01.64|SinkBasin)))
		
		
		)
	)
)

(:action put_inside_Plate|+01.38|+01.06|+00.01
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Plate|+01.38|+01.06|+00.01)))
		)
	)
	:effect (and
		(
		(not ((holding p Plate|+01.38|+01.06|+00.01)))
		
		
		)
	)
)

(:action put_inside_Cup|+01.31|+00.93|+00.78
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Cup|+01.31|+00.93|+00.78)))
		)
	)
	:effect (and
		(
		(not ((holding p Cup|+01.31|+00.93|+00.78)))
		
		
		)
	)
)

(:action put_inside_Pan|+01.38|+01.74|+00.39
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Pan|+01.38|+01.74|+00.39)))
		)
	)
	:effect (and
		(
		(not ((holding p Pan|+01.38|+01.74|+00.39)))
		
		
		)
	)
)

(:action put_inside_Mug|+01.46|+00.93|+01.09
	:parameters (None)
	:precondition (and
		(
		
		(not ((holding p Mug|+01.46|+00.93|+01.09)))
		)
	)
	:effect (and
		(
		(not ((holding p Mug|+01.46|+00.93|+01.09)))
		
		
		)
	)
)

(:action open_Drawer|-00.78|+00.77|+02.38
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Drawer|-00.78|+00.77|+02.38))))
	)
	:effect (and
		()
	)
)

(:action open_Drawer|+01.37|+00.77|+02.39
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Drawer|+01.37|+00.77|+02.39))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.22|+01.39|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.22|+01.39|+00.59))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.16
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.50|+02.11|+01.16))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.22|+02.01|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.22|+02.01|+00.59))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.22|+00.39|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.22|+00.39|+02.11))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.22|+00.55|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.22|+00.55|+00.59))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.16
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+02.11|+01.16))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.63|+00.39|+00.63
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.63|+00.39|+00.63))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+02.05|-00.33
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+02.05|-00.33))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+02.11|+00.58
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+02.11|+00.58))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+02.11|+02.08
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+02.11|+02.08))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.21
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+02.11|+01.21))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.50|+02.11|+02.08
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.50|+02.11|+02.08))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.21
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.50|+02.11|+01.21))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.69
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.50|+01.81|+02.69))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.10
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.50|+01.81|+02.10))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.63|+00.39|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.63|+00.39|+02.11))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.70
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+01.81|+02.70))))
	)
	:effect (and
		()
	)
)

(:action open_Drawer|-00.78|+00.77|+00.92
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Drawer|-00.78|+00.77|+00.92))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|+01.22|+00.39|+00.63
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|+01.22|+00.39|+00.63))))
	)
	:effect (and
		()
	)
)

(:action open_Drawer|+01.37|+00.77|+00.92
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Drawer|+01.37|+00.77|+00.92))))
	)
	:effect (and
		()
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Cabinet|-00.91|+01.81|+02.11))))
	)
	:effect (and
		()
	)
)

(:action open_Fridge|-01.00|+00.00|+00.12
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Fridge|-01.00|+00.00|+00.12))))
	)
	:effect (and
		()
	)
)

(:action open_Microwave|+01.63|+01.48|+01.65
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		(not ((opened Microwave|+01.63|+01.48|+01.65))))
	)
	:effect (and
		()
	)
)

(:action close_Drawer|-00.78|+00.77|+02.38
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Drawer|-00.78|+00.77|+02.38))))
	)
)

(:action close_Drawer|+01.37|+00.77|+02.39
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Drawer|+01.37|+00.77|+02.39))))
	)
)

(:action close_Cabinet|+01.22|+01.39|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.22|+01.39|+00.59))))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.16
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.50|+02.11|+01.16))))
	)
)

(:action close_Cabinet|+01.22|+02.01|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.22|+02.01|+00.59))))
	)
)

(:action close_Cabinet|+01.22|+00.39|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.22|+00.39|+02.11))))
	)
)

(:action close_Cabinet|+01.22|+00.55|+00.59
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.22|+00.55|+00.59))))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.16
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+02.11|+01.16))))
	)
)

(:action close_Cabinet|-00.63|+00.39|+00.63
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.63|+00.39|+00.63))))
	)
)

(:action close_Cabinet|-00.91|+02.05|-00.33
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+02.05|-00.33))))
	)
)

(:action close_Cabinet|-00.91|+02.11|+00.58
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+02.11|+00.58))))
	)
)

(:action close_Cabinet|-00.91|+02.11|+02.08
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+02.11|+02.08))))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.21
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+02.11|+01.21))))
	)
)

(:action close_Cabinet|+01.50|+02.11|+02.08
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.50|+02.11|+02.08))))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.21
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.50|+02.11|+01.21))))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.69
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.50|+01.81|+02.69))))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.10
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.50|+01.81|+02.10))))
	)
)

(:action close_Cabinet|-00.63|+00.39|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.63|+00.39|+02.11))))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.70
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+01.81|+02.70))))
	)
)

(:action close_Drawer|-00.78|+00.77|+00.92
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Drawer|-00.78|+00.77|+00.92))))
	)
)

(:action close_Cabinet|+01.22|+00.39|+00.63
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|+01.22|+00.39|+00.63))))
	)
)

(:action close_Drawer|+01.37|+00.77|+00.92
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Drawer|+01.37|+00.77|+00.92))))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.11
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Cabinet|-00.91|+01.81|+02.11))))
	)
)

(:action close_Fridge|-01.00|+00.00|+00.12
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Fridge|-01.00|+00.00|+00.12))))
	)
)

(:action close_Microwave|+01.63|+01.48|+01.65
	:parameters (( ?c - cell))
	:precondition (and
		(
		
		
		)
	)
	:effect (and
		((not ((opened Microwave|+01.63|+01.48|+01.65))))
	)
)


)