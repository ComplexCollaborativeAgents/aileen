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

(:action pickup_Lettuce|+01.46|+01.01|+01.68
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Lettuce|+01.46|+01.01|+01.68)
		(robot_location ?c)
		(location Lettuce|+01.46|+01.01|+01.68 ?c)
		(not (holding Lettuce|+01.46|+01.01|+01.68))
	)
	:effect (and
		(holding Lettuce|+01.46|+01.01|+01.68)
		(not (location Lettuce|+01.46|+01.01|+01.68 ?c))
	)
)

(:action pickup_SoapBottle|+01.67|+00.93|+01.11
	:parameters (?c - cell)
	:precondition (and
		(is_pickable SoapBottle|+01.67|+00.93|+01.11)
		(robot_location ?c)
		(location SoapBottle|+01.67|+00.93|+01.11 ?c)
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
	)
	:effect (and
		(holding SoapBottle|+01.67|+00.93|+01.11)
		(not (location SoapBottle|+01.67|+00.93|+01.11 ?c))
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

(:action pickup_Fork|+01.35|+00.74|+02.50
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Fork|+01.35|+00.74|+02.50)
		(robot_location ?c)
		(location Fork|+01.35|+00.74|+02.50 ?c)
		(not (holding Fork|+01.35|+00.74|+02.50))
	)
	:effect (and
		(holding Fork|+01.35|+00.74|+02.50)
		(not (location Fork|+01.35|+00.74|+02.50 ?c))
	)
)

(:action pickup_Tomato|+01.44|+00.99|+00.84
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Tomato|+01.44|+00.99|+00.84)
		(robot_location ?c)
		(location Tomato|+01.44|+00.99|+00.84 ?c)
		(not (holding Tomato|+01.44|+00.99|+00.84))
	)
	:effect (and
		(holding Tomato|+01.44|+00.99|+00.84)
		(not (location Tomato|+01.44|+00.99|+00.84 ?c))
	)
)

(:action pickup_Bowl|-01.06|+01.49|+00.88
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Bowl|-01.06|+01.49|+00.88)
		(robot_location ?c)
		(location Bowl|-01.06|+01.49|+00.88 ?c)
		(not (holding Bowl|-01.06|+01.49|+00.88))
	)
	:effect (and
		(holding Bowl|-01.06|+01.49|+00.88)
		(not (location Bowl|-01.06|+01.49|+00.88 ?c))
	)
)

(:action pickup_Pot|-00.82|+00.93|+00.82
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Pot|-00.82|+00.93|+00.82)
		(robot_location ?c)
		(location Pot|-00.82|+00.93|+00.82 ?c)
		(not (holding Pot|-00.82|+00.93|+00.82))
	)
	:effect (and
		(holding Pot|-00.82|+00.93|+00.82)
		(not (location Pot|-00.82|+00.93|+00.82 ?c))
	)
)

(:action pickup_Spatula|+01.34|+00.93|+02.40
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Spatula|+01.34|+00.93|+02.40)
		(robot_location ?c)
		(location Spatula|+01.34|+00.93|+02.40 ?c)
		(not (holding Spatula|+01.34|+00.93|+02.40))
	)
	:effect (and
		(holding Spatula|+01.34|+00.93|+02.40)
		(not (location Spatula|+01.34|+00.93|+02.40 ?c))
	)
)

(:action pickup_Knife|+01.36|+00.74|+00.87
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Knife|+01.36|+00.74|+00.87)
		(robot_location ?c)
		(location Knife|+01.36|+00.74|+00.87 ?c)
		(not (holding Knife|+01.36|+00.74|+00.87))
	)
	:effect (and
		(holding Knife|+01.36|+00.74|+00.87)
		(not (location Knife|+01.36|+00.74|+00.87 ?c))
	)
)

