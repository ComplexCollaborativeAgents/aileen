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
(is_near ?c - cell)
(location ?p - interactable ?c - cell)
(holding ?p - interactable)
(opened ?p - interactable)
(in ?p1 ?p2 - interactable)
(on ?p1 ?p2 - interactable)
(closed ?p - interactable)
(robot_location ?c - cell)
)

(:functions

)

(:action teleport
	:parameters ( ?from ?to - cell)
	:precondition (and
		(is_reachable ?to)
		(= (robot_x) (cell_x ?from))
		(= (robot_y) (cell_y ?from))
	)
	:effect (and
		(assign (prev_robot_x) (cell_x ?from))
		(assign (prev_robot_y) (cell_y ?from))
		(assign (robot_x) (cell_x ?to))
		(assign (robot_y) (cell_y ?to))
	)
)

(:action pickup_Lettuce|+01.46|+01.01|+01.68
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Lettuce|+01.46|+01.01|+01.68)
		(is_near ?c)
		(location Lettuce|+01.46|+01.01|+01.68 ?c)
		(not (holding Lettuce|+01.46|+01.01|+01.68))
	)
	:effect (and
		(holding Lettuce|+01.46|+01.01|+01.68)
		(not (holding Lettuce|+01.46|+01.01|+01.68))
		(location_x Lettuce|+01.46|+01.01|+01.68)
		(location_y Lettuce|+01.46|+01.01|+01.68)
	)
)

(:action pickup_SoapBottle|+01.67|+00.93|+01.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable SoapBottle|+01.67|+00.93|+01.11)
		(is_near ?c)
		(location SoapBottle|+01.67|+00.93|+01.11 ?c)
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
	)
	:effect (and
		(holding SoapBottle|+01.67|+00.93|+01.11)
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
		(location_x SoapBottle|+01.67|+00.93|+01.11)
		(location_y SoapBottle|+01.67|+00.93|+01.11)
	)
)

(:action pickup_Bread|-00.92|+00.99|+02.27
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Bread|-00.92|+00.99|+02.27)
		(is_near ?c)
		(location Bread|-00.92|+00.99|+02.27 ?c)
		(not (holding Bread|-00.92|+00.99|+02.27))
	)
	:effect (and
		(holding Bread|-00.92|+00.99|+02.27)
		(not (holding Bread|-00.92|+00.99|+02.27))
		(location_x Bread|-00.92|+00.99|+02.27)
		(location_y Bread|-00.92|+00.99|+02.27)
	)
)

(:action pickup_Fork|+01.35|+00.74|+02.50
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Fork|+01.35|+00.74|+02.50)
		(is_near ?c)
		(location Fork|+01.35|+00.74|+02.50 ?c)
		(not (holding Fork|+01.35|+00.74|+02.50))
	)
	:effect (and
		(holding Fork|+01.35|+00.74|+02.50)
		(not (holding Fork|+01.35|+00.74|+02.50))
		(location_x Fork|+01.35|+00.74|+02.50)
		(location_y Fork|+01.35|+00.74|+02.50)
	)
)

(:action pickup_Tomato|+01.44|+00.99|+00.84
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Tomato|+01.44|+00.99|+00.84)
		(is_near ?c)
		(location Tomato|+01.44|+00.99|+00.84 ?c)
		(not (holding Tomato|+01.44|+00.99|+00.84))
	)
	:effect (and
		(holding Tomato|+01.44|+00.99|+00.84)
		(not (holding Tomato|+01.44|+00.99|+00.84))
		(location_x Tomato|+01.44|+00.99|+00.84)
		(location_y Tomato|+01.44|+00.99|+00.84)
	)
)

(:action pickup_Bowl|-01.06|+01.49|+00.88
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Bowl|-01.06|+01.49|+00.88)
		(is_near ?c)
		(location Bowl|-01.06|+01.49|+00.88 ?c)
		(not (holding Bowl|-01.06|+01.49|+00.88))
	)
	:effect (and
		(holding Bowl|-01.06|+01.49|+00.88)
		(not (holding Bowl|-01.06|+01.49|+00.88))
		(location_x Bowl|-01.06|+01.49|+00.88)
		(location_y Bowl|-01.06|+01.49|+00.88)
	)
)

(:action pickup_Pot|-00.82|+00.93|+00.82
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Pot|-00.82|+00.93|+00.82)
		(is_near ?c)
		(location Pot|-00.82|+00.93|+00.82 ?c)
		(not (holding Pot|-00.82|+00.93|+00.82))
	)
	:effect (and
		(holding Pot|-00.82|+00.93|+00.82)
		(not (holding Pot|-00.82|+00.93|+00.82))
		(location_x Pot|-00.82|+00.93|+00.82)
		(location_y Pot|-00.82|+00.93|+00.82)
	)
)

(:action pickup_Spatula|+01.34|+00.93|+02.40
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Spatula|+01.34|+00.93|+02.40)
		(is_near ?c)
		(location Spatula|+01.34|+00.93|+02.40 ?c)
		(not (holding Spatula|+01.34|+00.93|+02.40))
	)
	:effect (and
		(holding Spatula|+01.34|+00.93|+02.40)
		(not (holding Spatula|+01.34|+00.93|+02.40))
		(location_x Spatula|+01.34|+00.93|+02.40)
		(location_y Spatula|+01.34|+00.93|+02.40)
	)
)

(:action pickup_Knife|+01.36|+00.74|+00.87
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Knife|+01.36|+00.74|+00.87)
		(is_near ?c)
		(location Knife|+01.36|+00.74|+00.87 ?c)
		(not (holding Knife|+01.36|+00.74|+00.87))
	)
	:effect (and
		(holding Knife|+01.36|+00.74|+00.87)
		(not (holding Knife|+01.36|+00.74|+00.87))
		(location_x Knife|+01.36|+00.74|+00.87)
		(location_y Knife|+01.36|+00.74|+00.87)
	)
)

(:action pickup_SaltShaker|+01.67|+00.93|+02.05
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable SaltShaker|+01.67|+00.93|+02.05)
		(is_near ?c)
		(location SaltShaker|+01.67|+00.93|+02.05 ?c)
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
	)
	:effect (and
		(holding SaltShaker|+01.67|+00.93|+02.05)
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
		(location_x SaltShaker|+01.67|+00.93|+02.05)
		(location_y SaltShaker|+01.67|+00.93|+02.05)
	)
)

(:action pickup_Apple|+01.41|+00.98|+02.13
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Apple|+01.41|+00.98|+02.13)
		(is_near ?c)
		(location Apple|+01.41|+00.98|+02.13 ?c)
		(not (holding Apple|+01.41|+00.98|+02.13))
	)
	:effect (and
		(holding Apple|+01.41|+00.98|+02.13)
		(not (holding Apple|+01.41|+00.98|+02.13))
		(location_x Apple|+01.41|+00.98|+02.13)
		(location_y Apple|+01.41|+00.98|+02.13)
	)
)

(:action pickup_PepperShaker|+01.60|+00.93|+02.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable PepperShaker|+01.60|+00.93|+02.16)
		(is_near ?c)
		(location PepperShaker|+01.60|+00.93|+02.16 ?c)
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
	)
	:effect (and
		(holding PepperShaker|+01.60|+00.93|+02.16)
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
		(location_x PepperShaker|+01.60|+00.93|+02.16)
		(location_y PepperShaker|+01.60|+00.93|+02.16)
	)
)

(:action pickup_ButterKnife|+01.37|+00.74|+02.24
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable ButterKnife|+01.37|+00.74|+02.24)
		(is_near ?c)
		(location ButterKnife|+01.37|+00.74|+02.24 ?c)
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
	)
	:effect (and
		(holding ButterKnife|+01.37|+00.74|+02.24)
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
		(location_x ButterKnife|+01.37|+00.74|+02.24)
		(location_y ButterKnife|+01.37|+00.74|+02.24)
	)
)

