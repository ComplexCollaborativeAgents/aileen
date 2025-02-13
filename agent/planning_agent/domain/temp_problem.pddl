(define (problem temp-problem)
(:domain ai_thor)

(:objects
c_Apple|+01.41|+00.98|+02.13 c_Fridge|-01.00|+00.00|+00.12 c_thor - cell
Apple|+01.41|+00.98|+02.13 Fridge|-01.00|+00.00|+00.12 - interactable
)

(:init
	(location Apple|+01.41|+00.98|+02.13 c_Apple|+01.41|+00.98|+02.13)
	(location Fridge|-01.00|+00.00|+00.12 c_Fridge|-01.00|+00.00|+00.12)
	(is_reachable c_Apple|+01.41|+00.98|+02.13)
	(is_reachable c_Fridge|-01.00|+00.00|+00.12)
	(is_reachable c_thor)
	(robot_location c_thor)
	(is_openable Fridge|-01.00|+00.00|+00.12)
	(is_pickable Apple|+01.41|+00.98|+02.13)
	(is_receptacle Fridge|-01.00|+00.00|+00.12)
)

(:goal (and
		(and  (in Fridge|-01.00|+00.00|+00.12 Apple|+01.41|+00.98|+02.13) (not (opened Fridge|-01.00|+00.00|+00.12)))
	)
)
)