(:action pickup_SaltShaker|+01.67|+00.93|+02.05
	:parameters (?c - cell)
	:precondition (and
		(is_pickable SaltShaker|+01.67|+00.93|+02.05)
		(robot_location ?c)
		(location SaltShaker|+01.67|+00.93|+02.05 ?c)
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
	)
	:effect (and
		(holding SaltShaker|+01.67|+00.93|+02.05)
		(not (location SaltShaker|+01.67|+00.93|+02.05 ?c))
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

(:action pickup_PepperShaker|+01.60|+00.93|+02.16
	:parameters (?c - cell)
	:precondition (and
		(is_pickable PepperShaker|+01.60|+00.93|+02.16)
		(robot_location ?c)
		(location PepperShaker|+01.60|+00.93|+02.16 ?c)
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
	)
	:effect (and
		(holding PepperShaker|+01.60|+00.93|+02.16)
		(not (location PepperShaker|+01.60|+00.93|+02.16 ?c))
	)
)

(:action pickup_ButterKnife|+01.37|+00.74|+02.24
	:parameters (?c - cell)
	:precondition (and
		(is_pickable ButterKnife|+01.37|+00.74|+02.24)
		(robot_location ?c)
		(location ButterKnife|+01.37|+00.74|+02.24 ?c)
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
	)
	:effect (and
		(holding ButterKnife|+01.37|+00.74|+02.24)
		(not (location ButterKnife|+01.37|+00.74|+02.24 ?c))
	)
)

(:action pickup_Potato|-00.76|+00.96|+02.36
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Potato|-00.76|+00.96|+02.36)
		(robot_location ?c)
		(location Potato|-00.76|+00.96|+02.36 ?c)
		(not (holding Potato|-00.76|+00.96|+02.36))
	)
	:effect (and
		(holding Potato|-00.76|+00.96|+02.36)
		(not (location Potato|-00.76|+00.96|+02.36 ?c))
	)
)

(:action pickup_Plate|+01.38|+01.06|+00.01
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Plate|+01.38|+01.06|+00.01)
		(robot_location ?c)
		(location Plate|+01.38|+01.06|+00.01 ?c)
		(not (holding Plate|+01.38|+01.06|+00.01))
	)
	:effect (and
		(holding Plate|+01.38|+01.06|+00.01)
		(not (location Plate|+01.38|+01.06|+00.01 ?c))
	)
)

(:action pickup_DishSponge|+01.51|+00.84|+01.37
	:parameters (?c - cell)
	:precondition (and
		(is_pickable DishSponge|+01.51|+00.84|+01.37)
		(robot_location ?c)
		(location DishSponge|+01.51|+00.84|+01.37 ?c)
		(not (holding DishSponge|+01.51|+00.84|+01.37))
	)
	:effect (and
		(holding DishSponge|+01.51|+00.84|+01.37)
		(not (location DishSponge|+01.51|+00.84|+01.37 ?c))
	)
)

(:action pickup_Egg|+01.32|+00.96|+01.75
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Egg|+01.32|+00.96|+01.75)
		(robot_location ?c)
		(location Egg|+01.32|+00.96|+01.75 ?c)
		(not (holding Egg|+01.32|+00.96|+01.75))
	)
	:effect (and
		(holding Egg|+01.32|+00.96|+01.75)
		(not (location Egg|+01.32|+00.96|+01.75 ?c))
	)
)

(:action pickup_Cup|+01.31|+00.93|+00.78
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Cup|+01.31|+00.93|+00.78)
		(robot_location ?c)
		(location Cup|+01.31|+00.93|+00.78 ?c)
		(not (holding Cup|+01.31|+00.93|+00.78))
	)
	:effect (and
		(holding Cup|+01.31|+00.93|+00.78)
		(not (location Cup|+01.31|+00.93|+00.78 ?c))
	)
)

(:action pickup_Pan|+01.38|+01.74|+00.39
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Pan|+01.38|+01.74|+00.39)
		(robot_location ?c)
		(location Pan|+01.38|+01.74|+00.39 ?c)
		(not (holding Pan|+01.38|+01.74|+00.39))
	)
	:effect (and
		(holding Pan|+01.38|+01.74|+00.39)
		(not (location Pan|+01.38|+01.74|+00.39 ?c))
	)
)

