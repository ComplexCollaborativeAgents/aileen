(define (domain blocksworld)
  (:requirements :strips :negative-preconditions)
  (:predicates (clear ?x) (onTable ?x) (holding ?x) (on ?x ?y) (equal ?x ?y) (busy_gripper))

  (:action pickup
    :parameters (?ob)
    :precondition (and (clear ?ob) (onTable ?ob) (not (busy_gripper)) )
    :effect (and (holding ?ob) (not (clear ?ob)) (not (onTable ?ob)) (busy_gripper))
  )

  (:action putdown
    :parameters (?ob)
    :precondition (holding ?ob)
    :effect (and (clear ?ob) (onTable ?ob) (not (holding ?ob)) (not (busy_gripper)))
  )

  (:action stack
    :parameters (?ob ?underob)
    :precondition (and (clear ?underob) (holding ?ob) (not (equal ?ob ?underob)))
    :effect (and (clear ?ob) (on ?ob ?underob) (not (clear ?underob)) (not (holding ?ob)) (not (busy_gripper)))
  )

  (:action unstack
    :parameters (?ob ?underob)
    :precondition (and (on ?ob ?underob) (clear ?ob) (not (equal ?ob ?underob)) (not (busy_gripper)))
    :effect (and (holding ?ob) (clear ?underob) (not (on ?ob ?underob)) (not (clear ?ob)) (busy_gripper))
  )
)