(:action pickup_Potato|-00.76|+00.96|+02.36
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Potato|-00.76|+00.96|+02.36)
		(is_near ?c)
		(location Potato|-00.76|+00.96|+02.36 ?c)
		(not (holding Potato|-00.76|+00.96|+02.36))
	)
	:effect (and
		(holding Potato|-00.76|+00.96|+02.36)
		(not (holding Potato|-00.76|+00.96|+02.36))
		(location_x Potato|-00.76|+00.96|+02.36)
		(location_y Potato|-00.76|+00.96|+02.36)
	)
)

(:action pickup_Plate|+01.38|+01.06|+00.01
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Plate|+01.38|+01.06|+00.01)
		(is_near ?c)
		(location Plate|+01.38|+01.06|+00.01 ?c)
		(not (holding Plate|+01.38|+01.06|+00.01))
	)
	:effect (and
		(holding Plate|+01.38|+01.06|+00.01)
		(not (holding Plate|+01.38|+01.06|+00.01))
		(location_x Plate|+01.38|+01.06|+00.01)
		(location_y Plate|+01.38|+01.06|+00.01)
	)
)

(:action pickup_DishSponge|+01.51|+00.84|+01.37
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable DishSponge|+01.51|+00.84|+01.37)
		(is_near ?c)
		(location DishSponge|+01.51|+00.84|+01.37 ?c)
		(not (holding DishSponge|+01.51|+00.84|+01.37))
	)
	:effect (and
		(holding DishSponge|+01.51|+00.84|+01.37)
		(not (holding DishSponge|+01.51|+00.84|+01.37))
		(location_x DishSponge|+01.51|+00.84|+01.37)
		(location_y DishSponge|+01.51|+00.84|+01.37)
	)
)

(:action pickup_Egg|+01.32|+00.96|+01.75
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Egg|+01.32|+00.96|+01.75)
		(is_near ?c)
		(location Egg|+01.32|+00.96|+01.75 ?c)
		(not (holding Egg|+01.32|+00.96|+01.75))
	)
	:effect (and
		(holding Egg|+01.32|+00.96|+01.75)
		(not (holding Egg|+01.32|+00.96|+01.75))
		(location_x Egg|+01.32|+00.96|+01.75)
		(location_y Egg|+01.32|+00.96|+01.75)
	)
)

(:action pickup_Cup|+01.31|+00.93|+00.78
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Cup|+01.31|+00.93|+00.78)
		(is_near ?c)
		(location Cup|+01.31|+00.93|+00.78 ?c)
		(not (holding Cup|+01.31|+00.93|+00.78))
	)
	:effect (and
		(holding Cup|+01.31|+00.93|+00.78)
		(not (holding Cup|+01.31|+00.93|+00.78))
		(location_x Cup|+01.31|+00.93|+00.78)
		(location_y Cup|+01.31|+00.93|+00.78)
	)
)

(:action pickup_Pan|+01.38|+01.74|+00.39
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Pan|+01.38|+01.74|+00.39)
		(is_near ?c)
		(location Pan|+01.38|+01.74|+00.39 ?c)
		(not (holding Pan|+01.38|+01.74|+00.39))
	)
	:effect (and
		(holding Pan|+01.38|+01.74|+00.39)
		(not (holding Pan|+01.38|+01.74|+00.39))
		(location_x Pan|+01.38|+01.74|+00.39)
		(location_y Pan|+01.38|+01.74|+00.39)
	)
)

(:action pickup_Spoon|+01.41|+00.74|+02.43
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Spoon|+01.41|+00.74|+02.43)
		(is_near ?c)
		(location Spoon|+01.41|+00.74|+02.43 ?c)
		(not (holding Spoon|+01.41|+00.74|+02.43))
	)
	:effect (and
		(holding Spoon|+01.41|+00.74|+02.43)
		(not (holding Spoon|+01.41|+00.74|+02.43))
		(location_x Spoon|+01.41|+00.74|+02.43)
		(location_y Spoon|+01.41|+00.74|+02.43)
	)
)

(:action pickup_Mug|+01.46|+00.93|+01.09
	:parameters ( ?c - cell)
	:precondition (and
		(is_pickable Mug|+01.46|+00.93|+01.09)
		(is_near ?c)
		(location Mug|+01.46|+00.93|+01.09 ?c)
		(not (holding Mug|+01.46|+00.93|+01.09))
	)
	:effect (and
		(holding Mug|+01.46|+00.93|+01.09)
		(not (holding Mug|+01.46|+00.93|+01.09))
		(location_x Mug|+01.46|+00.93|+01.09)
		(location_y Mug|+01.46|+00.93|+01.09)
	)
)

(:action put_Lettuce|+01.46|+01.01|+01.68
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Lettuce|+01.46|+01.01|+01.68 c)
		(not (holding Lettuce|+01.46|+01.01|+01.68))
	)
	:effect (and
		(holding Lettuce|+01.46|+01.01|+01.68)
		(not (holding Lettuce|+01.46|+01.01|+01.68))
		(location_x Lettuce|+01.46|+01.01|+01.68)
		(location_y Lettuce|+01.46|+01.01|+01.68)
	)
)

(:action put_SoapBottle|+01.67|+00.93|+01.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location SoapBottle|+01.67|+00.93|+01.11 c)
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
	)
	:effect (and
		(holding SoapBottle|+01.67|+00.93|+01.11)
		(not (holding SoapBottle|+01.67|+00.93|+01.11))
		(location_x SoapBottle|+01.67|+00.93|+01.11)
		(location_y SoapBottle|+01.67|+00.93|+01.11)
	)
)

(:action put_Bread|-00.92|+00.99|+02.27
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Bread|-00.92|+00.99|+02.27 c)
		(not (holding Bread|-00.92|+00.99|+02.27))
	)
	:effect (and
		(holding Bread|-00.92|+00.99|+02.27)
		(not (holding Bread|-00.92|+00.99|+02.27))
		(location_x Bread|-00.92|+00.99|+02.27)
		(location_y Bread|-00.92|+00.99|+02.27)
	)
)

(:action put_Fork|+01.35|+00.74|+02.50
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Fork|+01.35|+00.74|+02.50 c)
		(not (holding Fork|+01.35|+00.74|+02.50))
	)
	:effect (and
		(holding Fork|+01.35|+00.74|+02.50)
		(not (holding Fork|+01.35|+00.74|+02.50))
		(location_x Fork|+01.35|+00.74|+02.50)
		(location_y Fork|+01.35|+00.74|+02.50)
	)
)

(:action put_Tomato|+01.44|+00.99|+00.84
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Tomato|+01.44|+00.99|+00.84 c)
		(not (holding Tomato|+01.44|+00.99|+00.84))
	)
	:effect (and
		(holding Tomato|+01.44|+00.99|+00.84)
		(not (holding Tomato|+01.44|+00.99|+00.84))
		(location_x Tomato|+01.44|+00.99|+00.84)
		(location_y Tomato|+01.44|+00.99|+00.84)
	)
)

(:action put_Bowl|-01.06|+01.49|+00.88
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Bowl|-01.06|+01.49|+00.88 c)
		(not (holding Bowl|-01.06|+01.49|+00.88))
	)
	:effect (and
		(holding Bowl|-01.06|+01.49|+00.88)
		(not (holding Bowl|-01.06|+01.49|+00.88))
		(location_x Bowl|-01.06|+01.49|+00.88)
		(location_y Bowl|-01.06|+01.49|+00.88)
	)
)

(:action put_Pot|-00.82|+00.93|+00.82
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Pot|-00.82|+00.93|+00.82 c)
		(not (holding Pot|-00.82|+00.93|+00.82))
	)
	:effect (and
		(holding Pot|-00.82|+00.93|+00.82)
		(not (holding Pot|-00.82|+00.93|+00.82))
		(location_x Pot|-00.82|+00.93|+00.82)
		(location_y Pot|-00.82|+00.93|+00.82)
	)
)

