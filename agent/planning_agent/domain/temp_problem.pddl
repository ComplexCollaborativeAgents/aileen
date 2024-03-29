(define (problem bread_in_refigerator)
(:domain ai_thor)

(:objects
c_Fridge|-01.00|+00.00|+00.12 c_Apple|+01.41|+00.98|+02.13 c_thor - cell
Fridge|-01.00|+00.00|+00.12 Apple|+01.41|+00.98|+02.13 - interactable
)

(:init
	(location Fridge|-01.00|+00.00|+00.12 c_Fridge|-01.00|+00.00|+00.12)
	(location Apple|+01.41|+00.98|+02.13 c_Apple|+01.41|+00.98|+02.13)
	(is_reachable c_Fridge|-01.00|+00.00|+00.12)
	(is_reachable c_Apple|+01.41|+00.98|+02.13)
	(is_reachable c_thor)
	(robot_location c_thor)
	(is_openable Fridge|-01.00|+00.00|+00.12)
	(is_pickable Apple|+01.41|+00.98|+02.13)
	(is_receptacle Fridge|-01.00|+00.00|+00.12)
)

(:goal (and
		(in Fridge|-01.00|+00.00|+00.12 Apple|+01.41|+00.98|+02.13)
	)
)
)