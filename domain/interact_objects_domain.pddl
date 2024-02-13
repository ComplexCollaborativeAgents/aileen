(define (domain thor_interact)
(:requirements
    :durative-actions
    :equality
    :negative-preconditions
    :numeric-fluents
    :object-fluents
    :typing
)

(:types
cells
interactable
)

; (:constants

; )

(:predicates
(is_reachable ?c - cell)
(is_pickable ?p - interactable)
(is_openable ?p - interactable)
(is_near ?c - cell)
(location ?p - interactable ?c - cell)
(holding ?p - interactable)
(opened ?p - interactable)
(inside ?p1 ?p2 - interactable)
)

(:functions
(robot_x)
(robot_y)
(cell_x ?c - cell)
(cell_y ?c - cell)
(location_x ?p - interactable)
(location_y ?p - interactable)
)

(:action teleport
    :parameters (?from ?to - cell)
    :precondition (and 
        (is_reachable ?to) 
        (= (robot_x) (cell_x ?from))
        (= (robot_y) (cell_y ?from))
    )
    :effect (and 
        (assign (robot_x) (cell_x ?to))
        (assign (robot_y) (cell_y ?to))
    )
)

(:action pick
    :parameters (?p - interactable ?c - cell)
    :precondition (and 
        (location ?p ?c)
        (is_near ?c)
        (not (holding ?p))
    )
    :effect (and
        (holding ?p)
        (not (location ?p ?c))
        (= (location_x ?p) (robot_x))
        (= (location_y ?p) (robot_y)) 
    )
)

(:action put
    :parameters (?p - interactable ?c - cell)
    :precondition (and 
        (= (location_x ?p) (robot_x))
        (= (location_y ?p) (robot_y))
        (is_near ?c)
        (holding ?p)
    )
    :effect (and
        (not (holding ?p))
        (not (location ?p ?c))
        (= (location_x ?p) (robot_x))
        (= (location_y ?p) (robot_y)) 
    )
)

(:action put_inside ; put p1 inside object p2
    :parameters (?p1 ?p2 - interactable ?c - cell)
    :precondition (and 
        (= (location_x ?p1) (robot_x))
        (= (location_y ?p1) (robot_y))
        (opened ?p2)
        (is_near ?c)
        (holding ?p1)
    )
    :effect (and
        (not (holding ?p1))
        (location ?p1 ?c)
        (inside ?p1 ?p2)
        (= (location_x ?p1) (cell_x ?c))
        (= (location_y ?p1) (cell_y ?c)) 
    )
)

(:action open
    :parameters (?p - interactable ?c - cell)
    :precondition (and 
        (location ?p ?c)
        (is_near ?c)
        (not (opened ?p))
    )
    :effect (and
        (opened ?p)
    )
)

(:action close
    :parameters (?p - interactable ?c - cell)
    :precondition (and
        (location ?p ?c)
        (opened ?p)
        (is_near ?c)
    )
    :effect (
        (not (opened ?p))
    )
)
)