(:action pickup_Spoon|+01.41|+00.74|+02.43
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Spoon|+01.41|+00.74|+02.43)
		(robot_location ?c)
		(location Spoon|+01.41|+00.74|+02.43 ?c)
		(not (holding Spoon|+01.41|+00.74|+02.43))
	)
	:effect (and
		(holding Spoon|+01.41|+00.74|+02.43)
		(not (location Spoon|+01.41|+00.74|+02.43 ?c))
	)
)

(:action pickup_Mug|+01.46|+00.93|+01.09
	:parameters (?c - cell)
	:precondition (and
		(is_pickable Mug|+01.46|+00.93|+01.09)
		(robot_location ?c)
		(location Mug|+01.46|+00.93|+01.09 ?c)
		(not (holding Mug|+01.46|+00.93|+01.09))
	)
	:effect (and
		(holding Mug|+01.46|+00.93|+01.09)
		(not (location Mug|+01.46|+00.93|+01.09 ?c))
	)
)

(:action put_Lettuce|+01.46|+01.01|+01.68
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Lettuce|+01.46|+01.01|+01.68 ?c))
		(holding Lettuce|+01.46|+01.01|+01.68)
	)
	:effect (and
		(not (holding Lettuce|+01.46|+01.01|+01.68))
		(location Lettuce|+01.46|+01.01|+01.68 ?c)
	)
)

(:action put_SoapBottle|+01.67|+00.93|+01.11
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location SoapBottle|+01.67|+00.93|+01.11 ?c))
		(holding SoapBottle|+01.67|+00.93|+01.11)
	)
	:effect (and
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
		(location SoapBottle|+01.67|+00.93|+01.11 ?c)
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

(:action put_Fork|+01.35|+00.74|+02.50
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Fork|+01.35|+00.74|+02.50 ?c))
		(holding Fork|+01.35|+00.74|+02.50)
	)
	:effect (and
		(not (holding Fork|+01.35|+00.74|+02.50))
		(location Fork|+01.35|+00.74|+02.50 ?c)
	)
)

(:action put_Tomato|+01.44|+00.99|+00.84
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Tomato|+01.44|+00.99|+00.84 ?c))
		(holding Tomato|+01.44|+00.99|+00.84)
	)
	:effect (and
		(not (holding Tomato|+01.44|+00.99|+00.84))
		(location Tomato|+01.44|+00.99|+00.84 ?c)
	)
)

(:action put_Bowl|-01.06|+01.49|+00.88
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Bowl|-01.06|+01.49|+00.88 ?c))
		(holding Bowl|-01.06|+01.49|+00.88)
	)
	:effect (and
		(not (holding Bowl|-01.06|+01.49|+00.88))
		(location Bowl|-01.06|+01.49|+00.88 ?c)
	)
)

(:action put_Pot|-00.82|+00.93|+00.82
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Pot|-00.82|+00.93|+00.82 ?c))
		(holding Pot|-00.82|+00.93|+00.82)
	)
	:effect (and
		(not (holding Pot|-00.82|+00.93|+00.82))
		(location Pot|-00.82|+00.93|+00.82 ?c)
	)
)

(:action put_Spatula|+01.34|+00.93|+02.40
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Spatula|+01.34|+00.93|+02.40 ?c))
		(holding Spatula|+01.34|+00.93|+02.40)
	)
	:effect (and
		(not (holding Spatula|+01.34|+00.93|+02.40))
		(location Spatula|+01.34|+00.93|+02.40 ?c)
	)
)

(:action put_Knife|+01.36|+00.74|+00.87
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Knife|+01.36|+00.74|+00.87 ?c))
		(holding Knife|+01.36|+00.74|+00.87)
	)
	:effect (and
		(not (holding Knife|+01.36|+00.74|+00.87))
		(location Knife|+01.36|+00.74|+00.87 ?c)
	)
)