(:action put_Spatula|+01.34|+00.93|+02.40
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Spatula|+01.34|+00.93|+02.40 c)
		(not (holding Spatula|+01.34|+00.93|+02.40))
	)
	:effect (and
		(holding Spatula|+01.34|+00.93|+02.40)
		(not (holding Spatula|+01.34|+00.93|+02.40))
		(location_x Spatula|+01.34|+00.93|+02.40)
		(location_y Spatula|+01.34|+00.93|+02.40)
	)
)

(:action put_Knife|+01.36|+00.74|+00.87
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Knife|+01.36|+00.74|+00.87 c)
		(not (holding Knife|+01.36|+00.74|+00.87))
	)
	:effect (and
		(holding Knife|+01.36|+00.74|+00.87)
		(not (holding Knife|+01.36|+00.74|+00.87))
		(location_x Knife|+01.36|+00.74|+00.87)
		(location_y Knife|+01.36|+00.74|+00.87)
	)
)

(:action put_SaltShaker|+01.67|+00.93|+02.05
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location SaltShaker|+01.67|+00.93|+02.05 c)
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
	)
	:effect (and
		(holding SaltShaker|+01.67|+00.93|+02.05)
		(not (holding SaltShaker|+01.67|+00.93|+02.05))
		(location_x SaltShaker|+01.67|+00.93|+02.05)
		(location_y SaltShaker|+01.67|+00.93|+02.05)
	)
)

(:action put_Apple|+01.41|+00.98|+02.13
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Apple|+01.41|+00.98|+02.13 c)
		(not (holding Apple|+01.41|+00.98|+02.13))
	)
	:effect (and
		(holding Apple|+01.41|+00.98|+02.13)
		(not (holding Apple|+01.41|+00.98|+02.13))
		(location_x Apple|+01.41|+00.98|+02.13)
		(location_y Apple|+01.41|+00.98|+02.13)
	)
)

(:action put_PepperShaker|+01.60|+00.93|+02.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location PepperShaker|+01.60|+00.93|+02.16 c)
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
	)
	:effect (and
		(holding PepperShaker|+01.60|+00.93|+02.16)
		(not (holding PepperShaker|+01.60|+00.93|+02.16))
		(location_x PepperShaker|+01.60|+00.93|+02.16)
		(location_y PepperShaker|+01.60|+00.93|+02.16)
	)
)

(:action put_ButterKnife|+01.37|+00.74|+02.24
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location ButterKnife|+01.37|+00.74|+02.24 c)
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
	)
	:effect (and
		(holding ButterKnife|+01.37|+00.74|+02.24)
		(not (holding ButterKnife|+01.37|+00.74|+02.24))
		(location_x ButterKnife|+01.37|+00.74|+02.24)
		(location_y ButterKnife|+01.37|+00.74|+02.24)
	)
)

(:action put_Potato|-00.76|+00.96|+02.36
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Potato|-00.76|+00.96|+02.36 c)
		(not (holding Potato|-00.76|+00.96|+02.36))
	)
	:effect (and
		(holding Potato|-00.76|+00.96|+02.36)
		(not (holding Potato|-00.76|+00.96|+02.36))
		(location_x Potato|-00.76|+00.96|+02.36)
		(location_y Potato|-00.76|+00.96|+02.36)
	)
)

(:action put_Plate|+01.38|+01.06|+00.01
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Plate|+01.38|+01.06|+00.01 c)
		(not (holding Plate|+01.38|+01.06|+00.01))
	)
	:effect (and
		(holding Plate|+01.38|+01.06|+00.01)
		(not (holding Plate|+01.38|+01.06|+00.01))
		(location_x Plate|+01.38|+01.06|+00.01)
		(location_y Plate|+01.38|+01.06|+00.01)
	)
)

(:action put_DishSponge|+01.51|+00.84|+01.37
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location DishSponge|+01.51|+00.84|+01.37 c)
		(not (holding DishSponge|+01.51|+00.84|+01.37))
	)
	:effect (and
		(holding DishSponge|+01.51|+00.84|+01.37)
		(not (holding DishSponge|+01.51|+00.84|+01.37))
		(location_x DishSponge|+01.51|+00.84|+01.37)
		(location_y DishSponge|+01.51|+00.84|+01.37)
	)
)

(:action put_Egg|+01.32|+00.96|+01.75
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Egg|+01.32|+00.96|+01.75 c)
		(not (holding Egg|+01.32|+00.96|+01.75))
	)
	:effect (and
		(holding Egg|+01.32|+00.96|+01.75)
		(not (holding Egg|+01.32|+00.96|+01.75))
		(location_x Egg|+01.32|+00.96|+01.75)
		(location_y Egg|+01.32|+00.96|+01.75)
	)
)

(:action put_Cup|+01.31|+00.93|+00.78
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Cup|+01.31|+00.93|+00.78 c)
		(not (holding Cup|+01.31|+00.93|+00.78))
	)
	:effect (and
		(holding Cup|+01.31|+00.93|+00.78)
		(not (holding Cup|+01.31|+00.93|+00.78))
		(location_x Cup|+01.31|+00.93|+00.78)
		(location_y Cup|+01.31|+00.93|+00.78)
	)
)

(:action put_Pan|+01.38|+01.74|+00.39
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Pan|+01.38|+01.74|+00.39 c)
		(not (holding Pan|+01.38|+01.74|+00.39))
	)
	:effect (and
		(holding Pan|+01.38|+01.74|+00.39)
		(not (holding Pan|+01.38|+01.74|+00.39))
		(location_x Pan|+01.38|+01.74|+00.39)
		(location_y Pan|+01.38|+01.74|+00.39)
	)
)

(:action put_Spoon|+01.41|+00.74|+02.43
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Spoon|+01.41|+00.74|+02.43 c)
		(not (holding Spoon|+01.41|+00.74|+02.43))
	)
	:effect (and
		(holding Spoon|+01.41|+00.74|+02.43)
		(not (holding Spoon|+01.41|+00.74|+02.43))
		(location_x Spoon|+01.41|+00.74|+02.43)
		(location_y Spoon|+01.41|+00.74|+02.43)
	)
)

