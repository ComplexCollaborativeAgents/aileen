(define (problem bread_in_refigerator)
(:domain ai_thor)

(:objects
c_Fridge|-01.00|+00.00|+00.12 c_Bread|-00.92|+00.99|+02.27 c_thor - cell
Fridge|-01.00|+00.00|+00.12 Bread|-00.92|+00.99|+02.27 - interactable
)

(:init
	(location Fridge|-01.00|+00.00|+00.12 c_Fridge|-01.00|+00.00|+00.12)
	(location Bread|-00.92|+00.99|+02.27 c_Bread|-00.92|+00.99|+02.27)
	(is_reachable c_Fridge|-01.00|+00.00|+00.12)
	(is_reachable c_Bread|-00.92|+00.99|+02.27)
	(is_reachable c_thor)
	(robot_location c_thor)
	(is_openable Fridge|-01.00|+00.00|+00.12)
	(is_pickable Bread|-00.92|+00.99|+02.27)
	(is_receptacle Fridge|-01.00|+00.00|+00.12)
)

(:goal (and
		(in Fridge|-01.00|+00.00|+00.12 Bread|-00.92|+00.99|+02.27)
		(not (opened Fridge|-01.00|+00.00|+00.12))
	)
)
)