(:action put_SaltShaker|+01.67|+00.93|+02.05
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location SaltShaker|+01.67|+00.93|+02.05 ?c))
		(holding SaltShaker|+01.67|+00.93|+02.05)
	)
	:effect (and
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
		(location SaltShaker|+01.67|+00.93|+02.05 ?c)
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

(:action put_PepperShaker|+01.60|+00.93|+02.16
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location PepperShaker|+01.60|+00.93|+02.16 ?c))
		(holding PepperShaker|+01.60|+00.93|+02.16)
	)
	:effect (and
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
		(location PepperShaker|+01.60|+00.93|+02.16 ?c)
	)
)

(:action put_ButterKnife|+01.37|+00.74|+02.24
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ButterKnife|+01.37|+00.74|+02.24 ?c))
		(holding ButterKnife|+01.37|+00.74|+02.24)
	)
	:effect (and
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
		(location ButterKnife|+01.37|+00.74|+02.24 ?c)
	)
)

(:action put_Potato|-00.76|+00.96|+02.36
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Potato|-00.76|+00.96|+02.36 ?c))
		(holding Potato|-00.76|+00.96|+02.36)
	)
	:effect (and
		(not (holding Potato|-00.76|+00.96|+02.36))
		(location Potato|-00.76|+00.96|+02.36 ?c)
	)
)

(:action put_Plate|+01.38|+01.06|+00.01
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Plate|+01.38|+01.06|+00.01 ?c))
		(holding Plate|+01.38|+01.06|+00.01)
	)
	:effect (and
		(not (holding Plate|+01.38|+01.06|+00.01))
		(location Plate|+01.38|+01.06|+00.01 ?c)
	)
)

(:action put_DishSponge|+01.51|+00.84|+01.37
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location DishSponge|+01.51|+00.84|+01.37 ?c))
		(holding DishSponge|+01.51|+00.84|+01.37)
	)
	:effect (and
		(not (holding DishSponge|+01.51|+00.84|+01.37))
		(location DishSponge|+01.51|+00.84|+01.37 ?c)
	)
)

(:action put_Egg|+01.32|+00.96|+01.75
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Egg|+01.32|+00.96|+01.75 ?c))
		(holding Egg|+01.32|+00.96|+01.75)
	)
	:effect (and
		(not (holding Egg|+01.32|+00.96|+01.75))
		(location Egg|+01.32|+00.96|+01.75 ?c)
	)
)

(:action put_Cup|+01.31|+00.93|+00.78
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Cup|+01.31|+00.93|+00.78 ?c))
		(holding Cup|+01.31|+00.93|+00.78)
	)
	:effect (and
		(not (holding Cup|+01.31|+00.93|+00.78))
		(location Cup|+01.31|+00.93|+00.78 ?c)
	)
)

(:action put_Pan|+01.38|+01.74|+00.39
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Pan|+01.38|+01.74|+00.39 ?c))
		(holding Pan|+01.38|+01.74|+00.39)
	)
	:effect (and
		(not (holding Pan|+01.38|+01.74|+00.39))
		(location Pan|+01.38|+01.74|+00.39 ?c)
	)
)

(:action put_Spoon|+01.41|+00.74|+02.43
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Spoon|+01.41|+00.74|+02.43 ?c))
		(holding Spoon|+01.41|+00.74|+02.43)
	)
	:effect (and
		(not (holding Spoon|+01.41|+00.74|+02.43))
		(location Spoon|+01.41|+00.74|+02.43 ?c)
	)
)

(:action put_Mug|+01.46|+00.93|+01.09
	:parameters (?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location Mug|+01.46|+00.93|+01.09 ?c))
		(holding Mug|+01.46|+00.93|+01.09)
	)
	:effect (and
		(not (holding Mug|+01.46|+00.93|+01.09))
		(location Mug|+01.46|+00.93|+01.09 ?c)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+02.39
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened CounterTop|-00.97|+00.97|+02.39)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in CounterTop|-00.97|+00.97|+02.39 ?p)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+02.38
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Drawer|-00.78|+00.77|+02.38)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Drawer|-00.78|+00.77|+02.38 ?p)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.47
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened StoveBurner|-01.11|+00.92|+01.47)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in StoveBurner|-01.11|+00.92|+01.47 ?p)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+02.39
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Drawer|+01.37|+00.77|+02.39)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Drawer|+01.37|+00.77|+02.39 ?p)
	)
)