(:action put_Mug|+01.46|+00.93|+01.09
	:parameters ( ?c - cell)
	:precondition (and
		(is_near c)
		(location Mug|+01.46|+00.93|+01.09 c)
		(not (holding Mug|+01.46|+00.93|+01.09))
	)
	:effect (and
		(holding Mug|+01.46|+00.93|+01.09)
		(not (holding Mug|+01.46|+00.93|+01.09))
		(location_x Mug|+01.46|+00.93|+01.09)
		(location_y Mug|+01.46|+00.93|+01.09)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+02.39
	:parameters None
	:precondition (and
		(is_near c)
		(location p CounterTop|-00.97|+00.97|+02.39 c)
		(not (holding p CounterTop|-00.97|+00.97|+02.39))
		(opened CounterTop|-00.97|+00.97|+02.39)
	)
	:effect (and
		(holding p CounterTop|-00.97|+00.97|+02.39)
		(not (holding p CounterTop|-00.97|+00.97|+02.39))
		(location_x p CounterTop|-00.97|+00.97|+02.39)
		(location_y p CounterTop|-00.97|+00.97|+02.39)
		(in p CounterTop|-00.97|+00.97|+02.39)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+02.38
	:parameters None
	:precondition (and
		(is_near c)
		(location p Drawer|-00.78|+00.77|+02.38 c)
		(not (holding p Drawer|-00.78|+00.77|+02.38))
		(opened Drawer|-00.78|+00.77|+02.38)
	)
	:effect (and
		(holding p Drawer|-00.78|+00.77|+02.38)
		(not (holding p Drawer|-00.78|+00.77|+02.38))
		(location_x p Drawer|-00.78|+00.77|+02.38)
		(location_y p Drawer|-00.78|+00.77|+02.38)
		(in p Drawer|-00.78|+00.77|+02.38)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.47
	:parameters None
	:precondition (and
		(is_near c)
		(location p StoveBurner|-01.11|+00.92|+01.47 c)
		(not (holding p StoveBurner|-01.11|+00.92|+01.47))
		(opened StoveBurner|-01.11|+00.92|+01.47)
	)
	:effect (and
		(holding p StoveBurner|-01.11|+00.92|+01.47)
		(not (holding p StoveBurner|-01.11|+00.92|+01.47))
		(location_x p StoveBurner|-01.11|+00.92|+01.47)
		(location_y p StoveBurner|-01.11|+00.92|+01.47)
		(in p StoveBurner|-01.11|+00.92|+01.47)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+02.39
	:parameters None
	:precondition (and
		(is_near c)
		(location p Drawer|+01.37|+00.77|+02.39 c)
		(not (holding p Drawer|+01.37|+00.77|+02.39))
		(opened Drawer|+01.37|+00.77|+02.39)
	)
	:effect (and
		(holding p Drawer|+01.37|+00.77|+02.39)
		(not (holding p Drawer|+01.37|+00.77|+02.39))
		(location_x p Drawer|+01.37|+00.77|+02.39)
		(location_y p Drawer|+01.37|+00.77|+02.39)
		(in p Drawer|+01.37|+00.77|+02.39)
	)
)

(:action put_inside_Stool|-00.75|+00.01|+03.12
	:parameters None
	:precondition (and
		(is_near c)
		(location p Stool|-00.75|+00.01|+03.12 c)
		(not (holding p Stool|-00.75|+00.01|+03.12))
		(opened Stool|-00.75|+00.01|+03.12)
	)
	:effect (and
		(holding p Stool|-00.75|+00.01|+03.12)
		(not (holding p Stool|-00.75|+00.01|+03.12))
		(location_x p Stool|-00.75|+00.01|+03.12)
		(location_y p Stool|-00.75|+00.01|+03.12)
		(in p Stool|-00.75|+00.01|+03.12)
	)
)

(:action put_inside_CounterTop|+01.51|+00.97|+02.31
	:parameters None
	:precondition (and
		(is_near c)
		(location p CounterTop|+01.51|+00.97|+02.31 c)
		(not (holding p CounterTop|+01.51|+00.97|+02.31))
		(opened CounterTop|+01.51|+00.97|+02.31)
	)
	:effect (and
		(holding p CounterTop|+01.51|+00.97|+02.31)
		(not (holding p CounterTop|+01.51|+00.97|+02.31))
		(location_x p CounterTop|+01.51|+00.97|+02.31)
		(location_y p CounterTop|+01.51|+00.97|+02.31)
		(in p CounterTop|+01.51|+00.97|+02.31)
	)
)

(:action put_inside_Cabinet|+01.22|+01.39|+00.59
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.22|+01.39|+00.59 c)
		(not (holding p Cabinet|+01.22|+01.39|+00.59))
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
	:effect (and
		(holding p Cabinet|+01.22|+01.39|+00.59)
		(not (holding p Cabinet|+01.22|+01.39|+00.59))
		(location_x p Cabinet|+01.22|+01.39|+00.59)
		(location_y p Cabinet|+01.22|+01.39|+00.59)
		(in p Cabinet|+01.22|+01.39|+00.59)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.16
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.50|+02.11|+01.16 c)
		(not (holding p Cabinet|+01.50|+02.11|+01.16))
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
	:effect (and
		(holding p Cabinet|+01.50|+02.11|+01.16)
		(not (holding p Cabinet|+01.50|+02.11|+01.16))
		(location_x p Cabinet|+01.50|+02.11|+01.16)
		(location_y p Cabinet|+01.50|+02.11|+01.16)
		(in p Cabinet|+01.50|+02.11|+01.16)
	)
)

(:action put_inside_Cabinet|+01.22|+02.01|+00.59
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.22|+02.01|+00.59 c)
		(not (holding p Cabinet|+01.22|+02.01|+00.59))
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
	:effect (and
		(holding p Cabinet|+01.22|+02.01|+00.59)
		(not (holding p Cabinet|+01.22|+02.01|+00.59))
		(location_x p Cabinet|+01.22|+02.01|+00.59)
		(location_y p Cabinet|+01.22|+02.01|+00.59)
		(in p Cabinet|+01.22|+02.01|+00.59)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+02.11
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.22|+00.39|+02.11 c)
		(not (holding p Cabinet|+01.22|+00.39|+02.11))
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
	:effect (and
		(holding p Cabinet|+01.22|+00.39|+02.11)
		(not (holding p Cabinet|+01.22|+00.39|+02.11))
		(location_x p Cabinet|+01.22|+00.39|+02.11)
		(location_y p Cabinet|+01.22|+00.39|+02.11)
		(in p Cabinet|+01.22|+00.39|+02.11)
	)
)

(:action put_inside_Cabinet|+01.22|+00.55|+00.59
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.22|+00.55|+00.59 c)
		(not (holding p Cabinet|+01.22|+00.55|+00.59))
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
	:effect (and
		(holding p Cabinet|+01.22|+00.55|+00.59)
		(not (holding p Cabinet|+01.22|+00.55|+00.59))
		(location_x p Cabinet|+01.22|+00.55|+00.59)
		(location_y p Cabinet|+01.22|+00.55|+00.59)
		(in p Cabinet|+01.22|+00.55|+00.59)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.16
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+02.11|+01.16 c)
		(not (holding p Cabinet|-00.91|+02.11|+01.16))
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
	:effect (and
		(holding p Cabinet|-00.91|+02.11|+01.16)
		(not (holding p Cabinet|-00.91|+02.11|+01.16))
		(location_x p Cabinet|-00.91|+02.11|+01.16)
		(location_y p Cabinet|-00.91|+02.11|+01.16)
		(in p Cabinet|-00.91|+02.11|+01.16)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+00.63
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.63|+00.39|+00.63 c)
		(not (holding p Cabinet|-00.63|+00.39|+00.63))
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
	:effect (and
		(holding p Cabinet|-00.63|+00.39|+00.63)
		(not (holding p Cabinet|-00.63|+00.39|+00.63))
		(location_x p Cabinet|-00.63|+00.39|+00.63)
		(location_y p Cabinet|-00.63|+00.39|+00.63)
		(in p Cabinet|-00.63|+00.39|+00.63)
	)
)

(:action put_inside_Cabinet|-00.91|+02.05|-00.33
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+02.05|-00.33 c)
		(not (holding p Cabinet|-00.91|+02.05|-00.33))
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
	:effect (and
		(holding p Cabinet|-00.91|+02.05|-00.33)
		(not (holding p Cabinet|-00.91|+02.05|-00.33))
		(location_x p Cabinet|-00.91|+02.05|-00.33)
		(location_y p Cabinet|-00.91|+02.05|-00.33)
		(in p Cabinet|-00.91|+02.05|-00.33)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+00.58
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+02.11|+00.58 c)
		(not (holding p Cabinet|-00.91|+02.11|+00.58))
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
	:effect (and
		(holding p Cabinet|-00.91|+02.11|+00.58)
		(not (holding p Cabinet|-00.91|+02.11|+00.58))
		(location_x p Cabinet|-00.91|+02.11|+00.58)
		(location_y p Cabinet|-00.91|+02.11|+00.58)
		(in p Cabinet|-00.91|+02.11|+00.58)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+02.08
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+02.11|+02.08 c)
		(not (holding p Cabinet|-00.91|+02.11|+02.08))
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
	:effect (and
		(holding p Cabinet|-00.91|+02.11|+02.08)
		(not (holding p Cabinet|-00.91|+02.11|+02.08))
		(location_x p Cabinet|-00.91|+02.11|+02.08)
		(location_y p Cabinet|-00.91|+02.11|+02.08)
		(in p Cabinet|-00.91|+02.11|+02.08)
	)
)

