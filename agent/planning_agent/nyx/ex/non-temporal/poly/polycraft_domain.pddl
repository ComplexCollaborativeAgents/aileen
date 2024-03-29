(define (domain polycraft)
	(:requirements :typing :disjunctive-preconditions :fluents :negative-preconditions)
	(:types cell)
	(:predicates
		(isAccessible ?c - cell)
		(trader_43_at ?c - cell)
		(trader_44_at ?c - cell)
		)
	(:functions
		(cell_type ?c - cell)
		(selectedItem)
		(Steve_x)
		(Steve_z)
		(cell_x ?c - cell)
		(cell_z ?c - cell)
		(count_polycraft_block_of_platinum)
		(count_polycraft_block_of_titanium)
		(count_minecraft_crafting_table)
		(count_minecraft_diamond)
		(count_minecraft_diamond_block)
		(count_minecraft_iron_pickaxe)
		(count_polycraft_key)
		(count_minecraft_log)
		(count_minecraft_planks)
		(count_minecraft_sapling)
		(count_minecraft_stick)
		(count_polycraft_sack_polyisoprene_pellets)
		(count_polycraft_tree_tap)
		(count_polycraft_wooden_pogo_stick)
		(count_minecraft_wooden_axe)
		)
	(:event cell_accessible
		:parameters (?c - cell)
		:precondition (and 
			(not (isAccessible ?c) )
			(or (and (= (cell_x ?c)  (Steve_x) )
				(= (cell_z ?c)  (+ (Steve_z)  1)
					)
				)
			(and (= (cell_x ?c)  (Steve_x) )
				(= (cell_z ?c)  (- (Steve_z)  1)
					)
				)
			(and (= (cell_z ?c)  (Steve_z) )
				(= (cell_x ?c)  (+ (Steve_x)  1)
					)
				)
			(and (= (cell_z ?c)  (Steve_z) )
				(= (cell_x ?c)  (- (Steve_x)  1)
					)
				)
			)
			) 
		:effect (and 
			(isAccessible ?c)
			) 
		)  
	(:action select_minecraft_iron_pickaxe
		:precondition (and 
			(not (= (selectedItem)  5)
				)
			(>= (count_minecraft_iron_pickaxe)  1)
			) 
		:effect (and 
			(assign (selectedItem)  5)
			) 
		)  
	(:action select_polycraft_key
		:precondition (and 
			(not (= (selectedItem)  6)
				)
			(>= (count_polycraft_key)  1)
			) 
		:effect (and 
			(assign (selectedItem)  6)
			) 
		)  
	(:action select_minecraft_wooden_axe
		:precondition (and 
			(not (= (selectedItem)  14)
				)
			(>= (count_minecraft_wooden_axe)  1)
			) 
		:effect (and 
			(assign (selectedItem)  14)
			) 
		)  
	(:action break_minecraft_log
		:parameters (?c - cell)
		:precondition (and 
			(isAccessible ?c)
			(= (cell_type ?c)  5)
			) 
		:effect (and 
			(increase (count_minecraft_log)  2)
			(assign (cell_type ?c)  0)
			(assign (Steve_x)  (cell_x ?c) )
			(assign (Steve_z)  (cell_z ?c) )
			) 
		)  
	(:action break_polycraft_block_of_platinum
		:parameters (?c - cell)
		:precondition (and 
			(isAccessible ?c)
			(= (cell_type ?c)  2)
			(= (selectedItem)  5)
			) 
		:effect (and 
			(increase (count_polycraft_block_of_platinum)  1)
			(assign (cell_type ?c)  0)
			(assign (Steve_x)  (cell_x ?c) )
			(assign (Steve_z)  (cell_z ?c) )
			) 
		)  
	(:action break_minecraft_diamond_ore
		:parameters (?c - cell)
		:precondition (and 
			(isAccessible ?c)
			(= (cell_type ?c)  4)
			(= (selectedItem)  5)
			) 
		:effect (and 
			(increase (count_minecraft_diamond)  9)
			(assign (cell_type ?c)  0)
			(assign (Steve_x)  (cell_x ?c) )
			(assign (Steve_z)  (cell_z ?c) )
			) 
		)  
	(:action craft_recipe_0_for_polycraft_tree_tap
		:parameters (?from - cell)
		:precondition (and 
			(isAccessible ?from)
			(= (cell_type ?from)  3)
			(>= (count_minecraft_planks)  5)
			(>= (count_minecraft_stick)  1)
			) 
		:effect (and 
			(decrease (count_minecraft_planks)  5)
			(decrease (count_minecraft_stick)  1)
			(increase (count_polycraft_tree_tap)  1)
			) 
		)  
	(:action craft_recipe_1_for_polycraft_wooden_pogo_stick
		:parameters (?from - cell)
		:precondition (and 
			(isAccessible ?from)
			(= (cell_type ?from)  3)
			(>= (count_minecraft_stick)  2)
			(>= (count_polycraft_block_of_titanium)  2)
			(>= (count_minecraft_diamond_block)  2)
			(>= (count_polycraft_sack_polyisoprene_pellets)  1)
			) 
		:effect (and 
			(decrease (count_minecraft_stick)  2)
			(decrease (count_polycraft_block_of_titanium)  2)
			(decrease (count_minecraft_diamond_block)  2)
			(decrease (count_polycraft_sack_polyisoprene_pellets)  1)
			(increase (count_polycraft_wooden_pogo_stick)  1)
			) 
		)  
	(:action craft_recipe_2_for_4_minecraft_planks
		:precondition (and 
			(>= (count_minecraft_log)  1)
			) 
		:effect (and 
			(decrease (count_minecraft_log)  1)
			(increase (count_minecraft_planks)  4)
			) 
		)  
	(:action craft_recipe_3_for_4_minecraft_stick
		:precondition (and 
			(>= (count_minecraft_planks)  2)
			) 
		:effect (and 
			(decrease (count_minecraft_planks)  2)
			(increase (count_minecraft_stick)  4)
			) 
		)  
	(:action craft_recipe_4_for_minecraft_crafting_table
		:parameters (?from - cell)
		:precondition (and 
			(isAccessible ?from)
			(= (cell_type ?from)  3)
			(>= (count_minecraft_planks)  4)
			) 
		:effect (and 
			(decrease (count_minecraft_planks)  4)
			(increase (count_minecraft_crafting_table)  1)
			) 
		)  
	(:action craft_recipe_5_for_minecraft_diamond_block
		:parameters (?from - cell)
		:precondition (and 
			(isAccessible ?from)
			(= (cell_type ?from)  3)
			(>= (count_minecraft_diamond)  9)
			) 
		:effect (and 
			(decrease (count_minecraft_diamond)  9)
			(increase (count_minecraft_diamond_block)  1)
			) 
		)  
	(:action craft_recipe_6_for_minecraft_wooden_axe
		:parameters (?from - cell)
		:precondition (and 
			(isAccessible ?from)
			(= (cell_type ?from)  3)
			(>= (count_minecraft_planks)  3)
			(>= (count_minecraft_stick)  2)
			) 
		:effect (and 
			(decrease (count_minecraft_planks)  3)
			(decrease (count_minecraft_stick)  2)
			(increase (count_minecraft_wooden_axe)  1)
			) 
		)  
	(:action trade_recipe_44_0
		:parameters (?trader_loc - cell)
		:precondition (and 
			(isAccessible ?trader_loc)
			(>= (count_polycraft_block_of_platinum)  2)
			(trader_44_at ?trader_loc)
			) 
		:effect (and 
			(decrease (count_polycraft_block_of_platinum)  2)
			(increase (count_minecraft_diamond)  9)
			) 
		)  
	(:action trade_recipe_44_1
		:parameters (?trader_loc - cell)
		:precondition (and 
			(isAccessible ?trader_loc)
			(>= (count_minecraft_log)  10)
			(trader_44_at ?trader_loc)
			) 
		:effect (and 
			(decrease (count_minecraft_log)  10)
			(increase (count_polycraft_block_of_titanium)  1)
			) 
		)  
	(:action trade_recipe_43_0
		:parameters (?trader_loc - cell)
		:precondition (and 
			(isAccessible ?trader_loc)
			(>= (count_minecraft_diamond)  18)
			(trader_43_at ?trader_loc)
			) 
		:effect (and 
			(decrease (count_minecraft_diamond)  18)
			(increase (count_polycraft_block_of_platinum)  1)
			) 
		)  
	(:action trade_recipe_43_1
		:parameters (?trader_loc - cell)
		:precondition (and 
			(isAccessible ?trader_loc)
			(>= (count_polycraft_block_of_platinum)  1)
			(trader_43_at ?trader_loc)
			) 
		:effect (and 
			(decrease (count_polycraft_block_of_platinum)  1)
			(increase (count_polycraft_block_of_titanium)  1)
			) 
		)  
	(:action place_tree_tap_34,17,56_35,17,56
		:precondition (and 
			(isAccessible cell_34_17_56)
			(= (cell_type cell_34_17_56)  5)
			(isAccessible cell_35_17_56)
			(= (cell_type cell_35_17_56)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_35_17_56)  8)
			) 
		)  
	(:action place_tree_tap_34,17,56_33,17,56
		:precondition (and 
			(isAccessible cell_34_17_56)
			(= (cell_type cell_34_17_56)  5)
			(isAccessible cell_33_17_56)
			(= (cell_type cell_33_17_56)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_33_17_56)  8)
			) 
		)  
	(:action place_tree_tap_34,17,56_34,17,57
		:precondition (and 
			(isAccessible cell_34_17_56)
			(= (cell_type cell_34_17_56)  5)
			(isAccessible cell_34_17_57)
			(= (cell_type cell_34_17_57)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_34_17_57)  8)
			) 
		)  
	(:action place_tree_tap_34,17,56_34,17,55
		:precondition (and 
			(isAccessible cell_34_17_56)
			(= (cell_type cell_34_17_56)  5)
			(isAccessible cell_34_17_55)
			(= (cell_type cell_34_17_55)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_34_17_55)  8)
			) 
		)  
	(:action place_tree_tap_34,17,64_35,17,64
		:precondition (and 
			(isAccessible cell_34_17_64)
			(= (cell_type cell_34_17_64)  5)
			(isAccessible cell_35_17_64)
			(= (cell_type cell_35_17_64)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_35_17_64)  8)
			) 
		)  
	(:action place_tree_tap_34,17,64_33,17,64
		:precondition (and 
			(isAccessible cell_34_17_64)
			(= (cell_type cell_34_17_64)  5)
			(isAccessible cell_33_17_64)
			(= (cell_type cell_33_17_64)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_33_17_64)  8)
			) 
		)  
	(:action place_tree_tap_34,17,64_34,17,65
		:precondition (and 
			(isAccessible cell_34_17_64)
			(= (cell_type cell_34_17_64)  5)
			(isAccessible cell_34_17_65)
			(= (cell_type cell_34_17_65)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_34_17_65)  8)
			) 
		)  
	(:action place_tree_tap_34,17,64_34,17,63
		:precondition (and 
			(isAccessible cell_34_17_64)
			(= (cell_type cell_34_17_64)  5)
			(isAccessible cell_34_17_63)
			(= (cell_type cell_34_17_63)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_34_17_63)  8)
			) 
		)  
	(:action place_tree_tap_38,17,64_39,17,64
		:precondition (and 
			(isAccessible cell_38_17_64)
			(= (cell_type cell_38_17_64)  5)
			(isAccessible cell_39_17_64)
			(= (cell_type cell_39_17_64)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_39_17_64)  8)
			) 
		)  
	(:action place_tree_tap_38,17,64_37,17,64
		:precondition (and 
			(isAccessible cell_38_17_64)
			(= (cell_type cell_38_17_64)  5)
			(isAccessible cell_37_17_64)
			(= (cell_type cell_37_17_64)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_37_17_64)  8)
			) 
		)  
	(:action place_tree_tap_38,17,64_38,17,65
		:precondition (and 
			(isAccessible cell_38_17_64)
			(= (cell_type cell_38_17_64)  5)
			(isAccessible cell_38_17_65)
			(= (cell_type cell_38_17_65)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_38_17_65)  8)
			) 
		)  
	(:action place_tree_tap_38,17,64_38,17,63
		:precondition (and 
			(isAccessible cell_38_17_64)
			(= (cell_type cell_38_17_64)  5)
			(isAccessible cell_38_17_63)
			(= (cell_type cell_38_17_63)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_38_17_63)  8)
			) 
		)  
	(:action place_tree_tap_50,17,49_51,17,49
		:precondition (and 
			(isAccessible cell_50_17_49)
			(= (cell_type cell_50_17_49)  5)
			(isAccessible cell_51_17_49)
			(= (cell_type cell_51_17_49)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_51_17_49)  8)
			) 
		)  
	(:action place_tree_tap_50,17,49_49,17,49
		:precondition (and 
			(isAccessible cell_50_17_49)
			(= (cell_type cell_50_17_49)  5)
			(isAccessible cell_49_17_49)
			(= (cell_type cell_49_17_49)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_49_17_49)  8)
			) 
		)  
	(:action place_tree_tap_50,17,49_50,17,50
		:precondition (and 
			(isAccessible cell_50_17_49)
			(= (cell_type cell_50_17_49)  5)
			(isAccessible cell_50_17_50)
			(= (cell_type cell_50_17_50)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_50_17_50)  8)
			) 
		)  
	(:action place_tree_tap_50,17,49_50,17,48
		:precondition (and 
			(isAccessible cell_50_17_49)
			(= (cell_type cell_50_17_49)  5)
			(isAccessible cell_50_17_48)
			(= (cell_type cell_50_17_48)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_50_17_48)  8)
			) 
		)  
	(:action place_tree_tap_60,17,55_61,17,55
		:precondition (and 
			(isAccessible cell_60_17_55)
			(= (cell_type cell_60_17_55)  5)
			(isAccessible cell_61_17_55)
			(= (cell_type cell_61_17_55)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_61_17_55)  8)
			) 
		)  
	(:action place_tree_tap_60,17,55_59,17,55
		:precondition (and 
			(isAccessible cell_60_17_55)
			(= (cell_type cell_60_17_55)  5)
			(isAccessible cell_59_17_55)
			(= (cell_type cell_59_17_55)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_59_17_55)  8)
			) 
		)  
	(:action place_tree_tap_60,17,55_60,17,56
		:precondition (and 
			(isAccessible cell_60_17_55)
			(= (cell_type cell_60_17_55)  5)
			(isAccessible cell_60_17_56)
			(= (cell_type cell_60_17_56)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_60_17_56)  8)
			) 
		)  
	(:action place_tree_tap_60,17,55_60,17,54
		:precondition (and 
			(isAccessible cell_60_17_55)
			(= (cell_type cell_60_17_55)  5)
			(isAccessible cell_60_17_54)
			(= (cell_type cell_60_17_54)  0)
			(>= (count_polycraft_tree_tap)  1)
			) 
		:effect (and 
			(decrease (count_polycraft_tree_tap)  1)
			(assign (cell_type cell_60_17_54)  8)
			) 
		)  
	(:action teleport_to
		:parameters (?to - cell)
		:precondition (and 
			(isAccessible ?to)
			(= (cell_type ?to)  0)
			(or (and (= (cell_x ?to)  (Steve_x) )
				(= (cell_z ?to)  (+ (Steve_z)  1)
					)
				)
			(and (= (cell_x ?to)  (Steve_x) )
				(= (cell_z ?to)  (- (Steve_z)  1)
					)
				)
			(and (= (cell_z ?to)  (Steve_z) )
				(= (cell_x ?to)  (+ (Steve_x)  1)
					)
				)
			(and (= (cell_z ?to)  (Steve_z) )
				(= (cell_x ?to)  (- (Steve_x)  1)
					)
				)
			)
			) 
		:effect (and 
			(assign (Steve_x)  (cell_x ?to) )
			(assign (Steve_z)  (cell_z ?to) )
			) 
		)  
	(:action collect_from_tree_tap
		:parameters (?c - cell)
		:precondition (and 
			(= (cell_type ?c)  8)
			) 
		:effect (and 
			(increase (count_polycraft_sack_polyisoprene_pellets)  1)
			) 
		)  
	)