(:action put_inside_Stool|-00.75|+00.01|+03.12
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Stool|-00.75|+00.01|+03.12)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Stool|-00.75|+00.01|+03.12 ?p)
	)
)

(:action put_inside_CounterTop|+01.51|+00.97|+02.31
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened CounterTop|+01.51|+00.97|+02.31)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in CounterTop|+01.51|+00.97|+02.31 ?p)
	)
)

(:action put_inside_Cabinet|+01.22|+01.39|+00.59
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.22|+01.39|+00.59 ?p)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.16
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.50|+02.11|+01.16 ?p)
	)
)

(:action put_inside_Cabinet|+01.22|+02.01|+00.59
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.22|+02.01|+00.59 ?p)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+02.11
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.22|+00.39|+02.11 ?p)
	)
)

(:action put_inside_Cabinet|+01.22|+00.55|+00.59
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.22|+00.55|+00.59 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.16
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+02.11|+01.16 ?p)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+00.63
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.63|+00.39|+00.63 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+02.05|-00.33
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+02.05|-00.33 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+00.58
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+02.11|+00.58 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+02.08
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+02.11|+02.08 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.21
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+02.11|+01.21 ?p)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+02.08
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.50|+02.11|+02.08 ?p)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.21
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.50|+02.11|+01.21 ?p)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.69
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.50|+01.81|+02.69 ?p)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.10
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.50|+01.81|+02.10 ?p)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+02.11
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.63|+00.39|+02.11 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.70
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+01.81|+02.70 ?p)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+00.92
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Drawer|-00.78|+00.77|+00.92)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Drawer|-00.78|+00.77|+00.92 ?p)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.87
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened StoveBurner|-01.11|+00.92|+01.87)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in StoveBurner|-01.11|+00.92|+01.87 ?p)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+00.92
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened CounterTop|-00.97|+00.97|+00.92)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in CounterTop|-00.97|+00.97|+00.92 ?p)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+00.63
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|+01.22|+00.39|+00.63 ?p)
	)
)

(:action put_inside_Floor|+01.23|+00.00|-00.84
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Floor|+01.23|+00.00|-00.84)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Floor|+01.23|+00.00|-00.84 ?p)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Sink|+01.54|+00.87|+01.64)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Sink|+01.54|+00.87|+01.64 ?p)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.87
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened StoveBurner|-00.83|+00.92|+01.87)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in StoveBurner|-00.83|+00.92|+01.87 ?p)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.47
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened StoveBurner|-00.83|+00.92|+01.47)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in StoveBurner|-00.83|+00.92|+01.47 ?p)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+00.92
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Drawer|+01.37|+00.77|+00.92)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Drawer|+01.37|+00.77|+00.92 ?p)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.11
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cabinet|-00.91|+01.81|+02.11)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cabinet|-00.91|+01.81|+02.11 ?p)
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

(:action put_inside_Toaster|-01.00|+00.93|+02.56
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Toaster|-01.00|+00.93|+02.56)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Toaster|-01.00|+00.93|+02.56 ?p)
	)
)

(:action put_inside_GarbageCan|+01.45|-00.03|+02.91
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened GarbageCan|+01.45|-00.03|+02.91)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in GarbageCan|+01.45|-00.03|+02.91 ?p)
	)
)

(:action put_inside_Microwave|+01.63|+01.48|+01.65
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Microwave|+01.63|+01.48|+01.65)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Microwave|+01.63|+01.48|+01.65 ?p)
	)
)

(:action put_inside_Bowl|-01.06|+01.49|+00.88
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Bowl|-01.06|+01.49|+00.88)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Bowl|-01.06|+01.49|+00.88 ?p)
	)
)