(:action put_inside_Cabinet|-00.91|+02.11|+01.21
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+02.11|+01.21 c)
		(not (holding p Cabinet|-00.91|+02.11|+01.21))
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
	:effect (and
		(holding p Cabinet|-00.91|+02.11|+01.21)
		(not (holding p Cabinet|-00.91|+02.11|+01.21))
		(location_x p Cabinet|-00.91|+02.11|+01.21)
		(location_y p Cabinet|-00.91|+02.11|+01.21)
		(in p Cabinet|-00.91|+02.11|+01.21)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+02.08
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.50|+02.11|+02.08 c)
		(not (holding p Cabinet|+01.50|+02.11|+02.08))
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
	:effect (and
		(holding p Cabinet|+01.50|+02.11|+02.08)
		(not (holding p Cabinet|+01.50|+02.11|+02.08))
		(location_x p Cabinet|+01.50|+02.11|+02.08)
		(location_y p Cabinet|+01.50|+02.11|+02.08)
		(in p Cabinet|+01.50|+02.11|+02.08)
	)
)

(:action put_inside_Cabinet|+01.50|+02.11|+01.21
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.50|+02.11|+01.21 c)
		(not (holding p Cabinet|+01.50|+02.11|+01.21))
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
	:effect (and
		(holding p Cabinet|+01.50|+02.11|+01.21)
		(not (holding p Cabinet|+01.50|+02.11|+01.21))
		(location_x p Cabinet|+01.50|+02.11|+01.21)
		(location_y p Cabinet|+01.50|+02.11|+01.21)
		(in p Cabinet|+01.50|+02.11|+01.21)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.69
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.50|+01.81|+02.69 c)
		(not (holding p Cabinet|+01.50|+01.81|+02.69))
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
	:effect (and
		(holding p Cabinet|+01.50|+01.81|+02.69)
		(not (holding p Cabinet|+01.50|+01.81|+02.69))
		(location_x p Cabinet|+01.50|+01.81|+02.69)
		(location_y p Cabinet|+01.50|+01.81|+02.69)
		(in p Cabinet|+01.50|+01.81|+02.69)
	)
)

(:action put_inside_Cabinet|+01.50|+01.81|+02.10
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.50|+01.81|+02.10 c)
		(not (holding p Cabinet|+01.50|+01.81|+02.10))
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
	:effect (and
		(holding p Cabinet|+01.50|+01.81|+02.10)
		(not (holding p Cabinet|+01.50|+01.81|+02.10))
		(location_x p Cabinet|+01.50|+01.81|+02.10)
		(location_y p Cabinet|+01.50|+01.81|+02.10)
		(in p Cabinet|+01.50|+01.81|+02.10)
	)
)

(:action put_inside_Cabinet|-00.63|+00.39|+02.11
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.63|+00.39|+02.11 c)
		(not (holding p Cabinet|-00.63|+00.39|+02.11))
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
	:effect (and
		(holding p Cabinet|-00.63|+00.39|+02.11)
		(not (holding p Cabinet|-00.63|+00.39|+02.11))
		(location_x p Cabinet|-00.63|+00.39|+02.11)
		(location_y p Cabinet|-00.63|+00.39|+02.11)
		(in p Cabinet|-00.63|+00.39|+02.11)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.70
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+01.81|+02.70 c)
		(not (holding p Cabinet|-00.91|+01.81|+02.70))
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
	:effect (and
		(holding p Cabinet|-00.91|+01.81|+02.70)
		(not (holding p Cabinet|-00.91|+01.81|+02.70))
		(location_x p Cabinet|-00.91|+01.81|+02.70)
		(location_y p Cabinet|-00.91|+01.81|+02.70)
		(in p Cabinet|-00.91|+01.81|+02.70)
	)
)

(:action put_inside_Drawer|-00.78|+00.77|+00.92
	:parameters None
	:precondition (and
		(is_near c)
		(location p Drawer|-00.78|+00.77|+00.92 c)
		(not (holding p Drawer|-00.78|+00.77|+00.92))
		(opened Drawer|-00.78|+00.77|+00.92)
	)
	:effect (and
		(holding p Drawer|-00.78|+00.77|+00.92)
		(not (holding p Drawer|-00.78|+00.77|+00.92))
		(location_x p Drawer|-00.78|+00.77|+00.92)
		(location_y p Drawer|-00.78|+00.77|+00.92)
		(in p Drawer|-00.78|+00.77|+00.92)
	)
)

(:action put_inside_StoveBurner|-01.11|+00.92|+01.87
	:parameters None
	:precondition (and
		(is_near c)
		(location p StoveBurner|-01.11|+00.92|+01.87 c)
		(not (holding p StoveBurner|-01.11|+00.92|+01.87))
		(opened StoveBurner|-01.11|+00.92|+01.87)
	)
	:effect (and
		(holding p StoveBurner|-01.11|+00.92|+01.87)
		(not (holding p StoveBurner|-01.11|+00.92|+01.87))
		(location_x p StoveBurner|-01.11|+00.92|+01.87)
		(location_y p StoveBurner|-01.11|+00.92|+01.87)
		(in p StoveBurner|-01.11|+00.92|+01.87)
	)
)

(:action put_inside_CounterTop|-00.97|+00.97|+00.92
	:parameters None
	:precondition (and
		(is_near c)
		(location p CounterTop|-00.97|+00.97|+00.92 c)
		(not (holding p CounterTop|-00.97|+00.97|+00.92))
		(opened CounterTop|-00.97|+00.97|+00.92)
	)
	:effect (and
		(holding p CounterTop|-00.97|+00.97|+00.92)
		(not (holding p CounterTop|-00.97|+00.97|+00.92))
		(location_x p CounterTop|-00.97|+00.97|+00.92)
		(location_y p CounterTop|-00.97|+00.97|+00.92)
		(in p CounterTop|-00.97|+00.97|+00.92)
	)
)

(:action put_inside_Cabinet|+01.22|+00.39|+00.63
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|+01.22|+00.39|+00.63 c)
		(not (holding p Cabinet|+01.22|+00.39|+00.63))
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
	:effect (and
		(holding p Cabinet|+01.22|+00.39|+00.63)
		(not (holding p Cabinet|+01.22|+00.39|+00.63))
		(location_x p Cabinet|+01.22|+00.39|+00.63)
		(location_y p Cabinet|+01.22|+00.39|+00.63)
		(in p Cabinet|+01.22|+00.39|+00.63)
	)
)

