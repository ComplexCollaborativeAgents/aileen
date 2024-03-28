(define (domain grid-minecraft)
(:requirements :adl :strips :typing :fluents)
(:types cell)
(:predicates
  (steve_at ?c - cell)
  (drop_at ?c - cell)
  (drops_collected)
) ;predicates
(:functions
  (x_cell ?c - cell)
  (z_cell ?c - cell)
  (cell_type ?c - cell)  ;  0=WALKABLE_AND_CLEAR 1=LIQUID 2=SOLID 3=LOG
  ; (drop_type ?c - cell)
  (total_inventory)
) ;functions

(:action move-north
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (z_cell ?start) (+ (z_cell ?end) 1)) (= (x_cell ?start) (x_cell ?end)) (= (cell_type ?end) 0) )
  :effect (and  (not (steve_at ?start)) (steve_at ?end) )
)

(:action move-south
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (+ (z_cell ?start) 1) (z_cell ?end)) (= (x_cell ?start) (x_cell ?end)) (= (cell_type ?end) 0) )
  :effect (and  (not (steve_at ?start)) (steve_at ?end) )
)

(:action move-east
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (+ (x_cell ?start) 1) (x_cell ?end)) (= (z_cell ?start) (z_cell ?end)) (= (cell_type ?end) 0) )
  :effect (and  (not (steve_at ?start)) (steve_at ?end) )
)

(:action move-west
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (x_cell ?start) (+ (x_cell ?end) 1)) (= (z_cell ?start) (z_cell ?end)) (= (cell_type ?end) 0) )
  :effect (and  (not (steve_at ?start)) (steve_at ?end) )
)

(:action make-bridge
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (z_cell ?start) (+ (z_cell ?end ) 1)) (= (x_cell ?start) (x_cell ?end)) (= (cell_type ?end) 1) )
  :effect (and (assign (cell_type ?end) 0) )
)

(:action mine-through
  :parameters (?start - cell ?end - cell)
  :precondition (and (steve_at ?start) (= (z_cell ?start) (+ (z_cell ?end) 1)) (= (x_cell ?start) (x_cell ?end)) (= (cell_type ?end) 2) )
  :effect (and (assign (cell_type ?end) 0) )
)

; (:event drops-appear
;   :parameters (?start - cell ?drop_cell - cell)
;   :precondition (and (steve_at ?start) (drop_at ?drop_cell) (< (- (z_cell ?drop_cell) (z_cell ?start)) 5) (< (- (x_cell ?start) (x_cell ?drop_cell)) 5) (< (- (x_cell ?drop_cell) (x_cell ?start)) 5))
;   :effect (and (not (drops_collected)) )
; )

(:event drop_collected
  :parameters (?current_cell - cell)
  :precondition (and (steve_at ?current_cell) (drop_at ?current_cell) )
  :effect (and (drops_collected) (not (drop_at ?current_cell)) (assign (total_inventory) (+ (total_inventory) 1)) )
)

) ;domain