(:action put_inside_Pot|-00.82|+00.93|+00.82
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Pot|-00.82|+00.93|+00.82)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Pot|-00.82|+00.93|+00.82 ?p)
	)
)

(:action put_inside_CoffeeMachine|+01.69|+00.93|+02.45
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened CoffeeMachine|+01.69|+00.93|+02.45)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in CoffeeMachine|+01.69|+00.93|+02.45 ?p)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64|SinkBasin
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Sink|+01.54|+00.87|+01.64|SinkBasin)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Sink|+01.54|+00.87|+01.64|SinkBasin ?p)
	)
)

(:action put_inside_Plate|+01.38|+01.06|+00.01
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Plate|+01.38|+01.06|+00.01)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Plate|+01.38|+01.06|+00.01 ?p)
	)
)

(:action put_inside_Cup|+01.31|+00.93|+00.78
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Cup|+01.31|+00.93|+00.78)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Cup|+01.31|+00.93|+00.78 ?p)
	)
)

(:action put_inside_Pan|+01.38|+01.74|+00.39
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Pan|+01.38|+01.74|+00.39)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Pan|+01.38|+01.74|+00.39 ?p)
	)
)

(:action put_inside_Mug|+01.46|+00.93|+01.09
	:parameters (?p - interactable ?c - cell)
	:precondition (and
		(robot_location ?c)
		(not (location ?p ?c))
		(holding ?p)
		(opened Mug|+01.46|+00.93|+01.09)
	)
	:effect (and
		(not (holding ?p))
		(location ?p ?c)
		(in Mug|+01.46|+00.93|+01.09 ?p)
	)
)

(:action open_Drawer|-00.78|+00.77|+02.38
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+02.38)
		(robot_location ?c)
		(location Drawer|-00.78|+00.77|+02.38 ?c)
		(not (opened Drawer|-00.78|+00.77|+02.38))
	)
	:effect (and
		(opened Drawer|-00.78|+00.77|+02.38)
	)
)

(:action open_Drawer|+01.37|+00.77|+02.39
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+02.39)
		(robot_location ?c)
		(location Drawer|+01.37|+00.77|+02.39 ?c)
		(not (opened Drawer|+01.37|+00.77|+02.39))
	)
	:effect (and
		(opened Drawer|+01.37|+00.77|+02.39)
	)
)

(:action open_Cabinet|+01.22|+01.39|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+01.39|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+01.39|+00.59 ?c)
		(not (opened Cabinet|+01.22|+01.39|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.16
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.16)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+01.16 ?c)
		(not (opened Cabinet|+01.50|+02.11|+01.16))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
)

(:action open_Cabinet|+01.22|+02.01|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+02.01|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+02.01|+00.59 ?c)
		(not (opened Cabinet|+01.22|+02.01|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
)

(:action open_Cabinet|+01.22|+00.39|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+02.11)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.39|+02.11 ?c)
		(not (opened Cabinet|+01.22|+00.39|+02.11))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
)

(:action open_Cabinet|+01.22|+00.55|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.55|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.55|+00.59 ?c)
		(not (opened Cabinet|+01.22|+00.55|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.16
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.16)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+01.16 ?c)
		(not (opened Cabinet|-00.91|+02.11|+01.16))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
)

(:action open_Cabinet|-00.63|+00.39|+00.63
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+00.63)
		(robot_location ?c)
		(location Cabinet|-00.63|+00.39|+00.63 ?c)
		(not (opened Cabinet|-00.63|+00.39|+00.63))
	)
	:effect (and
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
)

(:action open_Cabinet|-00.91|+02.05|-00.33
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.05|-00.33)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.05|-00.33 ?c)
		(not (opened Cabinet|-00.91|+02.05|-00.33))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
)

(:action open_Cabinet|-00.91|+02.11|+00.58
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+00.58)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+00.58 ?c)
		(not (opened Cabinet|-00.91|+02.11|+00.58))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
)