(:action put_inside_Floor|+01.23|+00.00|-00.84
	:parameters None
	:precondition (and
		(is_near c)
		(location p Floor|+01.23|+00.00|-00.84 c)
		(not (holding p Floor|+01.23|+00.00|-00.84))
		(opened Floor|+01.23|+00.00|-00.84)
	)
	:effect (and
		(holding p Floor|+01.23|+00.00|-00.84)
		(not (holding p Floor|+01.23|+00.00|-00.84))
		(location_x p Floor|+01.23|+00.00|-00.84)
		(location_y p Floor|+01.23|+00.00|-00.84)
		(in p Floor|+01.23|+00.00|-00.84)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64
	:parameters None
	:precondition (and
		(is_near c)
		(location p Sink|+01.54|+00.87|+01.64 c)
		(not (holding p Sink|+01.54|+00.87|+01.64))
		(opened Sink|+01.54|+00.87|+01.64)
	)
	:effect (and
		(holding p Sink|+01.54|+00.87|+01.64)
		(not (holding p Sink|+01.54|+00.87|+01.64))
		(location_x p Sink|+01.54|+00.87|+01.64)
		(location_y p Sink|+01.54|+00.87|+01.64)
		(in p Sink|+01.54|+00.87|+01.64)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.87
	:parameters None
	:precondition (and
		(is_near c)
		(location p StoveBurner|-00.83|+00.92|+01.87 c)
		(not (holding p StoveBurner|-00.83|+00.92|+01.87))
		(opened StoveBurner|-00.83|+00.92|+01.87)
	)
	:effect (and
		(holding p StoveBurner|-00.83|+00.92|+01.87)
		(not (holding p StoveBurner|-00.83|+00.92|+01.87))
		(location_x p StoveBurner|-00.83|+00.92|+01.87)
		(location_y p StoveBurner|-00.83|+00.92|+01.87)
		(in p StoveBurner|-00.83|+00.92|+01.87)
	)
)

(:action put_inside_StoveBurner|-00.83|+00.92|+01.47
	:parameters None
	:precondition (and
		(is_near c)
		(location p StoveBurner|-00.83|+00.92|+01.47 c)
		(not (holding p StoveBurner|-00.83|+00.92|+01.47))
		(opened StoveBurner|-00.83|+00.92|+01.47)
	)
	:effect (and
		(holding p StoveBurner|-00.83|+00.92|+01.47)
		(not (holding p StoveBurner|-00.83|+00.92|+01.47))
		(location_x p StoveBurner|-00.83|+00.92|+01.47)
		(location_y p StoveBurner|-00.83|+00.92|+01.47)
		(in p StoveBurner|-00.83|+00.92|+01.47)
	)
)

(:action put_inside_Drawer|+01.37|+00.77|+00.92
	:parameters None
	:precondition (and
		(is_near c)
		(location p Drawer|+01.37|+00.77|+00.92 c)
		(not (holding p Drawer|+01.37|+00.77|+00.92))
		(opened Drawer|+01.37|+00.77|+00.92)
	)
	:effect (and
		(holding p Drawer|+01.37|+00.77|+00.92)
		(not (holding p Drawer|+01.37|+00.77|+00.92))
		(location_x p Drawer|+01.37|+00.77|+00.92)
		(location_y p Drawer|+01.37|+00.77|+00.92)
		(in p Drawer|+01.37|+00.77|+00.92)
	)
)

(:action put_inside_Cabinet|-00.91|+01.81|+02.11
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cabinet|-00.91|+01.81|+02.11 c)
		(not (holding p Cabinet|-00.91|+01.81|+02.11))
		(opened Cabinet|-00.91|+01.81|+02.11)
	)
	:effect (and
		(holding p Cabinet|-00.91|+01.81|+02.11)
		(not (holding p Cabinet|-00.91|+01.81|+02.11))
		(location_x p Cabinet|-00.91|+01.81|+02.11)
		(location_y p Cabinet|-00.91|+01.81|+02.11)
		(in p Cabinet|-00.91|+01.81|+02.11)
	)
)

(:action put_inside_Fridge|-01.00|+00.00|+00.12
	:parameters None
	:precondition (and
		(is_near c)
		(location p Fridge|-01.00|+00.00|+00.12 c)
		(not (holding p Fridge|-01.00|+00.00|+00.12))
		(opened Fridge|-01.00|+00.00|+00.12)
	)
	:effect (and
		(holding p Fridge|-01.00|+00.00|+00.12)
		(not (holding p Fridge|-01.00|+00.00|+00.12))
		(location_x p Fridge|-01.00|+00.00|+00.12)
		(location_y p Fridge|-01.00|+00.00|+00.12)
		(in p Fridge|-01.00|+00.00|+00.12)
	)
)

(:action put_inside_Toaster|-01.00|+00.93|+02.56
	:parameters None
	:precondition (and
		(is_near c)
		(location p Toaster|-01.00|+00.93|+02.56 c)
		(not (holding p Toaster|-01.00|+00.93|+02.56))
		(opened Toaster|-01.00|+00.93|+02.56)
	)
	:effect (and
		(holding p Toaster|-01.00|+00.93|+02.56)
		(not (holding p Toaster|-01.00|+00.93|+02.56))
		(location_x p Toaster|-01.00|+00.93|+02.56)
		(location_y p Toaster|-01.00|+00.93|+02.56)
		(in p Toaster|-01.00|+00.93|+02.56)
	)
)

(:action put_inside_GarbageCan|+01.45|-00.03|+02.91
	:parameters None
	:precondition (and
		(is_near c)
		(location p GarbageCan|+01.45|-00.03|+02.91 c)
		(not (holding p GarbageCan|+01.45|-00.03|+02.91))
		(opened GarbageCan|+01.45|-00.03|+02.91)
	)
	:effect (and
		(holding p GarbageCan|+01.45|-00.03|+02.91)
		(not (holding p GarbageCan|+01.45|-00.03|+02.91))
		(location_x p GarbageCan|+01.45|-00.03|+02.91)
		(location_y p GarbageCan|+01.45|-00.03|+02.91)
		(in p GarbageCan|+01.45|-00.03|+02.91)
	)
)

(:action put_inside_Microwave|+01.63|+01.48|+01.65
	:parameters None
	:precondition (and
		(is_near c)
		(location p Microwave|+01.63|+01.48|+01.65 c)
		(not (holding p Microwave|+01.63|+01.48|+01.65))
		(opened Microwave|+01.63|+01.48|+01.65)
	)
	:effect (and
		(holding p Microwave|+01.63|+01.48|+01.65)
		(not (holding p Microwave|+01.63|+01.48|+01.65))
		(location_x p Microwave|+01.63|+01.48|+01.65)
		(location_y p Microwave|+01.63|+01.48|+01.65)
		(in p Microwave|+01.63|+01.48|+01.65)
	)
)

(:action put_inside_Bowl|-01.06|+01.49|+00.88
	:parameters None
	:precondition (and
		(is_near c)
		(location p Bowl|-01.06|+01.49|+00.88 c)
		(not (holding p Bowl|-01.06|+01.49|+00.88))
		(opened Bowl|-01.06|+01.49|+00.88)
	)
	:effect (and
		(holding p Bowl|-01.06|+01.49|+00.88)
		(not (holding p Bowl|-01.06|+01.49|+00.88))
		(location_x p Bowl|-01.06|+01.49|+00.88)
		(location_y p Bowl|-01.06|+01.49|+00.88)
		(in p Bowl|-01.06|+01.49|+00.88)
	)
)

(:action put_inside_Pot|-00.82|+00.93|+00.82
	:parameters None
	:precondition (and
		(is_near c)
		(location p Pot|-00.82|+00.93|+00.82 c)
		(not (holding p Pot|-00.82|+00.93|+00.82))
		(opened Pot|-00.82|+00.93|+00.82)
	)
	:effect (and
		(holding p Pot|-00.82|+00.93|+00.82)
		(not (holding p Pot|-00.82|+00.93|+00.82))
		(location_x p Pot|-00.82|+00.93|+00.82)
		(location_y p Pot|-00.82|+00.93|+00.82)
		(in p Pot|-00.82|+00.93|+00.82)
	)
)

(:action put_inside_CoffeeMachine|+01.69|+00.93|+02.45
	:parameters None
	:precondition (and
		(is_near c)
		(location p CoffeeMachine|+01.69|+00.93|+02.45 c)
		(not (holding p CoffeeMachine|+01.69|+00.93|+02.45))
		(opened CoffeeMachine|+01.69|+00.93|+02.45)
	)
	:effect (and
		(holding p CoffeeMachine|+01.69|+00.93|+02.45)
		(not (holding p CoffeeMachine|+01.69|+00.93|+02.45))
		(location_x p CoffeeMachine|+01.69|+00.93|+02.45)
		(location_y p CoffeeMachine|+01.69|+00.93|+02.45)
		(in p CoffeeMachine|+01.69|+00.93|+02.45)
	)
)

(:action put_inside_Sink|+01.54|+00.87|+01.64|SinkBasin
	:parameters None
	:precondition (and
		(is_near c)
		(location p Sink|+01.54|+00.87|+01.64|SinkBasin c)
		(not (holding p Sink|+01.54|+00.87|+01.64|SinkBasin))
		(opened Sink|+01.54|+00.87|+01.64|SinkBasin)
	)
	:effect (and
		(holding p Sink|+01.54|+00.87|+01.64|SinkBasin)
		(not (holding p Sink|+01.54|+00.87|+01.64|SinkBasin))
		(location_x p Sink|+01.54|+00.87|+01.64|SinkBasin)
		(location_y p Sink|+01.54|+00.87|+01.64|SinkBasin)
		(in p Sink|+01.54|+00.87|+01.64|SinkBasin)
	)
)