(:action open_Cabinet|-00.91|+02.11|+02.08
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+02.08)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+02.08 ?c)
		(not (opened Cabinet|-00.91|+02.11|+02.08))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.21
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.21)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+01.21 ?c)
		(not (opened Cabinet|-00.91|+02.11|+01.21))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
)

(:action open_Cabinet|+01.50|+02.11|+02.08
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+02.08)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+02.08 ?c)
		(not (opened Cabinet|+01.50|+02.11|+02.08))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.21
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.21)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+01.21 ?c)
		(not (opened Cabinet|+01.50|+02.11|+01.21))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.69
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.69)
		(robot_location ?c)
		(location Cabinet|+01.50|+01.81|+02.69 ?c)
		(not (opened Cabinet|+01.50|+01.81|+02.69))
	)
	:effect (and
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.10
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.10)
		(robot_location ?c)
		(location Cabinet|+01.50|+01.81|+02.10 ?c)
		(not (opened Cabinet|+01.50|+01.81|+02.10))
	)
	:effect (and
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
)

(:action open_Cabinet|-00.63|+00.39|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+02.11)
		(robot_location ?c)
		(location Cabinet|-00.63|+00.39|+02.11 ?c)
		(not (opened Cabinet|-00.63|+00.39|+02.11))
	)
	:effect (and
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.70
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.70)
		(robot_location ?c)
		(location Cabinet|-00.91|+01.81|+02.70 ?c)
		(not (opened Cabinet|-00.91|+01.81|+02.70))
	)
	:effect (and
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
)

(:action open_Drawer|-00.78|+00.77|+00.92
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+00.92)
		(robot_location ?c)
		(location Drawer|-00.78|+00.77|+00.92 ?c)
		(not (opened Drawer|-00.78|+00.77|+00.92))
	)
	:effect (and
		(opened Drawer|-00.78|+00.77|+00.92)
	)
)

(:action open_Cabinet|+01.22|+00.39|+00.63
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+00.63)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.39|+00.63 ?c)
		(not (opened Cabinet|+01.22|+00.39|+00.63))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
)

(:action open_Drawer|+01.37|+00.77|+00.92
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+00.92)
		(robot_location ?c)
		(location Drawer|+01.37|+00.77|+00.92 ?c)
		(not (opened Drawer|+01.37|+00.77|+00.92))
	)
	:effect (and
		(opened Drawer|+01.37|+00.77|+00.92)
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.11)
		(robot_location ?c)
		(location Cabinet|-00.91|+01.81|+02.11 ?c)
		(not (opened Cabinet|-00.91|+01.81|+02.11))
	)
	:effect (and
		(opened Cabinet|-00.91|+01.81|+02.11)
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

(:action open_Microwave|+01.63|+01.48|+01.65
	:parameters (?c - cell)
	:precondition (and
		(is_openable Microwave|+01.63|+01.48|+01.65)
		(robot_location ?c)
		(location Microwave|+01.63|+01.48|+01.65 ?c)
		(not (opened Microwave|+01.63|+01.48|+01.65))
	)
	:effect (and
		(opened Microwave|+01.63|+01.48|+01.65)
	)
)

(:action close_Drawer|-00.78|+00.77|+02.38
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+02.38)
		(robot_location ?c)
		(location Drawer|-00.78|+00.77|+02.38 ?c)
		(opened Drawer|-00.78|+00.77|+02.38)
	)
	:effect (and
		(not (opened Drawer|-00.78|+00.77|+02.38))
	)
)

(:action close_Drawer|+01.37|+00.77|+02.39
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+02.39)
		(robot_location ?c)
		(location Drawer|+01.37|+00.77|+02.39 ?c)
		(opened Drawer|+01.37|+00.77|+02.39)
	)
	:effect (and
		(not (opened Drawer|+01.37|+00.77|+02.39))
	)
)

(:action close_Cabinet|+01.22|+01.39|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+01.39|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+01.39|+00.59 ?c)
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+01.39|+00.59))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.16
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.16)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+01.16 ?c)
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+01.16))
	)
)

(:action close_Cabinet|+01.22|+02.01|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+02.01|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+02.01|+00.59 ?c)
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+02.01|+00.59))
	)
)

(:action close_Cabinet|+01.22|+00.39|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+02.11)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.39|+02.11 ?c)
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.39|+02.11))
	)
)

(:action close_Cabinet|+01.22|+00.55|+00.59
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.55|+00.59)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.55|+00.59 ?c)
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.55|+00.59))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.16
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.16)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+01.16 ?c)
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+01.16))
	)
)

(:action close_Cabinet|-00.63|+00.39|+00.63
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+00.63)
		(robot_location ?c)
		(location Cabinet|-00.63|+00.39|+00.63 ?c)
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
	:effect (and
		(not (opened Cabinet|-00.63|+00.39|+00.63))
	)
)

(:action close_Cabinet|-00.91|+02.05|-00.33
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.05|-00.33)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.05|-00.33 ?c)
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.05|-00.33))
	)
)

(:action close_Cabinet|-00.91|+02.11|+00.58
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+00.58)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+00.58 ?c)
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+00.58))
	)
)

(:action close_Cabinet|-00.91|+02.11|+02.08
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+02.08)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+02.08 ?c)
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+02.08))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.21
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.21)
		(robot_location ?c)
		(location Cabinet|-00.91|+02.11|+01.21 ?c)
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+01.21))
	)
)

(:action close_Cabinet|+01.50|+02.11|+02.08
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+02.08)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+02.08 ?c)
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+02.08))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.21
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.21)
		(robot_location ?c)
		(location Cabinet|+01.50|+02.11|+01.21 ?c)
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+01.21))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.69
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.69)
		(robot_location ?c)
		(location Cabinet|+01.50|+01.81|+02.69 ?c)
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+01.81|+02.69))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.10
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.10)
		(robot_location ?c)
		(location Cabinet|+01.50|+01.81|+02.10 ?c)
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+01.81|+02.10))
	)
)

(:action close_Cabinet|-00.63|+00.39|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+02.11)
		(robot_location ?c)
		(location Cabinet|-00.63|+00.39|+02.11 ?c)
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
	:effect (and
		(not (opened Cabinet|-00.63|+00.39|+02.11))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.70
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.70)
		(robot_location ?c)
		(location Cabinet|-00.91|+01.81|+02.70 ?c)
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+01.81|+02.70))
	)
)

(:action close_Drawer|-00.78|+00.77|+00.92
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+00.92)
		(robot_location ?c)
		(location Drawer|-00.78|+00.77|+00.92 ?c)
		(opened Drawer|-00.78|+00.77|+00.92)
	)
	:effect (and
		(not (opened Drawer|-00.78|+00.77|+00.92))
	)
)

(:action close_Cabinet|+01.22|+00.39|+00.63
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+00.63)
		(robot_location ?c)
		(location Cabinet|+01.22|+00.39|+00.63 ?c)
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.39|+00.63))
	)
)

(:action close_Drawer|+01.37|+00.77|+00.92
	:parameters (?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+00.92)
		(robot_location ?c)
		(location Drawer|+01.37|+00.77|+00.92 ?c)
		(opened Drawer|+01.37|+00.77|+00.92)
	)
	:effect (and
		(not (opened Drawer|+01.37|+00.77|+00.92))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.11
	:parameters (?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.11)
		(robot_location ?c)
		(location Cabinet|-00.91|+01.81|+02.11 ?c)
		(opened Cabinet|-00.91|+01.81|+02.11)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+01.81|+02.11))
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

(:action close_Microwave|+01.63|+01.48|+01.65
	:parameters (?c - cell)
	:precondition (and
		(is_openable Microwave|+01.63|+01.48|+01.65)
		(robot_location ?c)
		(location Microwave|+01.63|+01.48|+01.65 ?c)
		(opened Microwave|+01.63|+01.48|+01.65)
	)
	:effect (and
		(not (opened Microwave|+01.63|+01.48|+01.65))
	)
)




)