(:action put_inside_Plate|+01.38|+01.06|+00.01
	:parameters None
	:precondition (and
		(is_near c)
		(location p Plate|+01.38|+01.06|+00.01 c)
		(not (holding p Plate|+01.38|+01.06|+00.01))
		(opened Plate|+01.38|+01.06|+00.01)
	)
	:effect (and
		(holding p Plate|+01.38|+01.06|+00.01)
		(not (holding p Plate|+01.38|+01.06|+00.01))
		(location_x p Plate|+01.38|+01.06|+00.01)
		(location_y p Plate|+01.38|+01.06|+00.01)
		(in p Plate|+01.38|+01.06|+00.01)
	)
)

(:action put_inside_Cup|+01.31|+00.93|+00.78
	:parameters None
	:precondition (and
		(is_near c)
		(location p Cup|+01.31|+00.93|+00.78 c)
		(not (holding p Cup|+01.31|+00.93|+00.78))
		(opened Cup|+01.31|+00.93|+00.78)
	)
	:effect (and
		(holding p Cup|+01.31|+00.93|+00.78)
		(not (holding p Cup|+01.31|+00.93|+00.78))
		(location_x p Cup|+01.31|+00.93|+00.78)
		(location_y p Cup|+01.31|+00.93|+00.78)
		(in p Cup|+01.31|+00.93|+00.78)
	)
)

(:action put_inside_Pan|+01.38|+01.74|+00.39
	:parameters None
	:precondition (and
		(is_near c)
		(location p Pan|+01.38|+01.74|+00.39 c)
		(not (holding p Pan|+01.38|+01.74|+00.39))
		(opened Pan|+01.38|+01.74|+00.39)
	)
	:effect (and
		(holding p Pan|+01.38|+01.74|+00.39)
		(not (holding p Pan|+01.38|+01.74|+00.39))
		(location_x p Pan|+01.38|+01.74|+00.39)
		(location_y p Pan|+01.38|+01.74|+00.39)
		(in p Pan|+01.38|+01.74|+00.39)
	)
)

(:action put_inside_Mug|+01.46|+00.93|+01.09
	:parameters None
	:precondition (and
		(is_near c)
		(location p Mug|+01.46|+00.93|+01.09 c)
		(not (holding p Mug|+01.46|+00.93|+01.09))
		(opened Mug|+01.46|+00.93|+01.09)
	)
	:effect (and
		(holding p Mug|+01.46|+00.93|+01.09)
		(not (holding p Mug|+01.46|+00.93|+01.09))
		(location_x p Mug|+01.46|+00.93|+01.09)
		(location_y p Mug|+01.46|+00.93|+01.09)
		(in p Mug|+01.46|+00.93|+01.09)
	)
)

(:action open_Drawer|-00.78|+00.77|+02.38
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+02.38)
		(is_near c)
		(location Drawer|-00.78|+00.77|+02.38 c)
		(not (opened Drawer|-00.78|+00.77|+02.38))
	)
	:effect (and
		(opened Drawer|-00.78|+00.77|+02.38)
	)
)

(:action open_Drawer|+01.37|+00.77|+02.39
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+02.39)
		(is_near c)
		(location Drawer|+01.37|+00.77|+02.39 c)
		(not (opened Drawer|+01.37|+00.77|+02.39))
	)
	:effect (and
		(opened Drawer|+01.37|+00.77|+02.39)
	)
)

(:action open_Cabinet|+01.22|+01.39|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+01.39|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+01.39|+00.59 c)
		(not (opened Cabinet|+01.22|+01.39|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.16)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+01.16 c)
		(not (opened Cabinet|+01.50|+02.11|+01.16))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
)

(:action open_Cabinet|+01.22|+02.01|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+02.01|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+02.01|+00.59 c)
		(not (opened Cabinet|+01.22|+02.01|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
)

(:action open_Cabinet|+01.22|+00.39|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+02.11)
		(is_near c)
		(location Cabinet|+01.22|+00.39|+02.11 c)
		(not (opened Cabinet|+01.22|+00.39|+02.11))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
)

(:action open_Cabinet|+01.22|+00.55|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.55|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+00.55|+00.59 c)
		(not (opened Cabinet|+01.22|+00.55|+00.59))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.16)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+01.16 c)
		(not (opened Cabinet|-00.91|+02.11|+01.16))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
)

(:action open_Cabinet|-00.63|+00.39|+00.63
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+00.63)
		(is_near c)
		(location Cabinet|-00.63|+00.39|+00.63 c)
		(not (opened Cabinet|-00.63|+00.39|+00.63))
	)
	:effect (and
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
)

(:action open_Cabinet|-00.91|+02.05|-00.33
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.05|-00.33)
		(is_near c)
		(location Cabinet|-00.91|+02.05|-00.33 c)
		(not (opened Cabinet|-00.91|+02.05|-00.33))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
)

(:action open_Cabinet|-00.91|+02.11|+00.58
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+00.58)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+00.58 c)
		(not (opened Cabinet|-00.91|+02.11|+00.58))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
)

(:action open_Cabinet|-00.91|+02.11|+02.08
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+02.08)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+02.08 c)
		(not (opened Cabinet|-00.91|+02.11|+02.08))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
)

(:action open_Cabinet|-00.91|+02.11|+01.21
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.21)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+01.21 c)
		(not (opened Cabinet|-00.91|+02.11|+01.21))
	)
	:effect (and
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
)

(:action open_Cabinet|+01.50|+02.11|+02.08
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+02.08)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+02.08 c)
		(not (opened Cabinet|+01.50|+02.11|+02.08))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
)

(:action open_Cabinet|+01.50|+02.11|+01.21
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.21)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+01.21 c)
		(not (opened Cabinet|+01.50|+02.11|+01.21))
	)
	:effect (and
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.69
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.69)
		(is_near c)
		(location Cabinet|+01.50|+01.81|+02.69 c)
		(not (opened Cabinet|+01.50|+01.81|+02.69))
	)
	:effect (and
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
)

(:action open_Cabinet|+01.50|+01.81|+02.10
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.10)
		(is_near c)
		(location Cabinet|+01.50|+01.81|+02.10 c)
		(not (opened Cabinet|+01.50|+01.81|+02.10))
	)
	:effect (and
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
)

(:action open_Cabinet|-00.63|+00.39|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+02.11)
		(is_near c)
		(location Cabinet|-00.63|+00.39|+02.11 c)
		(not (opened Cabinet|-00.63|+00.39|+02.11))
	)
	:effect (and
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.70
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.70)
		(is_near c)
		(location Cabinet|-00.91|+01.81|+02.70 c)
		(not (opened Cabinet|-00.91|+01.81|+02.70))
	)
	:effect (and
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
)

(:action open_Drawer|-00.78|+00.77|+00.92
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+00.92)
		(is_near c)
		(location Drawer|-00.78|+00.77|+00.92 c)
		(not (opened Drawer|-00.78|+00.77|+00.92))
	)
	:effect (and
		(opened Drawer|-00.78|+00.77|+00.92)
	)
)

(:action open_Cabinet|+01.22|+00.39|+00.63
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+00.63)
		(is_near c)
		(location Cabinet|+01.22|+00.39|+00.63 c)
		(not (opened Cabinet|+01.22|+00.39|+00.63))
	)
	:effect (and
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
)

(:action open_Drawer|+01.37|+00.77|+00.92
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+00.92)
		(is_near c)
		(location Drawer|+01.37|+00.77|+00.92 c)
		(not (opened Drawer|+01.37|+00.77|+00.92))
	)
	:effect (and
		(opened Drawer|+01.37|+00.77|+00.92)
	)
)

(:action open_Cabinet|-00.91|+01.81|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.11)
		(is_near c)
		(location Cabinet|-00.91|+01.81|+02.11 c)
		(not (opened Cabinet|-00.91|+01.81|+02.11))
	)
	:effect (and
		(opened Cabinet|-00.91|+01.81|+02.11)
	)
)

(:action open_Fridge|-01.00|+00.00|+00.12
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Fridge|-01.00|+00.00|+00.12)
		(is_near c)
		(location Fridge|-01.00|+00.00|+00.12 c)
		(not (opened Fridge|-01.00|+00.00|+00.12))
	)
	:effect (and
		(opened Fridge|-01.00|+00.00|+00.12)
	)
)

(:action open_Microwave|+01.63|+01.48|+01.65
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Microwave|+01.63|+01.48|+01.65)
		(is_near c)
		(location Microwave|+01.63|+01.48|+01.65 c)
		(not (opened Microwave|+01.63|+01.48|+01.65))
	)
	:effect (and
		(opened Microwave|+01.63|+01.48|+01.65)
	)
)

(:action close_Drawer|-00.78|+00.77|+02.38
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+02.38)
		(is_near c)
		(location Drawer|-00.78|+00.77|+02.38 c)
		(opened Drawer|-00.78|+00.77|+02.38)
	)
	:effect (and
		(not (opened Drawer|-00.78|+00.77|+02.38))
	)
)

(:action close_Drawer|+01.37|+00.77|+02.39
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+02.39)
		(is_near c)
		(location Drawer|+01.37|+00.77|+02.39 c)
		(opened Drawer|+01.37|+00.77|+02.39)
	)
	:effect (and
		(not (opened Drawer|+01.37|+00.77|+02.39))
	)
)

(:action close_Cabinet|+01.22|+01.39|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+01.39|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+01.39|+00.59 c)
		(opened Cabinet|+01.22|+01.39|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+01.39|+00.59))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.16)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+01.16 c)
		(opened Cabinet|+01.50|+02.11|+01.16)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+01.16))
	)
)

(:action close_Cabinet|+01.22|+02.01|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+02.01|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+02.01|+00.59 c)
		(opened Cabinet|+01.22|+02.01|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+02.01|+00.59))
	)
)

(:action close_Cabinet|+01.22|+00.39|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+02.11)
		(is_near c)
		(location Cabinet|+01.22|+00.39|+02.11 c)
		(opened Cabinet|+01.22|+00.39|+02.11)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.39|+02.11))
	)
)

(:action close_Cabinet|+01.22|+00.55|+00.59
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.55|+00.59)
		(is_near c)
		(location Cabinet|+01.22|+00.55|+00.59 c)
		(opened Cabinet|+01.22|+00.55|+00.59)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.55|+00.59))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.16
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.16)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+01.16 c)
		(opened Cabinet|-00.91|+02.11|+01.16)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+01.16))
	)
)

(:action close_Cabinet|-00.63|+00.39|+00.63
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+00.63)
		(is_near c)
		(location Cabinet|-00.63|+00.39|+00.63 c)
		(opened Cabinet|-00.63|+00.39|+00.63)
	)
	:effect (and
		(not (opened Cabinet|-00.63|+00.39|+00.63))
	)
)

(:action close_Cabinet|-00.91|+02.05|-00.33
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.05|-00.33)
		(is_near c)
		(location Cabinet|-00.91|+02.05|-00.33 c)
		(opened Cabinet|-00.91|+02.05|-00.33)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.05|-00.33))
	)
)

(:action close_Cabinet|-00.91|+02.11|+00.58
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+00.58)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+00.58 c)
		(opened Cabinet|-00.91|+02.11|+00.58)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+00.58))
	)
)

(:action close_Cabinet|-00.91|+02.11|+02.08
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+02.08)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+02.08 c)
		(opened Cabinet|-00.91|+02.11|+02.08)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+02.08))
	)
)

(:action close_Cabinet|-00.91|+02.11|+01.21
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+02.11|+01.21)
		(is_near c)
		(location Cabinet|-00.91|+02.11|+01.21 c)
		(opened Cabinet|-00.91|+02.11|+01.21)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+02.11|+01.21))
	)
)

(:action close_Cabinet|+01.50|+02.11|+02.08
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+02.08)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+02.08 c)
		(opened Cabinet|+01.50|+02.11|+02.08)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+02.08))
	)
)

(:action close_Cabinet|+01.50|+02.11|+01.21
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+02.11|+01.21)
		(is_near c)
		(location Cabinet|+01.50|+02.11|+01.21 c)
		(opened Cabinet|+01.50|+02.11|+01.21)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+02.11|+01.21))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.69
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.69)
		(is_near c)
		(location Cabinet|+01.50|+01.81|+02.69 c)
		(opened Cabinet|+01.50|+01.81|+02.69)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+01.81|+02.69))
	)
)

(:action close_Cabinet|+01.50|+01.81|+02.10
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.50|+01.81|+02.10)
		(is_near c)
		(location Cabinet|+01.50|+01.81|+02.10 c)
		(opened Cabinet|+01.50|+01.81|+02.10)
	)
	:effect (and
		(not (opened Cabinet|+01.50|+01.81|+02.10))
	)
)

(:action close_Cabinet|-00.63|+00.39|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.63|+00.39|+02.11)
		(is_near c)
		(location Cabinet|-00.63|+00.39|+02.11 c)
		(opened Cabinet|-00.63|+00.39|+02.11)
	)
	:effect (and
		(not (opened Cabinet|-00.63|+00.39|+02.11))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.70
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.70)
		(is_near c)
		(location Cabinet|-00.91|+01.81|+02.70 c)
		(opened Cabinet|-00.91|+01.81|+02.70)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+01.81|+02.70))
	)
)

(:action close_Drawer|-00.78|+00.77|+00.92
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|-00.78|+00.77|+00.92)
		(is_near c)
		(location Drawer|-00.78|+00.77|+00.92 c)
		(opened Drawer|-00.78|+00.77|+00.92)
	)
	:effect (and
		(not (opened Drawer|-00.78|+00.77|+00.92))
	)
)

(:action close_Cabinet|+01.22|+00.39|+00.63
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|+01.22|+00.39|+00.63)
		(is_near c)
		(location Cabinet|+01.22|+00.39|+00.63 c)
		(opened Cabinet|+01.22|+00.39|+00.63)
	)
	:effect (and
		(not (opened Cabinet|+01.22|+00.39|+00.63))
	)
)

(:action close_Drawer|+01.37|+00.77|+00.92
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Drawer|+01.37|+00.77|+00.92)
		(is_near c)
		(location Drawer|+01.37|+00.77|+00.92 c)
		(opened Drawer|+01.37|+00.77|+00.92)
	)
	:effect (and
		(not (opened Drawer|+01.37|+00.77|+00.92))
	)
)

(:action close_Cabinet|-00.91|+01.81|+02.11
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Cabinet|-00.91|+01.81|+02.11)
		(is_near c)
		(location Cabinet|-00.91|+01.81|+02.11 c)
		(opened Cabinet|-00.91|+01.81|+02.11)
	)
	:effect (and
		(not (opened Cabinet|-00.91|+01.81|+02.11))
	)
)

(:action close_Fridge|-01.00|+00.00|+00.12
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Fridge|-01.00|+00.00|+00.12)
		(is_near c)
		(location Fridge|-01.00|+00.00|+00.12 c)
		(opened Fridge|-01.00|+00.00|+00.12)
	)
	:effect (and
		(not (opened Fridge|-01.00|+00.00|+00.12))
	)
)

(:action close_Microwave|+01.63|+01.48|+01.65
	:parameters ( ?c - cell)
	:precondition (and
		(is_openable Microwave|+01.63|+01.48|+01.65)
		(is_near c)
		(location Microwave|+01.63|+01.48|+01.65 c)
		(opened Microwave|+01.63|+01.48|+01.65)
	)
	:effect (and
		(not (opened Microwave|+01.63|+01.48|+01.65))
	)
)




)